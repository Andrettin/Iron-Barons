import QtQuick 2.12
import QtQuick.Controls 2.12
import ".."

DialogBase {
	id: warehouse_dialog
	title: "Warehouse"
	panel: 5
	width: 256 * scale_factor + 8 * scale_factor * 2
	height: ok_button.y + ok_button.height + 8 * scale_factor
	
	Grid {
		id: commodities_grid
		anchors.top: title_item.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		columns: 4
		
		Repeater {
			model: province_game_data.owner ? province_game_data.owner.game_data.stored_commodities : []
			
			Item {
				width: 64 * scale_factor
				height: 64 * scale_factor
				
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
		anchors.top: commodities_grid.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		text: "OK"
		onClicked: {
			warehouse_dialog.close()
		}
	}
}