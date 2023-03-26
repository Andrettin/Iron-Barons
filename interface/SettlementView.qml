import QtQuick 2.12
import QtQuick.Controls 2.12
import "./dialogs"

Item {
	id: settlement_view
	
	property var settlement: null
	readonly property var settlement_game_data: settlement.game_data
	readonly property var province: settlement_game_data.province
	readonly property var province_game_data: province.game_data
	readonly property var country: province_game_data.owner
	readonly property var country_game_data: country ? country.game_data : null
	property string interface_style: "dwarven"
	property string status_text: ""
	
	Rectangle {
		id: building_slots_area_background
		anchors.fill: building_slots_area
		color: "black"
	}
	
	GridView {
		id: building_slots_area
		anchors.top: top_bar.bottom
		anchors.bottom: status_bar.top
		anchors.left: infopanel.right
		anchors.right: right_bar.left
		leftMargin: 0
		rightMargin: 0
		topMargin: 0
		bottomMargin: 0
		cellWidth: 80 * scale_factor
		cellHeight: 80 * scale_factor
		boundsBehavior: Flickable.StopAtBounds
		clip: true
		model: get_available_building_slots(province_game_data.building_slots)
		
		delegate: Item {
			width: building_slots_area.cellWidth
			height: building_slots_area.cellHeight
			
			readonly property var building_slot: model.modelData
			readonly property var building: building_slot.building
			
			Rectangle {
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.verticalCenter: parent.verticalCenter
				width: building_portrait.width + 2 * scale_factor
				height: building_portrait.height + 2 * scale_factor
				border.color: building_mouse_area.containsMouse ? "white" : "gray"
				border.width: 1 * scale_factor
				
				Image {
					id: building_portrait
					anchors.horizontalCenter: parent.horizontalCenter
					anchors.verticalCenter: parent.verticalCenter
					source: "image://icon/" + (building ? building.portrait.identifier : "building_slot")
				}
				
				MouseArea {
					id: building_mouse_area
					anchors.fill: parent
					hoverEnabled: true
					
					onClicked: {
						if (building !== null && building.warehouse) {
							warehouse_dialog.open()
						}
					}
					
					onEntered: {
						if (building !== null) {
							status_text = building.name
						} else {
							status_text = building_slot.type.name + " Slot"
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
	
	WarehouseDialog {
		id: warehouse_dialog
	}
	
	function get_available_building_slots(building_slots) {
		var available_building_slots = []
		
		for (var building_slot of building_slots) {
			if (building_slot.available) {
				available_building_slots.push(building_slot)
			}
		}
		
		return available_building_slots
	}
}
