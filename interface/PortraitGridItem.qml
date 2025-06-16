import QtQuick
import QtQuick.Controls

Item {
	id: portrait_grid_item
	width: portrait_button.width
	height: portrait_button.height
	
	property string portrait_identifier: ""
	property string tooltip: ""
	
	signal clicked()
	signal entered()
	signal exited()
	
	PortraitButton {
		id: portrait_button
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		portrait_identifier: portrait_grid_item.portrait_identifier
		
		onClicked: {
			portrait_grid_item.clicked()
		}
		
		onHoveredChanged: {
			if (hovered) {
				portrait_grid_item.entered()
			} else {
				portrait_grid_item.exited()
			}
		}
	}
	
	CustomTooltip {
		text: portrait_grid_item.tooltip
		visible: portrait_mouse_area.containsMouse && portrait_grid_item.tooltip.length > 0
	}
}
