$(function () {

  $.ajax({
    method: "GET",
    url: window.location.pathname,
    dataType: "json"
  })

  .done(function(data){
    var rivals = data[0];
    var wins = data[1];
    var mostPlayedNames = data[2];
    var winsWith = data[3];
    $("#rivals").highcharts({
        chart: {
            type: "bar"
        },
        title: {
            text: "Top Rivals"
        },
        xAxis: {
            categories: rivals
        },
        yAxis: {
            title: {
                text: "Losses to each:"
            }
        },
        series: [{
            name: "Rivals",
            data: wins
        }]
    });

    $("#charawins").highcharts({
        chart: {
            type: "bar"
        },
        title: {
            text: "Best Characters"
        },
        xAxis: {
            categories: mostPlayedNames
        },
        yAxis: {
            title: {
                text: "Wins with each:"
            }
        },
        series: [{
            name: "Characters",
            data: winsWith
        }]
    });
  });
});
