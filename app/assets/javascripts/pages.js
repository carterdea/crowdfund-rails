$(function () {
  if($('#area-chart').length >0 ){
    new Morris.Area({
      element: 'area-chart',
      data: $('#area-chart').data('amount-raised'),
      goals: [$('#area-chart').data('cost')],
      xkey: 'date',
      ykeys: ['amount'],
      labels: ['Amount Raised'],
      preUnits: '$',
      hideHover: 'auto',
      lineColors: ['#76cc1e'],
      fillOpacity: 0.5,
      goalStrokeWidth: 2
    });
  }
});
