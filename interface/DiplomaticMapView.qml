import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
	id: diplomatic_map_view
	
	Rectangle {
		id: diplomatic_map_background
		anchors.top: parent.top
		anchors.bottom: back_button.top
		anchors.bottomMargin: 8 * scale_factor
		anchors.left: parent.left
		anchors.right: parent.right
		color: Qt.rgba(0.0 / 255.0, 0.0 / 255.0, 0.0 / 255.0, 1)
		border.color: "white"
		border.width: 1
	}
	
	DiplomaticMap {
		id: diplomatic_map
		anchors.top: diplomatic_map_background.top
		anchors.topMargin: 1
		anchors.bottom: diplomatic_map_background.bottom
		anchors.bottomMargin: 1
		anchors.left: parent.left
		anchors.leftMargin: 1
		anchors.right: parent.right
		anchors.rightMargin: 1
		ocean_suffix: "0"
	}
	
	TextButton {
		id: back_button
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 8 * scale_factor
		text: qsTr("Back")
		width: 64 * scale_factor
		height: 24 * scale_factor
		
		onClicked: {
			menu_stack.pop()
		}
	}
}
