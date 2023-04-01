import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
	id: right_bar
	color: interface_background_color
	width: 16 * scale_factor
	
	Rectangle {
		color: "gray"
		anchors.top: parent.top
		anchors.topMargin: 15 * scale_factor
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 15 * scale_factor
		anchors.left: parent.left
		width: 1 * scale_factor
	}
}
