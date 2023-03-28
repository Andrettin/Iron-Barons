import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
	id: infopanel
	width: infopanel_image.width
	
	readonly property var end_turn_button: end_turn_button_internal
	readonly property var province_game_data: (selected_site && selected_site_game_data && selected_site.settlement) ? selected_site_game_data.province.game_data : null
	readonly property var selected_site_game_data: selected_site ? selected_site.game_data : null
	
	Image {
		id: infopanel_image
		anchors.top: parent.top
		anchors.left: parent.left
		source: "image://interface/" + interface_style + "/infopanel"
		fillMode: Image.PreserveAspectCrop
	}
	
	IconButton {
		id: characters_button
		anchors.top: industry_button.top
		anchors.left: parent.left
		anchors.leftMargin: 4 * scale_factor
		icon_identifier: "rifle_infantry_light_small"
		
		onReleased: {
			menu_stack.push("CharactersView.qml")
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "View Characters"
			} else {
				status_text = ""
			}
		}
	}
	
	IconButton {
		id: industry_button
		anchors.top: parent.top
		anchors.topMargin: 8 * scale_factor
		anchors.left: characters_button.right
		anchors.leftMargin: 4 * scale_factor
		icon_identifier: "settlement"
		
		onReleased: {
			menu_stack.push("IndustryView.qml", {
				country: metternich.game.player_country,
				interface_style: map_view.interface_style
			})
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "View Industry"
			} else {
				status_text = ""
			}
		}
	}
	
	IconButton {
		id: diplomatic_map_button
		anchors.top: industry_button.top
		anchors.left: industry_button.right
		anchors.leftMargin: 4 * scale_factor
		icon_identifier: "globe"
		
		onReleased: {
			menu_stack.push("DiplomaticMapView.qml", {
				start_tile_x: map_area_start_x + map_area_tile_width / 2,
				start_tile_y: map_area_start_y + map_area_tile_height / 2
			})
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "View Diplomatic Map"
			} else {
				status_text = ""
			}
		}
	}
	
	IconButton {
		id: technology_button
		anchors.top: diplomatic_map_button.top
		anchors.left: diplomatic_map_button.right
		anchors.leftMargin: 4 * scale_factor
		icon_identifier: "cog"
		
		onReleased: {
			menu_stack.push("TechnologyView.qml")
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "View Technologies"
			} else {
				status_text = ""
			}
		}
	}
	
	NormalText {
		id: title
		anchors.top: industry_button.bottom
		anchors.topMargin: 8 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		text: selected_site ? (
			selected_garrison ? "Garrison" : selected_site.game_data.current_cultural_name
		) : (selected_civilian_unit ? selected_civilian_unit.type.name : "")
	}
	
	Image {
		id: icon
		anchors.top: title.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		source: icon_identifier.length > 0 ? ("image://icon/" + icon_identifier) : "image://empty/"
		visible: !selected_garrison
		
		readonly property string icon_identifier: selected_civilian_unit ? selected_civilian_unit.icon.identifier : (
			selected_site ? (
				selected_site.settlement ? "settlement" : (
					(selected_site.game_data.improvement && selected_site.game_data.improvement.ruins) ? "skull" : (selected_site.resource.icon ? selected_site.resource.icon.identifier : selected_site.resource.commodity.icon.identifier)
				)
			) : ""
		)
		
		MouseArea {
			anchors.fill: parent
			hoverEnabled: true
			
			onEntered: {
				status_text = title.text
				if (subtitle.text.length > 0) {
					status_text += " (" + subtitle.text + ")"
				}
			}
			
			onExited: {
				status_text = ""
			}
		}
	}
	
	SmallText {
		id: subtitle
		anchors.top: icon.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		text: (selected_site && !selected_garrison) ? (
			selected_site.settlement ? "Settlement" : (
				selected_site.game_data.improvement ? (
					selected_site.game_data.improvement.name
				) : (
					selected_site.resource ? selected_site.resource.name : ""
				)
			)
		) : ""
	}
	
	Grid {
		id: scripted_modifiers_grid
		anchors.top: subtitle.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		height: 16 * scale_factor
		columnSpacing: 2 * scale_factor
		rows: 1
		rowSpacing: 0
		visible: selected_site && !selected_garrison
		
		Repeater {
			model: province_game_data ? province_game_data.scripted_modifiers : []
			
			ScriptedModifierImage {
				scripted_modifier_pair: model.modelData
			}
		}
	}
	
	SmallText {
		id: site_info_text
		anchors.top: province_game_data ? scripted_modifiers_grid.bottom : subtitle.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.left: parent.left
		anchors.leftMargin: 12 * scale_factor
		text: province_game_data ? (
			""
		) : (selected_site_game_data ? (
			(selected_site_game_data.output > 0 ? ("Output: " + selected_site_game_data.output) : "")
		) : "")
		visible: selected_site && !selected_garrison
	}
	
	Grid {
		id: military_unit_grid
		anchors.top: title.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.bottom: end_turn_button_internal.top
		anchors.bottomMargin: 16 * scale_factor
		anchors.left: parent.left
		anchors.right: parent.right
		columns: 2
		visible: selected_site !== null && selected_garrison
		
		Repeater {
			model: (selected_site !== null && selected_garrison) ? selected_site.game_data.province.game_data.military_unit_category_counts : []
			
			Item {
				width: 80 * scale_factor
				height: 72 * scale_factor
				
				readonly property var military_unit_category: model.modelData.key
				readonly property int military_unit_count: model.modelData.value
				readonly property int country_military_unit_count: selected_site.game_data.province.game_data.get_country_military_unit_category_count(military_unit_category, metternich.game.player_country)
				
				Image {
					id: military_unit_icon
					anchors.verticalCenter: parent.verticalCenter
					anchors.left: parent.left
					anchors.leftMargin: 4 * scale_factor + (64 * scale_factor - military_unit_icon.width) / 2
					source: "image://icon/" + selected_site.game_data.province.game_data.get_military_unit_category_icon(military_unit_category).identifier
				}
				
				MouseArea {
					anchors.fill: parent
					hoverEnabled: true
					
					onEntered: {
						status_text = selected_site.game_data.province.game_data.get_military_unit_category_name(military_unit_category)
					}
					
					onExited: {
						status_text = ""
					}
				}
				
				Image {
					id: military_unit_up_arrow_icon
					anchors.right: parent.right
					anchors.rightMargin: 4 * scale_factor
					anchors.bottom: military_unit_selected_count_label.top
					anchors.bottomMargin: 4 * scale_factor
					source: "image://icon/embassy"
					
					MouseArea {
						anchors.fill: parent
						
						onReleased: {
							metternich.change_selected_military_unit_category_count(military_unit_category, 1, selected_site.game_data.province)
							military_unit_selected_count_label.text = number_string(metternich.get_selected_military_unit_category_count(military_unit_category))
						}
					}
				}
				
				SmallText {
					id: military_unit_selected_count_label
					text: number_string(metternich.get_selected_military_unit_category_count(military_unit_category))
					anchors.right: parent.right
					anchors.rightMargin: 4 * scale_factor
					anchors.bottom: military_unit_down_arrow_icon.top
					anchors.bottomMargin: 4 * scale_factor
				}
				
				Image {
					id: military_unit_down_arrow_icon
					anchors.right: parent.right
					anchors.rightMargin: 4 * scale_factor
					anchors.bottom: military_unit_count_label.top
					anchors.bottomMargin: 4 * scale_factor
					source: "image://icon/embassy"
					
					MouseArea {
						anchors.fill: parent
						
						onReleased: {
							metternich.change_selected_military_unit_category_count(military_unit_category, -1, selected_site.game_data.province)
							military_unit_selected_count_label.text = number_string(metternich.get_selected_military_unit_category_count(military_unit_category))
						}
					}
				}
				
				SmallText {
					id: military_unit_count_label
					text: military_unit_count === country_military_unit_count ? number_string(military_unit_count) : (number_string(country_military_unit_count) + " (" + number_string(military_unit_count) + ")")
					anchors.bottom: parent.bottom
					anchors.right: parent.right
					anchors.rightMargin: 4 * scale_factor
				}
			}
		}
	}
	
	TextButton {
		id: disband_button
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: end_turn_button_internal.top
		anchors.bottomMargin: 8 * scale_factor
		text: qsTr("Disband")
		width: 64 * scale_factor
		height: 24 * scale_factor
		visible: selected_civilian_unit !== null
		
		onClicked: {
			selected_civilian_unit.disband()
			selected_civilian_unit = null
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "Disband Civilian Unit"
			} else {
				status_text = ""
			}
		}
	}
	
	TextButton {
		id: end_turn_button_internal
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 8 * scale_factor
		text: qsTr("End Turn")
		width: 64 * scale_factor
		height: 24 * scale_factor
		
		onClicked: {
			metternich.game.do_turn_async()
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "End Turn"
			} else {
				status_text = ""
			}
		}
	}
}
