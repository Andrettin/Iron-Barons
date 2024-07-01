import QtQuick
import QtQuick.Controls

Rectangle {
	id: infopanel
	color: interface_background_color
	width: 64 * scale_factor
	
	Rectangle {
		color: "gray"
		anchors.top: parent.top
		anchors.topMargin: 15 * scale_factor
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 15 * scale_factor
		anchors.right: parent.right
		width: 1 * scale_factor
	}
	
	ListView {
		id: population_unit_list
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.top: parent.top
		anchors.topMargin: 96 * scale_factor
		anchors.bottom: back_button.top
		anchors.bottomMargin: 8 * scale_factor
		boundsBehavior: Flickable.StopAtBounds
		spacing: 8 * scale_factor
		clip: true
		model: get_population_types_by_output_commodity(country_game_data.population.type_counts)
		delegate: IndustryCounter {
			name: model.modelData.key.name
			icon_identifier: is_commodity ? model.modelData.key.icon.identifier : country_game_data.get_population_type_small_icon(model.modelData.key).identifier
			count: is_commodity ?
				((country_game_data.commodity_outputs && country_game_data.commodity_inputs) ? (country_game_data.get_commodity_output(model.modelData.key.identifier) - country_game_data.get_commodity_input(model.modelData.key.identifier)) : 0) //the conditional is there to make the counter be updated when the commodity output or input changes
				: model.modelData.value
			tooltip: modifier_string.length > 0 ? format_text(small_text(modifier_string)) : ""
			
			readonly property bool is_commodity: model.modelData.key.class_name === "metternich::commodity"
			readonly property string modifier_string: is_commodity ? "" : model.modelData.key.get_country_modifier_string(country)
		}
	}
	
	function get_population_types_by_output_commodity(population_type_counts) {
		var used_commodities = []
		var result = []
		
		for (var kv_pair of population_type_counts) {
			var population_type = kv_pair.key
			
			if (population_type.output_commodity !== null && used_commodities.indexOf(population_type.output_commodity) === -1) {
				used_commodities.push(population_type.output_commodity)
				result.push({key: population_type.output_commodity, value: 0})
			}
			
			result.push(kv_pair)
		}
		
		return result
	}
	
	TextButton {
		id: back_button
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 16 * scale_factor
		text: qsTr("Back")
		width: 48 * scale_factor
		height: 24 * scale_factor
		
		onClicked: {
			menu_stack.pop()
		}
	}
}
