$(function () {

  $.ajax({
    method: "GET",
    url: window.location.pathname,
    dataType: "json"
  })

  .done(function(data){
    var rivals = data[0];
    var wins = data[1];
    $("#container").highcharts({
        chart: {
            type: "bar"
        },
        title: {
            text: "Your Top Rivals"
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
  });
});
