using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Data;
using Locator.Models;
using Locator.BLL;
using Highchart;
using Highchart.Core;
using Highchart.Core.Data.Chart;
using System.Collections.ObjectModel;
using System.Collections;

namespace Locator.Pages
{
    public partial class CheckFuel : System.Web.UI.Page
    {
        private User _userObj = null;
       Dictionary<int,double> _fuel = new Dictionary<int, double>();
        protected void Page_Load(object sender, EventArgs e)
        {
            _userObj = Common.GetUserSession();

            if (_userObj == null)
                Common.RedirectToLoginPage();
            else
            {
                loadUserFuels();
            }
            if (!Page.IsPostBack)
            {
                LoadVehicleMakes();
                BindUserFuelDetails();
               // LoadUserFuelChart();
            }

            if (_userObj != null)
            {
                if (_userObj.MakeId != 0)
                {
                    
                    lstMake.SelectedValue = _userObj.MakeId.ToString();
                    LoadVehicleModels();
                    lstModel.SelectedValue = _userObj.ModelId.ToString();
                    txtYear.Text = _userObj.Year.ToString();
                    LoadCarDetails();

                    btnSaveCar.Visible = false;
                }
            }
            LoadUserFuelChart();
        }

        private void LoadCarDetails()
        {
            int makeId = Convert.ToInt32(lstMake.SelectedValue);
            int modelId = Convert.ToInt32(lstModel.SelectedValue);
            int year = 0;
            if (!string.IsNullOrEmpty(txtYear.Text ))
            {
                year = Convert.ToInt32(txtYear.Text);
            }

            VehicleBLL vehicleBllObj = new VehicleBLL();
            CarDetails carDtls = vehicleBllObj.GetCarDetails(makeId, modelId,year);

            if (carDtls != null)
            {
                hiddCity08.Value = carDtls.CityMPGFuelType1.ToString();
                hiddCityA08.Value = carDtls.CityMPGFuelType2.ToString();

                hiddHighway08.Value = carDtls.HighwayMPGFuelType1.ToString();
                hiddHighwayA08.Value = carDtls.HighwayMPGFuelType2.ToString();

                hiddComb08.Value = carDtls.ComboMPGFuelType1.ToString();
                hiddCombA08.Value = carDtls.ComboMPGFuelType2.ToString();
            }
           // LoadUserFuelChart();
            LoadCarChart();
        }

        private void LoadVehicleMakes()
        {
            List<VehicleMakes> vehicleMakes = new VehicleBLL().GetVehicleMakes();

            if (vehicleMakes != null)
            {
                foreach (var make in vehicleMakes)
                {
                    ListItem lstItem = new ListItem();
                    lstItem.Text = make.VehicleMake;
                    lstItem.Value = make.MakeId.ToString();

                    lstMake.Items.Add(lstItem);
                }
            }
        }

        private void LoadVehicleModels()
        {
            int vehicleMakeId = Convert.ToInt32(lstMake.SelectedValue);

            List<VehicleModels> vehicleModels = new VehicleBLL().GetVehicleModels(vehicleMakeId);

            if (vehicleModels != null)
            {
                lstModel.Items.Clear();

                foreach (var model in vehicleModels)
                {
                    ListItem lstItem = new ListItem();
                    lstItem.Text = model.VehicleModel;
                    lstItem.Value = model.ModelId.ToString();

                    lstModel.Items.Add(lstItem);
                }
            }
        }


        protected void gvDetails_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvDetails.EditIndex = e.NewEditIndex;
            BindUserFuelDetails();
            LoadUserFuelChart();
        }
        protected void gvDetails_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int fuelId = Convert.ToInt32(gvDetails.DataKeys[e.RowIndex].Value.ToString());

            TextBox txtOdometer = (TextBox)gvDetails.Rows[e.RowIndex].FindControl("txtOdometer");
            TextBox txtGallons = (TextBox)gvDetails.Rows[e.RowIndex].FindControl("txtGallons");
            TextBox txtPricePerGallon = (TextBox)gvDetails.Rows[e.RowIndex].FindControl("txtPricePerGallon");
            TextBox txtCost = (TextBox)gvDetails.Rows[e.RowIndex].FindControl("txtCost");
            TextBox txtFillDate = (TextBox)gvDetails.Rows[e.RowIndex].FindControl("txtFillDate");
            TextBox txtAvgMilesPerGallon = (TextBox)gvDetails.Rows[e.RowIndex].FindControl("txtAvgMilesPerGallon");

            Fuel userFuel = new Fuel();

            userFuel.FuelId = fuelId;
            userFuel.UserId = _userObj.UserId;
            userFuel.Odometer = Convert.ToDouble(txtOdometer.Text);
            userFuel.Gallons = Convert.ToDouble(txtGallons.Text);
            userFuel.PricePerGallon = Convert.ToDouble(txtPricePerGallon.Text);
            userFuel.TotalCost = Convert.ToDouble(txtCost.Text);
            userFuel.FillDate = Convert.ToDateTime(txtFillDate.Text);
            userFuel.AvgMilesPerGallon = Convert.ToDouble(txtAvgMilesPerGallon.Text);

            FuelBLL fuelBLL = new FuelBLL();

            fuelBLL.UpdateUserFuel(userFuel);

            lblresult.ForeColor = Color.Green;
            lblresult.Text = " Details Updated successfully";
            gvDetails.EditIndex = -1;
            BindUserFuelDetails();
            LoadUserFuelChart();
        }
        protected void gvDetails_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvDetails.EditIndex = -1;
            BindUserFuelDetails();
            LoadUserFuelChart();
        }
        protected void gvDetails_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int fuelId = Convert.ToInt32(gvDetails.DataKeys[e.RowIndex].Values["FuelId"].ToString());

            FuelBLL fuelBll = new FuelBLL();

            fuelBll.DeleteUserFuel(fuelId);
            lblresult.ForeColor = Color.Red;
            lblresult.Text = " details deleted successfully";
            BindUserFuelDetails();
            LoadUserFuelChart();
        }
        protected void gvDetails_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("AddNew"))
            {
                
                TextBox txtOdometer = (TextBox)gvDetails.FooterRow.FindControl("txtFtrOdometer");
                if (_fuel.Count > 0)
                {
                    var lastitem = _fuel.Last();
                    if (Convert.ToDouble(txtOdometer.Text) < lastitem.Value)
                    {
                        lblresult.Text = "Please Enter the Odometer reading greater than the first value.";
                        txtOdometer.Text = "";
                        lblresult.ForeColor = Color.Red;
                        return;
                    }
                }
                
                TextBox txtGallons = (TextBox)gvDetails.FooterRow.FindControl("txtFtrGallons");
                TextBox txtPricePerGallon = (TextBox)gvDetails.FooterRow.FindControl("txtFtrPricePerGallon");
                //TextBox txtCost = (TextBox)gvDetails.FooterRow.FindControl("txtFtrCost");
                var txtCost = Convert.ToDouble((txtGallons.Text))*Convert.ToDouble((txtPricePerGallon.Text));
                TextBox txtFillDate = (TextBox)gvDetails.FooterRow.FindControl("txtFtrFillDate");
                //TextBox txtAvgMilesPerGallon = (TextBox)gvDetails.FooterRow.FindControl("txtFtrAvgMilesPerGallon");
                var txtAvgMilesPerGallon = 0.0;
                var count = _fuel.Count;
                if (_fuel.Count == 0)
                {
                     txtAvgMilesPerGallon = 0.0;
                }
                else
                {
                    var lastfuelitem = _fuel.Last();
                    txtAvgMilesPerGallon = (Convert.ToDouble(txtOdometer.Text) - (lastfuelitem.Value)) / Convert.ToDouble(txtGallons.Text);
                }
                
                Fuel userFuel = new Fuel();

                userFuel.UserId = _userObj.UserId;
                userFuel.Odometer = Convert.ToDouble(txtOdometer.Text);
                userFuel.Gallons = Convert.ToDouble(txtGallons.Text);
                userFuel.PricePerGallon = Convert.ToDouble(txtPricePerGallon.Text);
                userFuel.TotalCost = Convert.ToDouble(txtCost);
                userFuel.FillDate = Convert.ToDateTime(txtFillDate.Text);
                userFuel.AvgMilesPerGallon = Convert.ToDouble(txtAvgMilesPerGallon);

                FuelBLL fuelBLL = new FuelBLL();

                fuelBLL.InsertUserFuel(userFuel);

                lblresult.ForeColor = Color.Green;
                lblresult.Text = " Details inserted successfully";
                BindUserFuelDetails();
                LoadUserFuelChart();
            }

        }

        protected void lstMake_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadVehicleModels();
            LoadCarDetails();
        }


        private void BindUserFuelDetails()
        {
            FuelBLL fuelBll = new FuelBLL();

            if (_userObj != null)
            {
                List<Fuel> fuelList = fuelBll.GetUserFuels(_userObj.UserId);

                bool isHideFirstRow = false;

                if (fuelList != null)
                {
                    gvDetails.DataSource = fuelList;
                    gvDetails.DataBind();
                }
                else
                {
                    isHideFirstRow = true;
                    List<Fuel> fuels = new List<Fuel>();
                    fuels.Add(new Fuel());
                    gvDetails.DataSource = fuels;
                    gvDetails.DataBind();
                    gvDetails.ShowFooter = true;
                }

                if (isHideFirstRow)
                {
                    //Hide the first row if it's empty
                    gvDetails.Rows[0].Visible = false;
                }
            }
        }
        private void loadUserFuels()
        {
            FuelBLL fuelBll = new FuelBLL();
            List<Fuel> fuelList =  fuelBll.GetUserFuels(_userObj.UserId);
            if (fuelList != null)
            {
                foreach (var fuel in fuelList)
                {
                    _fuel.Add(fuel.FuelId, fuel.Odometer);
                }
            }
        }

        private void LoadUserFuelChart()
        {
            FuelBLL fuelBll = new FuelBLL();

            if (_userObj != null)
            {
                hcFrutas.Series.Clear();

                List<Fuel> fuelList = fuelBll.GetUserFuels(_userObj.UserId);

                if (fuelList != null)
                {
                    //Defining Axis

                    ArrayList Dates = new ArrayList();
                    ArrayList Gallons = new ArrayList(); 

                    foreach (var userFuel in fuelList)
                    {
                        Dates.Add(userFuel.FillDate.ToString("MMM"));
                        Gallons.Add(userFuel.AvgMilesPerGallon);
                    }

                    //Title configuration
                    hcFrutas.Title = new Title("Miles Per Gallon");
                    hcFrutas.SubTitle = new SubTitle("Fuel Data");

                    //Defining Axis
                    hcFrutas.YAxis.Add(new YAxisItem { title = new Title("Gallons"), min = 0, max = 100, tickInterval=10, allowDecimals = true });
                    hcFrutas.XAxis.Add(new XAxisItem { title = new Highchart.Core.Title("Fill Date"), categories = new object[]{ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"} });
                    
                    //data    
                    var series = new Collection<Serie>();
                   // series.Add(new Serie { name = DateTime.Now.ToShortDateString(), data = new object[] { 20 } });
                    
                    //data    
                    //var series = new Collection<Serie>();
                    foreach (var userFuel in fuelList)
                    {
                        ArrayList avgMilesPerGallon = new ArrayList();

                        for (int i = 1; i <= 12; i++)
                        {
                            if (i == userFuel.FillDate.Month)
                            {
                                avgMilesPerGallon.Add(userFuel.AvgMilesPerGallon);
                            }
                            else
                            {
                                avgMilesPerGallon.Add(0.0);
                            }
                        }
                        series.Add(new Serie { name = userFuel.FillDate.ToShortDateString(), data = avgMilesPerGallon.ToArray() });
                    }


                    
                    //configuring Visual     
                    hcFrutas.PlotOptions = new Highchart.Core.PlotOptions.PlotOptionsColumn { borderColor = "#dedede", borderRadius = 4 };

                    //bind    
                    hcFrutas.DataSource = series;
                    hcFrutas.DataBind();
                    
                }
            }
        }

        protected void btnSaveCar_Click(object sender, EventArgs e)
        {
            SaveUserCarDetails();
        }

        private void SaveUserCarDetails()
        {
            if (_userObj != null)
            {
                _userObj.MakeId = Convert.ToInt32(lstMake.SelectedValue);
                _userObj.ModelId = Convert.ToInt32(lstModel.SelectedValue);
                _userObj.Year = Convert.ToInt32(txtYear.Text);

                VehicleBLL vehicleBll = new VehicleBLL();

                vehicleBll.UpdateUserVehicleDetails(_userObj);

                LoadCarDetails();
            }
        }

        protected void btnStartOver_Click(object sender, EventArgs e)
        {

        }

        private void LoadCarChart()
        {

            hccarmap.Series.Clear();

            //Defining Axis

            ArrayList Dates = new ArrayList();
            ArrayList Gallons = new ArrayList();

            if ((hiddCity08.Value == "") && (hiddHighway08.Value == "") && (hiddComb08.Value == ""))
            {
                return;
            }

            Gallons.Add(hiddCity08.Value);
            Gallons.Add(hiddHighway08.Value);
            Gallons.Add(hiddComb08.Value);

            object[] TokioData = new object[] { hiddCity08.Value, hiddHighway08.Value, hiddComb08.Value };

            //Title configuration
            hccarmap.Title = new Title("Miles Per Gallon");
            hccarmap.SubTitle = new SubTitle("Fuel Data");

            //Defining Axis
            hccarmap.YAxis.Add(new YAxisItem { title = new Title("Gallons"), min = 0, max = 45, tickInterval = 5, allowDecimals = true });
            hccarmap.XAxis.Add(new XAxisItem { title = new Highchart.Core.Title("Average"), categories = new object[] { "City Avg", "Highway Avg", "Comb Avg" } });

            //data    
            var series = new Collection<Serie>();

            var carData = Gallons[0].ToString() + "," + Gallons[1].ToString() + "," + Gallons[2].ToString();

            
            series.Add(new Serie { name = "data", data = new object[] { Convert.ToDouble(Gallons[0]), Convert.ToDouble(Gallons[1]), Convert.ToDouble(Gallons[2]) } });

            //series.Add(new Serie { name = "Comb Avg", data = TokioData.ToArray() });

            hccarmap.PlotOptions = new Highchart.Core.PlotOptions.PlotOptionsColumn { borderColor = "#dedede", borderRadius = 4 };


            //bind    
            hccarmap.DataSource = series;
            hccarmap.DataBind();
        }
    }


}