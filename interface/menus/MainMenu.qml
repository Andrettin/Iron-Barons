import QtQuick 2.12
import QtQuick.Controls 2.12
import ".."

MenuBase {
	id: main_menu
	title: qsTr("Main Menu")
	
	Button {
		id: play_scenario_button
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		text: qsTr("Play Scenario")
		width: 128
		height: 48
		
		onClicked: {
			menu_stack.push("ScenarioMenu.qml")
		}
	}
	
	Button {
		id: exit_button
		anchors.horizontalCenter: play_scenario_button.horizontalCenter
		anchors.top: play_scenario_button.bottom
		anchors.topMargin: 8 * 2
		text: qsTr("Exit")
		width: 128
		height: 48
		
		onClicked: {
			window.close()
		}
	}
}
