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
		width: 64 * scale_factor
		height: 24 * scale_factor
		
		onClicked: {
			menu_stack.push("ScenarioMenu.qml")
		}
	}
	
	Button {
		id: exit_button
		anchors.horizontalCenter: play_scenario_button.horizontalCenter
		anchors.top: play_scenario_button.bottom
		anchors.topMargin: 8 * scale_factor
		text: qsTr("Exit")
		width: 64 * scale_factor
		height: 24 * scale_factor
		
		onClicked: {
			window.close()
		}
	}
}
