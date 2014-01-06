$(document).ready(function() {

  Morris.Line({
    element: 'personal-graph',
    data: $('#personal-graph').data('readings'),
    xkey: 'original_date',
    xLabels: ['day'],
    ykeys: ['personal', 'ideal', 'expected'],
    labels: ['Meterstand', 'Uiteindelijke meterstand', 'Verwachte meterstand'],
    ymin: 'auto',
    ymax: 'auto',
    hideHover: 'auto'
  });

  Morris.Line($('#overall-graph').data('readings'));

  Morris.Line($('#team_vs_team-graph').data('readings'));

  Morris.Line({
    element: 'consumption-graph',
    data: $('#consumption-graph').data('readings'),
    xkey: 'original_date',
    xLabels: ['day'],
    ykeys: ['personal', 'ideal'],
    labels: ['Meterstand', 'Uiteindelijke meterstand']
  });

  // Morris.Line({
  //   element: 'overall-graph',
  //   data: $('#overall-graph').data('readings'),
  //   xkey: 'original_date',
  //   xLabels: ['day'],
  //   ykeys: ['name'],
  //   labels: ['Meterstand'],
  //   ymin: 'auto',
  //   ymax: 'auto',
  //   hideHover: 'auto'
  // });
});
