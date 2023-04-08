import QtQuick 2.12
import QtQuick.Controls 2.12
import ".."

BuildingDialog {
	id: warehouse_dialog
	width: 256 * scale_factor + 8 * scale_factor * 2
	height: ok_button.y + ok_button.height + 8 * scale_factor
	
	SmallText {
		id: storage_capacity_label
		anchors.top: title_item.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		text: "Storage Capacity: " + number_string(country_game_data.storage_capacity)
	}
	
	ExpandBuildingButton {
		id: expand_building_button
		anchors.top: parent.top
		anchors.topMargin: 16 * scale_factor
		anchors.right: parent.right
		anchors.rightMargin: 16 * scale_factor
	}
	
	Grid {
		id: commodities_grid
		anchors.top: storage_capacity_label.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		columns: 4
		
		Repeater {
			model: country_game_data.stored_commodities
			
			Item {
				width: 64 * scale_factor
				height: 64 * scale_factor
				visible: !commodity.abstract
				
				readonly property var commodity: model.modelData.key
				readonly property int stored: model.modelData.value
				
				Image {
					id: commodity_icon
					anchors.verticalCenter: parent.verticalCenter
					anchors.horizontalCenter: parent.horizontalCenter
					anchors.horizontalCenterOffset: -8 * scale_factor
					source: "image://icon/" + commodity.icon.identifier
				}
				
				SmallText {
					id: stored_label
					text: number_string(stored)
					anchors.left: commodity_icon.right
					anchors.leftMargin: 4 * scale_factor
					anchors.bottom: commodity_icon.bottom
				}
				
				MouseArea {
					anchors.fill: parent
					hoverEnabled: true
					
					onEntered: {
						status_text = commodity.name
					}
					
					onExited: {
						status_text = ""
					}
				}
			}
		}
	}
	
	TextButton {
		id: ok_button
		anchors.top: commodities_grid.height > 0 ? commodities_grid.bottom : storage_capacity_label.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		text: "OK"
		onClicked: {
			warehouse_dialog.close()
		}
	}
}
