import QtQuick 2.12
import QtQuick.Controls 2.12
import ".."

MenuBase {
	id: main_menu
	title: qsTr("Scenario")
	
	Button {
		id: start_game_button
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		text: qsTr("Start Game")
		width: 128
		height: 48
		
		onClicked: {
			var scenario = metternich.get_scenarios()[0]
			metternich.game.start_scenario(scenario)
		}
	}
	
	Button {
		id: previous_menu_button
		anchors.horizontalCenter: start_game_button.horizontalCenter
		anchors.top: start_game_button.bottom
		anchors.topMargin: 8 * 2
		text: qsTr("Previous Menu")
		width: 128
		height: 48
		
		onClicked: {
			menu_stack.pop()
		}
	}
}
