import QtQuick 2.12
import QtQuick.Controls 2.12
import "./dialogs"

Item {
	id: industry_view
	
	property var country: null
	readonly property var country_game_data: country ? country.game_data : null
	property string interface_style: "dwarven"
	property string status_text: ""
	property string middle_status_text: ""
	
	Rectangle {
		id: portrait_grid_view_background
		anchors.fill: portrait_grid_view
		color: "black"
	}
	
	GridView {
		id: portrait_grid_view
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
		model: country_game_data.building_slots
		
		delegate: PortraitGridItem {
			portrait_identifier: building ? building.portrait.identifier : "building_slot"
			
			readonly property var building_slot: model.modelData
			readonly property var building: building_slot.building
			
			Image {
				id: under_construction_icon
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.verticalCenter: parent.verticalCenter
				source: "image://icon/cog"
				visible: building_slot.under_construction_building !== null
			}
			
			onClicked: {
				if (building !== null) {
					if (building.warehouse || building_slot.available_production_types.length > 0) {
						building_dialog.building_slot = building_slot
						building_dialog.open()
						return
					}
					
					if (building.country_modifier_string.length > 0) {
						building_modifier_dialog.title = building.name
						building_modifier_dialog.modifier_string = building.country_modifier_string
						building_modifier_dialog.open()
						return
					}
				} else {
					var buildable_building = building_slot.get_buildable_building()
					if (buildable_building !== null) {
						build_building_dialog.title = buildable_building.name
						build_building_dialog.building_slot = building_slot
						build_building_dialog.building = buildable_building
						build_building_dialog.open()
					}
				}
			}
			
			onEntered: {
				if (building !== null) {
					status_text = building.name
					
					if (building_slot.available_production_types.length > 0) {
						middle_status_text = "Employed Capacity: " + building_slot.employed_capacity + "/" + building_slot.capacity
					}
				} else {
					status_text = building_slot.type.name + " Slot"
					middle_status_text = ""
				}
			}
			
			onExited: {
				status_text = ""
				middle_status_text = ""
			}
		}
	}
	
	RightBar {
		id: right_bar
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		anchors.right: parent.right
	}
	
	StatusBar {
		id: status_bar
		anchors.bottom: parent.bottom
		anchors.left: infopanel.right
		anchors.right: right_bar.left
	}
	
	TopBar {
		id: top_bar
		anchors.top: parent.top
		anchors.left: infopanel.right
		anchors.right: right_bar.left
	}
	
	IndustryInfoPanel {
		id: infopanel
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		anchors.left: parent.left
	}
	
	BuildingDialog {
		id: building_dialog
	}
	
	ModifierDialog {
		id: building_modifier_dialog
	}
	
	BuildBuildingDialog {
		id: build_building_dialog
	}
}
