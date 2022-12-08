import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
	id: diplomatic_map_view
	
	property int start_tile_x: 0
	property int start_tile_y: 0
	readonly property var selected_country: diplomatic_map.selected_country
	
	Rectangle {
		id: diplomatic_map_background
		anchors.top: parent.top
		anchors.bottom: back_button.top
		anchors.bottomMargin: 128 * scale_factor
		anchors.left: parent.left
		anchors.right: political_map_mode_button.left
		color: Qt.rgba(0.0 / 255.0, 0.0 / 255.0, 0.0 / 255.0, 1)
		border.color: "white"
		border.width: 1 * scale_factor
	}
	
	DiplomaticMap {
		id: diplomatic_map
		anchors.top: diplomatic_map_background.top
		anchors.topMargin: 1 * scale_factor
		anchors.bottom: diplomatic_map_background.bottom
		anchors.bottomMargin: 1 * scale_factor
		anchors.left: diplomatic_map_background.left
		anchors.leftMargin: 1 * scale_factor
		anchors.right: diplomatic_map_background.right
		anchors.rightMargin: 1 * scale_factor
		ocean_suffix: "0"
	}
	
	IconButton {
		id: political_map_mode_button
		anchors.top: diplomatic_map_background.top
		anchors.right: parent.right
		icon_identifier: "flag"
		border_color: "white"
		unrounded_left_corners: true
		tooltip: "Political Map Mode"
		
		onReleased: {
			diplomatic_map.mode = DiplomaticMap.Mode.Political
		}
	}
	
	IconButton {
		id: cultural_map_mode_button
		anchors.top: political_map_mode_button.bottom
		anchors.right: political_map_mode_button.right
		icon_identifier: "music"
		border_color: "white"
		unrounded_left_corners: true
		tooltip: "Cultural Map Mode"
		
		onReleased: {
			diplomatic_map.mode = DiplomaticMap.Mode.Cultural
		}
	}
	
	SmallText {
		id: country_text
		text: selected_country ? (
			selected_country.name
			+ "\n"
			+ "\n" + selected_country.game_data.type_name
			+ (selected_country.game_data.overlord ? (
				"\n" + selected_country.game_data.vassalage_type_name + " of " + selected_country.game_data.overlord.name
			) : "")
			+ (selected_country.game_data.anarchy ? "\nAnarchy" : "")
			+ (selected_country.great_power ? ("\nScore: " + number_string(selected_country.game_data.score) + " (#" + (selected_country.game_data.rank + 1) + ")") : "")
			+ "\nPopulation: " + number_string(selected_country.game_data.population)
			+ "\nPopulation Growth: " + selected_country.game_data.population_growth + "/" + metternich.defines.population_growth_threshold
			+ "\n" + selected_country.game_data.provinces.length + " " + (selected_country.game_data.provinces.length > 1 ? "Provinces" : "Province")
		) : ""
		anchors.left: diplomatic_map.left
		anchors.leftMargin: 8 * scale_factor
		anchors.top: diplomatic_map_background.bottom
		anchors.topMargin: 16 * scale_factor
	}
	
	SmallText {
		id: population_type_chart_label
		anchors.top: country_text.top
		anchors.horizontalCenter: population_type_chart.horizontalCenter
		text: "Population Type"
		visible: population_type_chart.visible
	}
	
	PopulationTypeChart {
		id: population_type_chart
		anchors.top: culture_chart.top
		anchors.right: culture_chart.left
		anchors.rightMargin: 16 * scale_factor
		visible: selected_country !== null
		data_source: selected_country ? selected_country.game_data : null
	}
	
	SmallText {
		id: culture_chart_label
		anchors.top: country_text.top
		anchors.horizontalCenter: culture_chart.horizontalCenter
		text: "Culture"
		visible: culture_chart.visible
	}
	
	CultureChart {
		id: culture_chart
		anchors.top: culture_chart_label.bottom
		anchors.topMargin: 4 * scale_factor
		anchors.right: phenotype_chart.left
		anchors.rightMargin: 16 * scale_factor
		visible: selected_country !== null
		data_source: selected_country ? selected_country.game_data : null
	}
	
	SmallText {
		id: phenotype_chart_label
		anchors.top: country_text.top
		anchors.horizontalCenter: phenotype_chart.horizontalCenter
		text: "Phenotype"
		visible: phenotype_chart.visible
	}
	
	PhenotypeChart {
		id: phenotype_chart
		anchors.top: population_type_chart.top
		anchors.right: diplomatic_map_background.right
		anchors.rightMargin: 8 * scale_factor
		visible: selected_country !== null
		data_source: selected_country ? selected_country.game_data : null
	}
	
	TextButton {
		id: back_button
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 8 * scale_factor
		text: qsTr("Back")
		width: 64 * scale_factor
		height: 24 * scale_factor
		
		onClicked: {
			menu_stack.pop()
		}
	}
	
	Component.onCompleted: {
		diplomatic_map.center_on_tile_pos(start_tile_x, start_tile_y)
	}
}
