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
			readonly property var character_tooltip: character.full_name + format_text(small_text("\n"
				+ get_character_landed_titles_tooltip(character.game_data.landed_titles)
				+ "\nCulture: " + character.culture.name
				+ "\nReligion: " + character.religion.name
				+ "\nPrimary Attribute: " + character.type.primary_attribute_name
				+ "\nDiplomacy: " + character.game_data.diplomacy
				+ "\nMartial: " + character.game_data.martial
				+ "\nStewardship: " + character.game_data.stewardship
				+ "\nIntrigue: " + character.game_data.intrigue
				+ "\nLearning: " + character.game_data.learning
			))
			
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
				
				SmallText {
					id: character_primary_attribute_value_label
					text: number_string(character.game_data.primary_attribute_value)
					anchors.top: character_type_label.top
					anchors.right: parent.right
					anchors.rightMargin: 8 * scale_factor
				}
				
				MouseArea {
					anchors.fill: parent
					ToolTip.text: character_tooltip
					ToolTip.visible: containsMouse
					ToolTip.delay: 1000
					hoverEnabled: true
					
					onClicked: {
						if (selected_character === character) {
							selected_character = null
						} else {
							selected_character = character
						}
					}
				}
				
				Image {
					id: primary_attribute_icon
					anchors.verticalCenter: character_primary_attribute_value_label.verticalCenter
					anchors.left: character_primary_attribute_value_label.right
					anchors.leftMargin: -40 * scale_factor
					source: "image://icon/" + metternich.defines.get_attribute_icon_identifier(character.type.primary_attribute_index) + "/small"
					
					MouseArea {
						anchors.fill: parent
						ToolTip.text: character.type.primary_attribute_name
						ToolTip.visible: containsMouse
						ToolTip.delay: 1000
						hoverEnabled: true
					}
				}
				
				Grid {
					id: traits_grid
					anchors.bottom: parent.bottom
					anchors.bottomMargin: 8 * metternich.scale_factor
					anchors.left: character_name_label.left
					columnSpacing: 2 * metternich.scale_factor
					rows: 1
					rowSpacing: 0
					
					Repeater {
						model: character.game_data.traits
						
						Image {
							id: trait_icon
							source: "image://icon/" + model.modelData.icon.identifier + "/small"
							
							MouseArea {
								anchors.fill: parent
								ToolTip.text: model.modelData.name + (model.modelData.modifier_string.length > 0 ? format_text(small_text("\n\n" + model.modelData.modifier_string)) : "")
								ToolTip.visible: containsMouse
								ToolTip.delay: 1000
								hoverEnabled: true
							}
						}
					}
				}
			}
			
			PortraitButton {
				id: portrait
				portrait_identifier: character.portrait.identifier
				tooltip: character_tooltip
				
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
	
	function get_character_landed_titles_tooltip(landed_titles) {
		var str_list = []
		
		for (var landed_title of landed_titles) {
			str_list.push(landed_title.game_data.ruler_title_name + " of " + landed_title.name)
		}
		
		return str_list
	}
}
