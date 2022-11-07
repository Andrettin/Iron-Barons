import QtQuick 2.12
import QtQuick.Controls 2.12
import MaskedMouseArea 1.0
import ".."

MenuBase {
	id: scenario_menu
	title: qsTr("Scenario")
	
	property var selected_scenario: null
	readonly property var selected_country: diplomatic_map.selected_country
	
	Rectangle {
		id: diplomatic_map_background
		anchors.horizontalCenter: diplomatic_map.horizontalCenter
		anchors.verticalCenter: diplomatic_map.verticalCenter
		width: diplomatic_map.width + 2
		height: diplomatic_map.height + 2
		color: Qt.rgba(0.0 / 255.0, 0.0 / 255.0, 0.0 / 255.0, 1)
		border.color: "white"
		border.width: 1
	}
	
	DiplomaticMap {
		id: diplomatic_map
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.horizontalCenterOffset: 64 * scale_factor
		anchors.verticalCenter: parent.verticalCenter
		anchors.verticalCenterOffset: -32 * scale_factor
		width: 512 * scale_factor
		height: 256 * scale_factor
	}
	
	SmallText {
		text: selected_country ? (
			selected_country.name
			+ "\n"
			+ "\n" + selected_country.game_data.type_name
			+ (selected_country.game_data.overlord ? (
				"\n" + selected_country.game_data.vassalage_type_name + " of " + selected_country.game_data.overlord.name
			) : "")
			+ (selected_country.capital_province.game_data.owner !== selected_country ? "\nAnarchy" : "")
			+ (selected_country.great_power ? ("\nScore: " + selected_country.game_data.score + " (#" + (selected_country.game_data.rank + 1) + ")") : "")
			+ (vassal_count > 0 ? (
				"\n" + vassal_count + " " + (vassal_count > 1 ? "Vassals" : "Vassal")
			) : "")
			+ (selected_country.game_data.colonies.length > 0 ? (
				"\n" + selected_country.game_data.colonies.length + " " + (selected_country.game_data.colonies.length > 1 ? "Colonies" : "Colony")
			) : "")
			+ "\n" + selected_country.game_data.provinces.length + " " + (selected_country.game_data.provinces.length > 1 ? "Provinces" : "Province")
			+ get_resource_counts_string(selected_country.game_data.resource_counts)
		) : ""
		anchors.left: diplomatic_map.left
		anchors.leftMargin: 4 * scale_factor
		anchors.top: diplomatic_map_background.bottom
		anchors.topMargin: 16 * scale_factor
		
		readonly property int vassal_count: selected_country ? (selected_country.game_data.vassals.length - selected_country.game_data.colonies.length) : 0
		
		function get_resource_counts_string(resource_counts) {
			var str = "";
			
			for (const kv_pair of resource_counts) {
				var resource = kv_pair.key
				var count = kv_pair.value
				str += "\n" + count + " " + resource.name
			}
			
			return str
		}
	}
	
	Rectangle {
		id: scenario_list_border
		anchors.horizontalCenter: scenario_list.horizontalCenter
		anchors.verticalCenter: scenario_list.verticalCenter
		width: scenario_list.width + 2
		height: scenario_list.height + 2
		color: "transparent"
		border.color: "white"
		border.width: 1
	}
	
	ListView {
		id: scenario_list
		anchors.right: diplomatic_map.left
		anchors.rightMargin: 16 * scale_factor
		anchors.bottom: start_game_button.top
		anchors.bottomMargin: 16 * scale_factor
		width: 256 * scale_factor
		height: 128 * scale_factor
		boundsBehavior: Flickable.StopAtBounds
		clip: true
		model: metternich.get_scenarios()
		delegate: Rectangle {
			width: 256 * scale_factor
			height: 16 * scale_factor
			visible: !model.modelData.hidden
			color: (selected_scenario == model.modelData) ? "olive" : "black"
			border.color: "white"
			border.width: 1
			
			SmallText {
				text: model.modelData.name + ", " + date_year_string(model.modelData.start_date)
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.verticalCenter: parent.verticalCenter
			}
			
			MouseArea {
				anchors.fill: parent
				
				onClicked: {
					if (selected_scenario === model.modelData) {
						return
					}
					
					selected_scenario = model.modelData
					metternich.game.setup_scenario(selected_scenario)
				}
			}
		}
	}
	
	TextButton {
		id: start_game_button
		anchors.horizontalCenter: scenario_list.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		text: qsTr("Start Game")
		width: 96 * scale_factor
		height: 24 * scale_factor
		allowed: selected_country !== null && selected_country.great_power && selected_country.capital_province.game_data.owner === selected_country
		tooltip: allowed ? "" : small_text(
			selected_country === null ? "You must select a country to play" : (
				!selected_country.great_power ? ("You cannot play as a " + (selected_country.tribe ? "Tribe" : "Minor Nation")) : "You cannot play as a country under anarchy"
			)
			
		)
		ToolTip.visible: hovered && !allowed
		ToolTip.delay: 1000
		
		onClicked: {
			metternich.game.player_country = selected_country
			metternich.game.start()
		}
	}
	
	TextButton {
		id: previous_menu_button
		anchors.horizontalCenter: start_game_button.horizontalCenter
		anchors.top: start_game_button.bottom
		anchors.topMargin: 8 * scale_factor
		text: qsTr("Previous Menu")
		width: 96 * scale_factor
		height: 24 * scale_factor
		
		onClicked: {
			menu_stack.pop()
		}
	}
	
	Connections {
		target: metternich.game
		function onSetup_finished() {
			if (selected_scenario.map_template.identifier !== diplomatic_map.ocean_suffix) {
				diplomatic_map.ocean_suffix = selected_scenario.map_template.identifier
			}
			
			if (selected_country !== null && !metternich.game.countries.includes(selected_country)) {
				diplomatic_map.selected_country = null
			}
			
			diplomatic_map.country_suffix = selected_scenario.start_date.getUTCFullYear() + "." + selected_scenario.start_date.getUTCMonth() + "." + selected_scenario.start_date.getUTCDay()
		}
	}
	
	Component.onCompleted: {
		selected_scenario = metternich.get_scenarios()[0]
		metternich.game.setup_scenario(selected_scenario)
		
		diplomatic_map.selected_country = metternich.game.great_powers[random(metternich.game.great_powers.length)]
		diplomatic_map.center_on_selected_country_capital()
	}
}
