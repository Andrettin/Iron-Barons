import QtQuick 2.14
import QtQuick.Controls 2.12
import QtCharts 2.3

PopulationChart {
	id: chart
	
	Connections {
		target: chart.data_source
		ignoreUnknownSignals: true //as there may be no selected data source
		
		function onPopulation_culture_counts_changed() {
			chart.update_chart()
		}
	}

	function update_chart() {
		pie_series.clear()

		if (chart.data_source === null) {
			return
		}

		var population_per_culture = chart.data_source.population_culture_counts
		for (var i = 0; i < population_per_culture.length; i++) {
			var culture = population_per_culture[i].key
			var count = population_per_culture[i].value
			var pie_slice = pie_series.append(culture.name, count)
			pie_slice.color = culture.color
			pie_slice.borderColor = "black"
		}
	}
}