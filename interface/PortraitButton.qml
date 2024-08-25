import QtQuick
import QtQuick.Controls

ButtonBase {
	id: button
	width: portrait_image.width + 2 * scale_factor
	height: portrait_image.height + 2 * scale_factor
	radius: circle ? (width * 0.5) : 5 * scale_factor
	
	property string portrait_identifier: ""
	property bool circle: false
	property color background_color: "black"
	property color border_color: "gray"
	property bool transparent: false
	
    background: Rectangle {
		id: background_rectangle
        implicitWidth: 40
        implicitHeight: 40
        radius: button.radius
        color: background_color
        border.color: border_color
        border.width: 1 * scale_factor
    }
	
	Image {
		id: portrait_image
		anchors.verticalCenter: parent.verticalCenter
		//anchors.verticalCenterOffset: button.down ? 1 * scale_factor : 0
		anchors.horizontalCenter: parent.horizontalCenter
		//anchors.horizontalCenterOffset: button.down ? 1 * scale_factor : 0
		source: portrait_identifier.length > 0 ? ("image://portrait/" + portrait_identifier) : "image://empty/"
		fillMode: Image.Pad
		layer.enabled: true
		visible: false
	}
	
	OpacityMask {
		id: opacity_mask_rectangle
        anchors.fill: portrait_image
		width: portrait_image.width
		height: portrait_image.height
		radius: button.radius
        source: portrait_image
		opacity: transparent ? 0.25 : 1
	}
}
