import QtQuick
import QtQuick.Controls

ItemButton {
	id: button
	width: 96 * scale_factor
	height: 24 * scale_factor
	
	readonly property int text_content_width: text.contentWidth
	
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
}
