import QtQuick 2.12
import QtQuick.Controls 2.12
import MaskedMouseArea 1.0
import ".."

MenuBase {
	id: scenario_menu
	title: qsTr("Scenario")
	
	property var selected_scenario: null
	
	Rectangle {
		id: diplomatic_map_background
		anchors.horizontalCenter: diplomatic_map.horizontalCenter
		anchors.verticalCenter: diplomatic_map.verticalCenter
		width: diplomatic_map.width + 2
		height: diplomatic_map.height + 2
		color: Qt.rgba(0.0 / 255.0, 0.0 / 255.0, 32.0 / 255.0, 1)
		border.color: "white"
		border.width: 1
	}
	
	Flickable {
		id: diplomatic_map
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.horizontalCenterOffset: 64 * scale_factor
		anchors.verticalCenter: parent.verticalCenter
		width: 512 * scale_factor
		height: 256 * scale_factor
		contentWidth: metternich.game.diplomatic_map_image_size.width * scale_factor
		contentHeight: metternich.game.diplomatic_map_image_size.height * scale_factor
		boundsBehavior: Flickable.StopAtBounds
		clip: true
		
		property var selected_country: null
		
		Repeater {
			model: metternich.game.countries
			
			Image {
				id: country_image
				x: country.game_data.diplomatic_map_image_rect.x
				y: country.game_data.diplomatic_map_image_rect.y
				source: "image://diplomatic_map/" + country.identifier + (selected ? "/selected" : "")
				cache: false
				
				readonly property var country: model.modelData
				readonly property var selected: diplomatic_map.selected_country === country
				
				MaskedMouseArea {
					anchors.fill: parent
					alphaThreshold: 0.4
					maskSource: parent.source
					ToolTip.text: country.name
					ToolTip.visible: containsMouse
					ToolTip.delay: 1000
					
					onClicked: {
						if (country.great_power) {
							diplomatic_map.selected_country = country
						}
					}
				}
			}
		}
	}
	
	SmallText {
		text: diplomatic_map.selected_country ? ("Country: " + diplomatic_map.selected_country.name) : ""
		anchors.left: diplomatic_map.left
		anchors.leftMargin: 4 * scale_factor
		anchors.top: diplomatic_map_background.bottom
		anchors.topMargin: 16 * scale_factor
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
		
		onClicked: {
			metternich.game.start()
		}
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
		function onCountriesChanged() {
			if (diplomatic_map.selected_country !== null && !metternich.game.countries.includes(diplomatic_map.selected_country)) {
				diplomatic_map.selected_country = null
			}
		}
	}
	
	Component.onCompleted: {
		selected_scenario = metternich.get_scenarios()[0]
		metternich.game.setup_scenario(selected_scenario)
	}
}
