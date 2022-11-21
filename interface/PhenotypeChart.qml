import QtQuick 2.14
import QtQuick.Controls 2.12
import QtCharts 2.3

PopulationChart {
	id: chart
	
	Connections {
		target: chart.data_source
		ignoreUnknownSignals: true //as there may be no selected data source
		
		function onPopulation_phenotype_counts_changed() {
			chart.update_chart()
		}
	}

	function update_chart() {
		pie_series.clear()

		if (chart.data_source === null) {
			return
		}

		var population_per_phenotype = chart.data_source.population_phenotype_counts
		for (var i = 0; i < population_per_phenotype.length; i++) {
			var phenotype = population_per_phenotype[i].key
			var count = population_per_phenotype[i].value
			var pie_slice = pie_series.append(phenotype.name, count)
			pie_slice.color = phenotype.color
			pie_slice.borderColor = "black"
		}
	}
}
