$(function () {

  $.ajax({
    method: "GET",
    url: window.location.pathname + "&ajax=1 ",
    dataType: "json"
  })

  .done(function(data){
    var OpponentNames = data[0];
    var WinsAgainst = data[1];
    var LossesAgainst = data[2];
    var mostPlayedNames = data[3];
    var winsWith = data[4];

    $('#rivals').highcharts({
            chart: {
                type: "bar"
            },
            title: {
                text: "Wins and Losses by Opponent"
            },
            xAxis: [{
                categories: OpponentNames,
                reversed: false,
                labels: {
                    step: 1
                }
            }, { // mirror axis on right side
                opposite: true,
                reversed: false,
                categories: OpponentNames,
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
                    stacking: "normal"
                }
            },

            tooltip: {
                formatter: function () {
                    return "<b>" + this.series.name + " vs. " +
                    this.point.category + ": " +
                    Math.abs(this.point.y) +"</b><br/>";
                }
            },

            series: [{
                name: "Losses",
                data: LossesAgainst
            }, {
                name: "Wins",
                data: WinsAgainst
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
