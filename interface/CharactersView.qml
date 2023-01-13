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
					id: character_name_label
					text: character.full_name
					anchors.top: parent.top
					anchors.topMargin: 8 * scale_factor
					anchors.left: parent.left
					anchors.leftMargin: 8 * scale_factor + portrait.width / 2
				}
				
				SmallText {
					id: character_type_label
					text: character.type.name
					anchors.top: character_name_label.bottom
					anchors.topMargin: 4 * scale_factor
					anchors.left: character_name_label.left
				}
				
				SmallText {
					id: character_age_label
					text: number_string(character.game_data.age)
					anchors.top: character_name_label.top
					anchors.right: parent.right
					anchors.rightMargin: 8 * scale_factor
				}
				
				Image {
					id: primary_attribute_icon
					anchors.verticalCenter: character_primary_attribute_value_label.verticalCenter
					anchors.left: parent.right
					anchors.leftMargin: -64 * scale_factor
					source: "image://icon/" + metternich.defines.get_attribute_icon_identifier(character.type.primary_attribute_index)
				}
				
				SmallText {
					id: character_primary_attribute_value_label
					text: number_string(character.game_data.primary_attribute_value)
					anchors.top: character_type_label.top
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
