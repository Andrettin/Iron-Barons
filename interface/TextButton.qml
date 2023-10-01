import QtQuick
import QtQuick.Controls

ButtonBase {
	id: button
	width: 96 * scale_factor
	height: 24 * scale_factor
	
	property bool allowed: true
	readonly property int text_content_width: text.contentWidth
	
	signal clicked()
	
    background: Rectangle {
        implicitWidth: 40
        implicitHeight: 40
        radius: button.radius
        color: highlighted ? "dimGray" : "black"
        border.color: allowed ? "gray" : "dimGray"
        border.width: 1 * scale_factor
    }
	
	contentItem: SmallText {
		id: text
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
