import QtQuick 2.12
import QtQuick.Controls 2.12

RoundButton {
	id: button
	width: 38 * scale_factor
	height: 38 * scale_factor
	radius: 5 * scale_factor
	
	property string icon_identifier: ""
	
    background: Rectangle {
        implicitWidth: 40
        implicitHeight: 40
        radius: button.radius
        color: "black"
        border.color: "gray"
        border.width: 1 * scale_factor
    }
	
	Image {
		anchors.verticalCenter: parent.verticalCenter
		anchors.verticalCenterOffset: button.down ? 1 * scale_factor : 0
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.horizontalCenterOffset: button.down ? 1 * scale_factor : 0
		source: "image://icon/" + icon_identifier
		fillMode: Image.Pad
	}
}
