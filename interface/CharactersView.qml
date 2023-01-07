import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
	id: characters_view
	
	property var selected_character: null
	
	ListView {
		id: character_list
		anchors.left: parent.left
		anchors.leftMargin: 16 * scale_factor
		anchors.top: parent.top
		anchors.topMargin: 16 * scale_factor
		anchors.bottom: back_button.top
		anchors.bottomMargin: 16 * scale_factor
		width: 256 * scale_factor
		boundsBehavior: Flickable.StopAtBounds
		clip: true
		model: metternich.game.player_country.game_data.characters
		delegate: Rectangle {
			width: 256 * scale_factor
			height: 16 * scale_factor
			color: (selected_character == model.modelData) ? "olive" : "black"
			border.color: "white"
			border.width: 1
			
			SmallText {
				text: model.modelData.full_name + ", " + date_year_string(model.modelData.start_date)
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.verticalCenter: parent.verticalCenter
			}
			
			MouseArea {
				anchors.fill: parent
				
				onClicked: {
					if (selected_character === model.modelData) {
						return
					}
					
					selected_character = model.modelData
				}
			}
		}
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
