import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

ButtonBase {
	id: button
	width: portrait_image.width + 2 * scale_factor
	height: portrait_image.height + 2 * scale_factor
	radius: width * 0.5
	
	property string portrait_identifier: ""
	property color background_color: "black"
	property color border_color: "gray"
	
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
		source: "image://icon/" + portrait_identifier
		fillMode: Image.Pad
		visible: false
	}
	
	Rectangle {
		id: opacity_mask_rectangle
        anchors.fill: portrait_image
		width: portrait_image.width
		height: portrait_image.height
		radius: width * 0.5
		visible: false
	}
	
    OpacityMask {
        anchors.fill: portrait_image
        source: portrait_image
        maskSource: opacity_mask_rectangle
    }
}