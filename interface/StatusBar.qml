import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
	id: status_bar
	color: interface_background_color
	height: 16 * scale_factor
	
	Rectangle {
		color: "gray"
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.rightMargin: 15 * scale_factor
		anchors.top: parent.top
		height: 1 * scale_factor
	}
	
	SmallText {
		id: left_status_label
		text: status_text
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 1 * scale_factor
		anchors.left: parent.left
		anchors.leftMargin: 16 * scale_factor
	}
}
