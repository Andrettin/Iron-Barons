import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
	id: settlement_view
	
	property var settlement: null
	readonly property var settlement_game_data: settlement.game_data
	readonly property var province: settlement_game_data.province
	readonly property var province_game_data: province.game_data
	property string interface_style: "dwarven"
	property string status_text: ""
	
	Flickable {
		id: building_slots_area
		anchors.top: top_bar.bottom
		anchors.bottom: status_bar.top
		anchors.left: infopanel.right
		anchors.right: right_bar.left
		leftMargin: 0
		rightMargin: 0
		topMargin: 0
		bottomMargin: 0
		clip: true
		
		Repeater {
			model: province_game_data.building_slots
			
			Item {
				x: index % 16 * 48 * scale_factor
				y: index / 16 * 48 * scale_factor
				width: 48 * scale_factor
				height: 48 * scale_factor
					
					readonly property var building_slot: model.modelData
				
				Image {
					anchors.horizontalCenter: parent.horizontalCenter
					anchors.verticalCenter: parent.verticalCenter
					source: building_slot.building ? "image://icon/" + building_slot.building.identifier : "image://empty/"
				}
					
				MouseArea {
					anchors.fill: parent
					hoverEnabled: true
					
					onEntered: {
						if (building_slot.building !== null) {
							status_text = building_slot.building.name
						}
					}
					
					onExited: {
						status_text = ""
					}
				}
			}
		}
	}
	
	Image {
		id: right_bar
		anchors.top: parent.top
		anchors.right: parent.right
		source: "image://interface/" + interface_style + "/right_bar"
		fillMode: Image.PreserveAspectCrop
	}
	
	StatusBar {
		id: status_bar
		anchors.bottom: parent.bottom
		anchors.left: infopanel.right
		anchors.right: parent.right
	}
	
	TopBar {
		id: top_bar
		anchors.top: parent.top
		anchors.left: infopanel.right
	}
	
	SettlementInfoPanel {
		id: infopanel
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		anchors.left: parent.left
	}
}
