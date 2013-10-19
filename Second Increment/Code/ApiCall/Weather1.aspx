<%@ Page Language="C#" MasterPageFile="~/SiteHTML5.master"  AutoEventWireup="true" CodeBehind="Weather1.aspx.cs" Inherits="ApiCall.Weather1" %>


<asp:Content ID="headContent" runat="server" ContentPlaceHolderID="head">
   
   <title>Weather Forecast, by Joby Joseph</title>
        <style type="text/css" rel="stylesheet">
            #weathertext{width: 300px; border: 1px solid #cccccc; display: none;}
            #placetitle{font-size: 30px; border-bottom: 1px solid #cccccc; text-transform: capitalize;}
            #temperature{font-family: arial; font-size: 24px; font-weight: bold;}
            .contents{font-family: arial; color: #999999; font-size: 12px; line-height: 20px;}
            #statustext{text-align: left;}
            #forecastimage{width: 120px;}
        </style>

      <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#findweather').click(function () {
                    $.getJSON('http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20location%20in%20(%0A%20%20select%20id%20from%20weather.search%20where%20query%3D%22' + $('#placename').val() + '%22%0A)%20limit%201&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=?', function (data) {

                        if ((data.query.results != "" && data.query.results != "undefined" && data.query.results != null)) {
                            if ((data.query.results.channel.item.title != "City not found")) {
                                $('#weathertext').show();
                                //$('#placetitle').html($('#placename').val());
                                $('#placetitle').html(data.query.results.channel.item.title);
                                $('#weatherimage').attr('src', 'images/' + data.query.results.channel.item.condition.code + '.png');
                                $('#temperature').html(data.query.results.channel.item.condition.temp + ' &deg;F');
                                $('#condition').html(data.query.results.channel.item.condition.text);
                                var winddirection = parseInt(data.query.results.channel.wind.direction);
                                var direction = '';
                                switch (true) {
                                case (winddirection == 0):
                                    direction = 'N';
                                    break;
                                case (winddirection < 90):
                                    direction = 'NE';
                                    break;
                                case (winddirection == 90):
                                    direction = 'E';
                                    break;
                                case (winddirection < 180):
                                    direction = 'SE';
                                    break;
                                case (winddirection == 180):
                                    direction = 'S';
                                    break;
                                case (winddirection < 270):
                                    direction = 'SW';
                                    break;
                                case (winddirection == 270):
                                    direction = 'W';
                                    break;
                                case (winddirection < 360):
                                    direction = 'NW';
                                    break;
                                case (winddirection == 360):
                                    direction = 'N';
                                    break;
                                }
                                $('#dirspeed').html('Wind: ' + direction + ' at ' + data.query.results.channel.wind.speed + ' mph');
                                $('#humidity').html('Humidity: ' + data.query.results.channel.atmosphere.humidity + '%');
                            } else {
                                $('#weathertext').hide();
                                alert('Please enter a valid City');
                            }
                        } else {
                            $('#weathertext').hide();
                            alert('Please enter a valid City');
                        }
                    });

                });
            });
        </script>


</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    
          <p>Enter City Name and Click on Go to get Weather Forecast</p>
         <p><b>City Name</b></p> <input type="text" id="placename"/>
         <br />
        <input type="button" id="findweather" value="Go"/><br/><br/>
        <hr/>

        <div id="weatherholder">
            <table id="weathertext">
                <tr>
                    <td colspan="2" id="placetitle"></td>
                </tr>
                <tr>
                    <td id="forecastimage">
                        <img src="" id="weatherimage" alt=""/>
                    </td>
                    <td id="statustext">
                        <span id="temperature"></span><br/>
                        <span id="condition" class="contents"></span><br/>
                        <span id="dirspeed" class="contents"></span><br/>
                        <span id="humidity" class="contents"></span>
                    </td>
                </tr>
            </table>
        </div>


</asp:Content>



