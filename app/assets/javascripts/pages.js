$(function () {
  new Morris.Area({
    element: 'area-chart',
    data: [
      { date: '2015-09-10', amount: 10},
      { date: '2015-09-11', amount: 100},
      { date: '2015-09-12', amount: 220},
      { date: '2015-09-13', amount: 240},
      { date: '2015-09-14', amount: 290},
      { date: '2015-09-15', amount: 340},
      { date: '2015-09-16', amount: 500},
      { date: '2015-09-17', amount: 800}
    ],
    xkey: 'date',
    ykeys: ['amount'],
    labels: ['Amount Raised'],
    goals: [1000.0],
    preUnits: '$',
    hideHover: 'auto',
  });
});
