import QtQuick 2.12
import QtQuick.Controls 2.12
import ".."

MenuBase {
	id: main_menu
	title: qsTr("Scenario")
	
	Image {
		id: diplomatic_map
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		source: "image://diplomatic_map/" + reload_count
		cache: false
		
		property int reload_count: 0
	}
	
	Button {
		id: start_game_button
		anchors.right: diplomatic_map.left
		anchors.rightMargin: 32
		anchors.verticalCenter: parent.verticalCenter
		text: qsTr("Start Game")
		width: 128
		height: 48
		
		onClicked: {
			metternich.game.start()
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
	
	Connections {
		target: metternich.game
		function onDiplomatic_map_image_changed() {
			diplomatic_map.reload_count += 1
		}
	}
	
	Component.onCompleted: {
		var scenario = metternich.get_scenarios()[0]
		metternich.game.setup_scenario(scenario)
	}
}
