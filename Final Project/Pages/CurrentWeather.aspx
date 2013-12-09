<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Root.master" AutoEventWireup="true"
    CodeBehind="CurrentWeather.aspx.cs" Inherits="Locator.Pages.CurrentWeather" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Weather Forecast</title>
    <link href="../StyleSheets/example.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery.zweatherfeed.js" type="text/javascript"></script>
    <script type="text/javascript">

        $(document).ready(function () {
//           
            $('#btnSubmit').click(function (e) {
                e.preventDefault();
                $('#weatherReport').empty();
                weatherGeocode('weatherLocation', 'weatherList');
            });

            function showLocation(address, woeid) {

                $('#weatherReport').empty();

                $('#weatherReport').weatherfeed([woeid], {
                    woeid: true,
                    forecast: true
                });
            }

            function weatherGeocode(search, output) {

                var status;
                var results;
                var html = '';
                var msg = '';

                // Set document elements
                var search = document.getElementById(search).value;
                var output = document.getElementById(output);

                if (search) {

                    output.innerHTML = '';

                    // Cache results for an hour to prevent overuse
                    now = new Date();

                    // Create Yahoo Weather feed API address
                    var query = 'select * from geo.places where text="' + search + '"';
                    var api = 'http://query.yahooapis.com/v1/public/yql?q=' + encodeURIComponent(query) + '&rnd=' + now.getFullYear() + now.getMonth() + now.getDay() + now.getHours() + '&format=json&callback=?';

                    // Send request
                    $.ajax({
                        type: 'GET',
                        url: api,
                        dataType: 'json',
                        success: function (data) {

                            if (data.query.count > 0) {

                                html = '<span>' + data.query.count + ' location';

                                if (data.query.count > 1) html = html + 's';
                                html = html + ' found:</span><ul>';

                                // List multiple returns
                                if (data.query.count > 1) {
                                    for (var i = 0; i < data.query.count; i++) {
                                        html = html + '<li>' + _getWeatherAddress(data.query.results.place[i]) + '</li>';
                                    }
                                } else {
                                    html = html + '<li>' + _getWeatherAddress(data.query.results.place) + '</li>';
                                }

                                html = html + '</ul>';

                                output.innerHTML = html;

                                // Bind callback links
                                $("a.weatherAddress").unbind('click');
                                $("a.weatherAddress").click(function (e) {
                                    e.preventDefault();

                                    var address = $(this).text();
                                    var weoid = $(this).attr('rel');

                                    showLocation(address, weoid);
                                });

                            } else {
                                output.innerHTML = 'The location could not be found';
                            }
                        },
                        error: function (data) {
                            output.innerHTML = 'An error has occurred';
                        }
                    });

                } else {

                    // No search given
                    output.innerHTML = 'Please enter a location or partial address';
                }
            }

            function _getWeatherAddress(data) {

                // Get address
                var address = data.name;
                if (data.admin2) address += ', ' + data.admin2.content;
                if (data.admin1) address += ', ' + data.admin1.content;
                address += ', ' + data.country.content;

                // Get WEOID
                var woeid = data.woeid;

                return '<a class="weatherAddress" href="#" rel="' + woeid + '" title="Click for to see a weather report">' + address + '</a> <small>(' + woeid + ')</small>';
            }
        });
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="FormHeader">
        Weather Forecast</div>
    <div class="Form-Contents">
        <label>
            Enter a city</label>
        <input type="text" id="weatherLocation" name="weatherLocation" size="50" />
        <input type="button" id="btnSubmit" name="submit" value="Search" class="Default-Button-Style" />
        <div id="weatherList">
        </div>
        <div id="weatherReport">
        </div>
        <div id="test"></div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="FooterContentPlaceHolder" runat="server">
</asp:Content>
