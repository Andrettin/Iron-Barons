import QtQuick
import QtQuick.Controls

Item {
	id: portrait_grid_item
	width: portrait_rectangle.width
	height: portrait_rectangle.height
	ToolTip.text: tooltip
	ToolTip.visible: portrait_mouse_area.containsMouse && tooltip.length > 0
	ToolTip.delay: 1000
	
	property string portrait_identifier: ""
	property string tooltip: ""
	
	signal clicked()
	signal entered()
	signal exited()
	
	Rectangle {
		id: portrait_rectangle
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
			source: portrait_identifier.length > 0 ? ("image://portrait/" + portrait_identifier) : "image://empty/"
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
