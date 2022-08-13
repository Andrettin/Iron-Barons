import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

Window {
	id: window
	visible: true
	title: qsTr("Iron Barons")
	width: Screen.width
	height: Screen.height + 1 //it needs to be +1 otherwise it becomes (non-borderless) fullscreen automatically
	flags: Qt.FramelessWindowHint | Qt.Window
	color: "black"
	
	Button {
		id: start_game_button
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		text: qsTr("Start Game")
		width: 128
		height: 48
		
		onClicked: {
		}
	}
	
	Button {
		id: exit_button
		anchors.horizontalCenter: start_game_button.horizontalCenter
		anchors.top: start_game_button.bottom
		anchors.topMargin: 8 * 2
		text: qsTr("Exit")
		width: 128
		height: 48
		
		onClicked: {
			window.close()
		}
	}
}
