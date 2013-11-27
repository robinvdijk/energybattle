$(document).ready(function() {
  var jsonData = $.ajax({
    url: "http://localhost:3000/battles/16/readings.json", // make this url point to the data file
    dataType: "json",
    async: false
  }).responseText;

  var data = jQuery.parseJSON(jsonData);
  console.log(data);
  Morris.Line({
    element: 'personal-graph',
    data: $('#personal-graph').data('readings'),
    xkey: 'original_date',
  	xLabels: ['day'],
    ykeys: ['personal', 'ideal'],
    labels: ['Meterstand', 'Uiteindelijke meterstand', 'Punten'],
  	ymin: 'auto',
  	ymax: 'auto',
    hideHover: 'auto'
  });

  Morris.Line({
    element: 'overall-graph',
    data: $('#overall-graph').data('readings'),
    xkey: 'original_date',
  	xLabels: ['day'],
    ykeys: ['name'],
    labels: ['Meterstand'],
  	ymin: 'auto',
  	ymax: 'auto',
    hideHover: 'auto'
  });
});
