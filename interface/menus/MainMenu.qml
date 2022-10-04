import QtQuick 2.12
import QtQuick.Controls 2.12
import ".."

MenuBase {
	id: main_menu
	title: qsTr("Main Menu")
	
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
