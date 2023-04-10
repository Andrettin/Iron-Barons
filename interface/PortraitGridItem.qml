import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
	id: portrait_grid_item
	width: portrait_grid_view.cellWidth
	height: portrait_grid_view.cellHeight
	ToolTip.text: tooltip
	ToolTip.visible: portrait_mouse_area.containsMouse && tooltip.length > 0
	ToolTip.delay: 1000
	
	property string portrait_identifier: ""
	property string tooltip: ""
	
	signal clicked()
	signal entered()
	signal exited()
	
	readonly property var building_slot: model.modelData
	readonly property var building: building_slot.building
	
	Rectangle {
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		width: portrait.width + 2 * scale_factor
		height: portrait.height + 2 * scale_factor
		border.color: portrait_mouse_area.containsMouse ? "white" : "gray"
		border.width: 1 * scale_factor
		
		Image {
			id: portrait
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.verticalCenter: parent.verticalCenter
			source: "image://portrait/" + portrait_identifier
		}
		
		MouseArea {
			id: portrait_mouse_area
			anchors.fill: parent
			hoverEnabled: true
			
			onClicked: {
				portrait_grid_item.clicked()
			}
			
			onEntered: {
				portrait_grid_item.entered()
			}
			
			onExited: {
				portrait_grid_item.exited()
			}
		}
	}
}
