import QtQuick
import QtQuick.Controls

ButtonBase {
	id: button
	width: icon_image.width + 6 * scale_factor
	height: icon_image.height + 6 * scale_factor
	radius: circle ? (width * 0.5) : 5 * scale_factor
	
	property string icon_identifier: ""
	property color background_color: "black"
	property color border_color: "gray"
	property bool circle: false
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
	
	Item {
		id: icon_image_area
		anchors.verticalCenter: parent.verticalCenter
		anchors.horizontalCenter: parent.horizontalCenter
		width: parent.width - 1 * scale_factor * 2 //width inside the border
		height: parent.height - 1 * scale_factor * 2
		layer.enabled: true
		visible: false
		
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
	
	OpacityMask {
		id: opacity_mask_rectangle
        anchors.fill: icon_image_area
		width: icon_image_area.width
		height: icon_image_area.height
		radius: circle ? (width * 0.5) : 5 * scale_factor
        source: icon_image_area
	}
}
