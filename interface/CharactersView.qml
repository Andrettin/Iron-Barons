import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
	id: characters_view
	
	property var selected_character: null
	readonly property var head_of_government_office: metternich.defines.head_of_government_office
	
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
			readonly property string character_tooltip: portrait.tooltip
			
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
					anchors.bottomMargin: 8 * scale_factor
					anchors.left: character_name_label.left
					columnSpacing: 2 * scale_factor
					rows: 1
					rowSpacing: 0
					
					Repeater {
						model: character.game_data.traits
						
						Image {
							id: trait_icon
							source: "image://icon/" + model.modelData.icon.identifier + "/small"
							
							readonly property var trait: model.modelData
							readonly property string modifier_string: trait.modifier_string
							readonly property string military_unit_modifier_string: character.game_data.deployable ? trait.military_unit_modifier_string : ""
							
							MouseArea {
								anchors.fill: parent
								ToolTip.text: trait.name
									+ ((modifier_string.length > 0 || military_unit_modifier_string.length > 0) ? format_text(small_text("\n")) : "")
									+ (modifier_string.length > 0 ? format_text(small_text("\n" + modifier_string)) : "")
									+ (military_unit_modifier_string.length > 0 ? format_text(small_text("\n" + military_unit_modifier_string)) : "")
								ToolTip.visible: containsMouse
								ToolTip.delay: 1000
								hoverEnabled: true
							}
						}
					}
					
					Repeater {
						model: character.game_data.scripted_modifiers
						
						Image {
							id: modifier_icon
							source: "image://icon/" + scripted_modifier.icon.identifier + "/small/" + (scripted_modifier.negative ? "red" : "green")
							
							readonly property var scripted_modifier: model.modelData.key
							readonly property int duration: model.modelData.value
							readonly property string modifier_string: scripted_modifier.modifier_string
							
							MouseArea {
								anchors.fill: parent
								ToolTip.text: scripted_modifier.name + (modifier_string.length > 0 ? format_text(small_text("\n"
								+ "\nDuration: " + (duration * metternich.defines.months_per_turn) + " Months"
								+ "\n" + modifier_string)) : "")
								ToolTip.visible: containsMouse
								ToolTip.delay: 1000
								hoverEnabled: true
							}
						}
					}
				}
			}
			
			CharacterPortrait {
				id: portrait
				character: model.modelData
				
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
	
	SmallText {
		id: ruler_label
		text: metternich.game.player_country.title.game_data.ruler_title_name
		anchors.top: character_list.top
		anchors.horizontalCenter: ruler_portrait.horizontalCenter
	}
	
	CharacterPortrait {
		id: ruler_portrait
		character: metternich.game.player_country.game_data.ruler
		anchors.top: ruler_label.bottom
		anchors.topMargin: 8 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.horizontalCenterOffset: character_list.width / 2
	}
	
	SmallText {
		id: head_of_government_label
		text: head_of_government_office.name
		anchors.top: ruler_portrait.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: ruler_portrait.horizontalCenter
	}
	
	CharacterPortrait {
		id: head_of_government_portrait
		character: metternich.game.player_country.game_data.get_office_character(head_of_government_office)
		anchors.top: head_of_government_label.bottom
		anchors.topMargin: 8 * scale_factor
		anchors.horizontalCenter: ruler_portrait.horizontalCenter
	}
	
	ListView {
		id: office_list
		anchors.horizontalCenter: ruler_portrait.horizontalCenter
		anchors.top: head_of_government_portrait.bottom
		anchors.topMargin: 16 * scale_factor
		width: contentWidth
		height: contentHeight
		orientation: ListView.Horizontal
		boundsBehavior: Flickable.StopAtBounds
		spacing: 64 * scale_factor
		model: metternich.game.player_country.game_data.offices
		delegate: Item {
			width: portrait.width
			height: portrait.height + office_label.height + 8 * scale_factor
			
			readonly property var office: model.modelData
			readonly property string character_tooltip: portrait.tooltip
			
			SmallText {
				id: office_label
				text: office.name
				anchors.top: parent.top
				anchors.horizontalCenter: parent.horizontalCenter
			}
			
			CharacterPortrait {
				id: portrait
				anchors.top: office_label.bottom
				anchors.topMargin: 8 * scale_factor
				anchors.horizontalCenter: parent.horizontalCenter
				character: metternich.game.player_country.game_data.get_office_character(office)
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
