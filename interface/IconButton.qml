import QtQuick 2.12
import QtQuick.Controls 2.12

ButtonBase {
	id: button
	width: icon_image.width + 6 * scale_factor
	height: icon_image.height + 6 * scale_factor
	
	property string icon_identifier: ""
	property color background_color: "black"
	property color border_color: "gray"
	property bool unrounded_left_corners: false
	
    background: Rectangle {
        implicitWidth: 40
        implicitHeight: 40
        radius: button.radius
        color: background_color
        border.color: border_color
        border.width: 1 * scale_factor
		
		Rectangle {
			width: parent.width / 2
			height: parent.height
			color: background_color
			border.color: border_color
			border.width: 1 * scale_factor
			visible: unrounded_left_corners
		}
		
		Rectangle {
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.verticalCenter: parent.verticalCenter
			width: parent.width / 2
			height: parent.height - parent.border.width * 2
			color: background_color
			visible: unrounded_left_corners
		}
    }
	
	Image {
		id: icon_image
		anchors.verticalCenter: parent.verticalCenter
		anchors.verticalCenterOffset: button.down ? 1 * scale_factor : 0
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.horizontalCenterOffset: button.down ? 1 * scale_factor : 0
		source: "image://icon/" + icon_identifier
		fillMode: Image.Pad
	}
}
