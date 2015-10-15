$(function () {

  $.ajax({
    method: "GET",
    url: window.location.pathname,
    dataType: "json"
  })

  .done(function(data){
    var opponent_names = data[0];
    var wins_against = data[1];
    var losses_against = data[2];
    var mostPlayedNames = data[3];
    var winsWith = data[4];

    $('#rivals').highcharts({
            chart: {
                type: 'bar'
            },
            title: {
                text: 'Wins and Losses by Opponent'
            },
            xAxis: [{
                categories: opponent_names,
                reversed: false,
                labels: {
                    step: 1
                }
            }, { // mirror axis on right side
                opposite: true,
                reversed: false,
                categories: opponent_names,
                linkedTo: 0,
                labels: {
                    step: 1
                }
            }],
            yAxis: {
                title: {
                    text: null
                },
                labels: {
                    formatter: function () {
                        return Math.abs(this.value);
                    }
                }
            },

            plotOptions: {
                series: {
                    stacking: 'normal'
                }
            },

            tooltip: {
                formatter: function () {
                    return '<b>' + this.series.name + ' vs. ' + this.point.category +
                    ': ' + Highcharts.numberFormat(Math.abs(this.point.y), 0) +'</b><br/>';
                }
            },

            series: [{
                name: 'Losses',
                data: losses_against
            }, {
                name: 'Wins',
                data: wins_against
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
            },
            labels: {
                step: 1
            }
        },
        series: [{
            name: "Wins with",
            data: winsWith
        }]
    });
  });
});
