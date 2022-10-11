import QtQuick 2.12
import QtQuick.Controls 2.12
import ".."

MenuBase {
	id: main_menu
	title: qsTr("Scenario")
	
	Flickable {
		id: diplomatic_map
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.horizontalCenterOffset: 64 * scale_factor
		anchors.verticalCenter: parent.verticalCenter
		width: 512 * scale_factor
		height: 256 * scale_factor
		contentWidth: contentItem.childrenRect.width
		contentHeight: contentItem.childrenRect.height
		boundsBehavior: Flickable.StopAtBounds
		clip: true
		
		Repeater {
			model: metternich.game.countries
			
			Image {
				id: country_image
				x: model.modelData.game_data.diplomatic_map_image_pos.x
				y: model.modelData.game_data.diplomatic_map_image_pos.y
				source: "image://diplomatic_map/" + model.modelData.identifier
				cache: false
			}
		}
	}
	
	ListView {
		id: scenario_list
		anchors.right: diplomatic_map.left
		anchors.rightMargin: 16 * scale_factor
		anchors.bottom: start_game_button.top
		anchors.bottomMargin: 16 * scale_factor
		width: 256 * scale_factor
		height: 128 * scale_factor
		boundsBehavior: Flickable.StopAtBounds
		clip: true
		model: metternich.get_scenarios()
		delegate: Button {
			text: model.modelData.name + ", " + date_year_string(model.modelData.start_date)
			width: 256 * scale_factor
			height: 24 * scale_factor
			visible: !model.modelData.hidden
			
			onClicked: {
				metternich.game.setup_scenario(model.modelData)
			}
		}
	}
	
	Button {
		id: start_game_button
		anchors.horizontalCenter: scenario_list.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		text: qsTr("Start Game")
		width: 64 * scale_factor
		height: 24 * scale_factor
		
		onClicked: {
			metternich.game.start()
		}
	}
	
	Button {
		id: previous_menu_button
		anchors.horizontalCenter: start_game_button.horizontalCenter
		anchors.top: start_game_button.bottom
		anchors.topMargin: 8 * scale_factor
		text: qsTr("Previous Menu")
		width: 64 * scale_factor
		height: 24 * scale_factor
		
		onClicked: {
			menu_stack.pop()
		}
	}
	
	Component.onCompleted: {
		var scenario = metternich.get_scenarios()[0]
		metternich.game.setup_scenario(scenario)
	}
}
