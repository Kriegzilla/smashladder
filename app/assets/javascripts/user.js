$(function () {

  $.ajax({
    method: "GET",
    url: window.location.pathname,
    dataType: "json"
  })

  .done(function(data){
    var users = data[0]
    var wins = data[1]
    $('#container').highcharts({
        chart: {
            type: 'bar'
        },
        title: {
            text: 'Wins by Player'
        },
        xAxis: {
            categories: users
        },
        yAxis: {
            title: {
                text: 'Wins'
            }
        },
        series: [{
            name: 'Test',
            data: wins
        }]
    });
  });
});
