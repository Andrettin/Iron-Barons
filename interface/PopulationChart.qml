import QtQuick
import QtQuick.Controls
import QtCharts

ChartView {
	property var data_source: null //the data source for the chart, e.g. a province or a country
	readonly property var pie_series: pie_series

	id: chart
	width: 64 * scale_factor
	height: 64 * scale_factor
	margins.top: 0
	margins.bottom: 0
	margins.left: 0
	margins.right: 0
	legend.visible: false
	backgroundColor: "transparent"
	antialiasing: true

	onData_sourceChanged: chart.update_chart()

	PieSeries {
		id: pie_series
		size: 0.95

		onHovered: function(slice, state) {
			if (state === true) {
				tooltip.text = small_text(slice.label + " (" + (slice.percentage * 100).toFixed(2) + "%)")
				tooltip.visible = true
			} else {
				tooltip.visible = false
			}
		}
	}
	
	CustomTooltip {
		id: tooltip
		visible: false
	}
	
	layer.enabled: true
	layer.effect: DropShadow {
		transparentBorder: true
		radius: 4.0
		samples: 9
		verticalOffset: 1
		horizontalOffset: 1
	}
}
