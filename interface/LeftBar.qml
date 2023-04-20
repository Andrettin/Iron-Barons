import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
	id: left_bar
	color: interface_background_color
	width: 16 * scale_factor
	
	Rectangle {
		color: "gray"
		anchors.top: parent.top
		anchors.topMargin: 15 * scale_factor
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 15 * scale_factor
		anchors.right: parent.right
		width: 1 * scale_factor
	}
}
