import QtQuick
import QtQuick.Controls
import "./dialogs"

Item {
	id: advisors_view
	
	PortraitGridItem {
		id: ruler_portrait
		anchors.top: parent.top
		anchors.topMargin: portrait_grid.spacing
		anchors.horizontalCenter: parent.horizontalCenter
		portrait_identifier: ruler ? ruler.game_data.portrait.identifier : ""
		visible: ruler !== null
		
		onClicked: {
			character_dialog.character = ruler
			character_dialog.modifier_string = ruler.game_data.get_ruler_modifier_qstring(country)
			character_dialog.open()
		}
		
		onEntered: {
			status_text = ruler.game_data.titled_name
		}
		
		onExited: {
			status_text = ""
		}
	}
	
	Grid {
		id: portrait_grid
		anchors.top: ruler_portrait.visible ? ruler_portrait.bottom : parent.top
		anchors.topMargin: spacing
		anchors.bottom: parent.bottom
		anchors.horizontalCenter: parent.horizontalCenter
		width: columns * (portrait_width + spacing) - spacing
		columns: Math.floor((parent.width - min_spacing) / (portrait_width + min_spacing))
		spacing: Math.max(min_spacing, Math.floor((parent.width - columns * portrait_width) / (columns + 1)))
		
		readonly property int portrait_width: 64 * scale_factor + 2 * scale_factor
		readonly property int min_spacing: 16 * scale_factor
		
		Repeater {
			model: country_game_data.advisors
			
			PortraitGridItem {
				portrait_identifier: advisor.game_data.portrait.identifier
				
				readonly property var advisor: model.modelData
				
				onClicked: {
					character_dialog.character = advisor
					character_dialog.modifier_string = advisor.game_data.get_advisor_effects_string(country)
					character_dialog.open()
				}
				
				onEntered: {
					status_text = advisor.full_name
				}
				
				onExited: {
					status_text = ""
				}
				
				Grid {
					id: new_advisor_cover
					anchors.horizontalCenter: parent.horizontalCenter
					anchors.verticalCenter: parent.verticalCenter
					width: 64 * scale_factor
					height: 64 * scale_factor
					columns: 64 * scale_factor
					rows: 64 * scale_factor
					visible: advisor === new_advisor
					
					property var cover_pixels: []
					
					Repeater {
						model: (advisor === new_advisor) ? (new_advisor_cover.width * new_advisor_cover.height) : 0
						
						Rectangle {
							color: "black"
							width: 1
							height: 1
							
							Component.onCompleted: {
								new_advisor_cover.cover_pixels.push(this)
							}
						}
					}
					
					Timer {
						id: new_advisor_timer
						running: new_advisor_cover.visible
						repeat: true
						interval: 1
						onTriggered: {
							var pixel_change_count = Math.floor(2 * scale_factor * scale_factor)
							for (var i = 0; i < pixel_change_count; i++) {
								if (new_advisor_cover.cover_pixels.length === 0) {
									running = false
									repeat = false
									return
								}
								
								var pixel_index = random(new_advisor_cover.cover_pixels.length)
								var pixel_item = new_advisor_cover.cover_pixels[pixel_index]
								pixel_item.color = "transparent"
								new_advisor_cover.cover_pixels.splice(pixel_index, 1)
							}
						}
					}
				}
			}
		}
	}
	
	CharacterDialog {
		id: character_dialog
	}
}
