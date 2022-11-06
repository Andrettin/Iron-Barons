import QtQuick 2.12
import QtQuick.Controls 2.12

RoundButton {
	id: button
	width: 38 * scale_factor
	height: 38 * scale_factor
	radius: 5 * scale_factor
	
    background: Rectangle {
        implicitWidth: 40
        implicitHeight: 40
        radius: button.radius
        color: "black"
        border.color: "gray"
        border.width: 1 * scale_factor
    }
	
	contentItem: SmallText {
		anchors.verticalCenter: button.verticalCenter
		anchors.verticalCenterOffset: button.down ? 1 * scale_factor : 0
		anchors.horizontalCenter: button.horizontalCenter
		anchors.horizontalCenterOffset: button.down ? 1 * scale_factor : 0
		text: button.text
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
	}
}
