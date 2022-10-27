import QtQuick 2.12
import QtQuick.Controls 2.12
import MaskedMouseArea 1.0
import ".."

MenuBase {
	id: scenario_menu
	title: qsTr("Scenario")
	
	property var selected_scenario: null
	property var selected_country: null
	property var ocean_map_template_identifier: ""
	property var diplomatic_map_start_date_string: ""
	
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
	
	Flickable {
		id: diplomatic_map
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.horizontalCenterOffset: 64 * scale_factor
		anchors.verticalCenter: parent.verticalCenter
		anchors.verticalCenterOffset: -32 * scale_factor
		width: 512 * scale_factor
		height: 256 * scale_factor
		contentWidth: metternich.game.diplomatic_map_image_size.width * scale_factor
		contentHeight: metternich.game.diplomatic_map_image_size.height * scale_factor
		boundsBehavior: Flickable.StopAtBounds
		clip: true
		
		Image {
			id: ocean_image
			source: ocean_map_template_identifier.length > 0 ? ("image://diplomatic_map/ocean/" + ocean_map_template_identifier) : "image://empty/"
			cache: false
		}
		
		MouseArea {
			width: diplomatic_map.contentWidth
			height: diplomatic_map.contentHeight
			
			onClicked: {
				scenario_menu.selected_country = null
			}
		}
		
		Repeater {
			model: metternich.game.countries
			
			Image {
				id: country_image
				x: country.game_data.diplomatic_map_image_rect.x
				y: country.game_data.diplomatic_map_image_rect.y
				source: "image://diplomatic_map/" + country.identifier + (selected ? "/selected" : "") + "/" + diplomatic_map_start_date_string
				cache: false
				
				readonly property var country: model.modelData
				readonly property var selected: selected_country === country
				
				MaskedMouseArea {
					anchors.fill: parent
					alphaThreshold: 0.4
					maskSource: parent.source
					ToolTip.text: country.name
					ToolTip.visible: containsMouse
					ToolTip.delay: 1000
					
					onClicked: {
						if (selected) {
							scenario_menu.selected_country = null
						} else {
							scenario_menu.selected_country = country
						}
					}
				}
			}
		}
		
		function center_on_selected_country_capital() {
			var capital_game_data = selected_country.capital_province.capital_settlement.game_data
			var capital_x = capital_game_data.tile_pos.x * metternich.game.diplomatic_map_tile_pixel_size * scale_factor
			var capital_y = capital_game_data.tile_pos.y * metternich.game.diplomatic_map_tile_pixel_size * scale_factor
			
			var scenario_x = capital_x - diplomatic_map.width / 2
			var scenario_y = capital_y - diplomatic_map.height / 2
			diplomatic_map.contentX = Math.min(Math.max(scenario_x, 0), diplomatic_map.contentWidth - diplomatic_map.width)
			diplomatic_map.contentY = Math.min(Math.max(scenario_y, 0), diplomatic_map.contentHeight - diplomatic_map.height)
		}
	}
	
	SmallText {
		text: selected_country ? (
			selected_country.name
			+ "\n"
			+ "\n" + selected_country.game_data.type_name
			+ (selected_country.game_data.overlord ? (
				"\n" + selected_country.game_data.vassalage_type_name + " of " + selected_country.game_data.overlord.name
			) : "")
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
	
	Button {
		id: start_game_button
		anchors.horizontalCenter: scenario_list.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		text: qsTr("Start Game")
		width: 64 * scale_factor
		height: 24 * scale_factor
		enabled: selected_country !== null && selected_country.great_power
		
		onClicked: {
			metternich.game.player_country = selected_country
			metternich.game.start()
		}
	}
	
	MouseArea {
		anchors.fill: start_game_button
		enabled: !start_game_button.enabled
		hoverEnabled: true
		ToolTip.text: small_text(selected_country !== null ? ("You cannot play as a " + (selected_country.tribe ? "Tribe" : "Minor Nation")) : "You must select a country to play")
		ToolTip.visible: containsMouse
		ToolTip.delay: 1000
	}
	
	Button {
		id: previous_menu_button
		anchors.horizontalCenter: start_game_button.horizontalCenter
		anchors.top: start_game_button.bottom
		anchors.topMargin: 8 * scale_factor
		text: qsTr("Previous Menu")
		width: 64 * scale_factor
		height: 24 * scale_factor
		
		onClicked: {
			menu_stack.pop()
		}
	}
	
	Connections {
		target: metternich.game
		function onSetup_finished() {
			if (selected_scenario.map_template.identifier !== scenario_menu.ocean_map_template_identifier) {
				scenario_menu.ocean_map_template_identifier = selected_scenario.map_template.identifier
			}
			
			if (selected_country !== null && !metternich.game.countries.includes(selected_country)) {
				scenario_menu.selected_country = null
			}
			
			diplomatic_map_start_date_string = selected_scenario.start_date.getUTCFullYear() + "." + selected_scenario.start_date.getUTCMonth() + "." + selected_scenario.start_date.getUTCDay()
		}
	}
	
	Component.onCompleted: {
		selected_scenario = metternich.get_scenarios()[0]
		metternich.game.setup_scenario(selected_scenario)
		
		scenario_menu.selected_country = metternich.game.great_powers[random(metternich.game.great_powers.length)]
		diplomatic_map.center_on_selected_country_capital()
	}
}
