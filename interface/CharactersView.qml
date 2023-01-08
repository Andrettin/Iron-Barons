import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
	id: characters_view
	
	property var selected_character: null
	
	MouseArea {
		anchors.fill: parent
		
		onClicked: {
			selected_character = null
		}
	}
	
	ListView {
		id: character_list
		anchors.left: parent.left
		anchors.leftMargin: 16 * scale_factor
		anchors.top: parent.top
		anchors.topMargin: 16 * scale_factor
		width: (64 / 2 + 256 + 1) * scale_factor
		height: Math.min(contentHeight, parent.height - y - (parent.height - back_button.y) - 16 * scale_factor)
		boundsBehavior: Flickable.StopAtBounds
		clip: true
		model: metternich.game.player_country.game_data.characters
		delegate: Item {
			width: portrait.width / 2 + character_rectangle.width
			height: portrait.height
			
			readonly property var character: model.modelData
			
			Rectangle {
				id: character_rectangle
				anchors.verticalCenter: parent.verticalCenter
				anchors.left: portrait.horizontalCenter
				width: 256 * scale_factor
				height: portrait.height
				color: (selected_character == character) ? "olive" : "black"
				border.color: "gray"
				border.width: 1
				
				SmallText {
					text: format_text(character.full_name + "\n\n" + character.type.name)
					anchors.top: parent.top
					anchors.topMargin: 8 * scale_factor
					anchors.left: parent.left
					anchors.leftMargin: 8 * scale_factor + portrait.width / 2
				}
				
				SmallText {
					text: number_string(character.game_data.age)
					anchors.top: parent.top
					anchors.topMargin: 8 * scale_factor
					anchors.right: parent.right
					anchors.rightMargin: 8 * scale_factor
				}
				
				MouseArea {
					anchors.fill: parent
					
					onClicked: {
						if (selected_character === character) {
							selected_character = null
						} else {
							selected_character = character
						}
					}
				}
			}
			
			PortraitButton {
				id: portrait
				portrait_identifier: character.portrait.identifier
				tooltip: character.full_name
				
				onReleased: {
					if (selected_character === character) {
						selected_character = null
					} else {
						selected_character = character
					}
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
