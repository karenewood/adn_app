# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	data =
  		labels: $('#resultatsGraph').data('labels')
  		datasets: [
    		fillColor: "rgba(0,128,128,0.2)"
    		strokeColor: "rgba(0,128,128,0.5)"
    		pointColor: "rgba(0,128,128,0.7)"
    		pointStrokeColor: "#fff"
    		data: $('#resultatsGraph').data('values')
  		]
	myNewChart = new Chart($("#resultatsGraph").get(0).getContext("2d")).Radar(data, 
		scaleOverlay : true,
		scaleOverride : true,
		scaleSteps : 3,
		scaleStepWidth : 1,
		scaleStartValue : 0,
		scaleShowLabels : true,
		scaleFontStyle : "bold",
		angleLineWidth : 2,	
		scaleLineWidth : 2
		angleLineColor : "rgba(0,0,0,.2)",
		scaleLineColor : "rgba(0,0,0,.2)",
		scaleBackdropColor : "rgba(255,255,255,0)"
		)