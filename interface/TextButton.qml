import QtQuick 2.12
import QtQuick.Controls 2.12

RoundButton {
	id: button
	width: 96 * scale_factor
	height: 24 * scale_factor
	radius: 5 * scale_factor
	ToolTip.text: tooltip
	ToolTip.visible: hovered && tooltip.length > 0
	ToolTip.delay: 1000
	
	property bool allowed: true
	property string tooltip: ""
	
	signal clicked()
	
    background: Rectangle {
        implicitWidth: 40
        implicitHeight: 40
        radius: button.radius
        color: "black"
        border.color: allowed ? "gray" : "dimGray"
        border.width: 1 * scale_factor
    }
	
	contentItem: SmallText {
		anchors.verticalCenter: button.verticalCenter
		anchors.verticalCenterOffset: button.down && allowed ? 1 * scale_factor : 0
		anchors.horizontalCenter: button.horizontalCenter
		anchors.horizontalCenterOffset: button.down && allowed ? 1 * scale_factor : 0
		text: button.text
		color: allowed ? "white" : "gray"
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
	}
	
	onReleased: {
		if (!allowed) {
			return
		}
		
		button.clicked()
	}
}
