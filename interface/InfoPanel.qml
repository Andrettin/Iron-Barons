import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
	id: infopanel
	color: interface_background_color
	width: 176 * scale_factor
	
	readonly property var end_turn_button: end_turn_button_internal
	readonly property var province_game_data: selected_province ? selected_province.game_data : null
	readonly property var selected_site_game_data: selected_site ? selected_site.game_data : null
	
	Rectangle {
		color: "gray"
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 15 * scale_factor
		anchors.right: parent.right
		width: 1 * scale_factor
	}
	
	IconButton {
		id: transport_button
		anchors.top: industry_button.top
		anchors.left: parent.left
		anchors.leftMargin: 6 * scale_factor
		icon_identifier: "railroad"
		
		onReleased: {
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "View Transport"
			} else {
				status_text = ""
			}
		}
	}
	
	IconButton {
		id: industry_button
		anchors.top: parent.top
		anchors.topMargin: 6 * scale_factor
		anchors.left: transport_button.right
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
			menu_stack.push("DiplomaticView.qml", {
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
	
	NormalText {
		id: title
		anchors.top: industry_button.bottom
		anchors.topMargin: 8 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		text: selected_garrison ? "Garrison" : (
			selected_site ? selected_site.game_data.current_cultural_name
				: (selected_civilian_unit ? selected_civilian_unit.type.name : "")
		)
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
	
	CivilianUnitInfoArea {
		id: civilian_unit_info_area
		anchors.top: icon.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.bottom: disband_button.top
		anchors.bottomMargin: 16 * scale_factor
		anchors.left: parent.left
		anchors.right: parent.right
		visible: selected_civilian_unit !== null
	}
	
	MilitaryUnitGrid {
		id: military_unit_grid
		anchors.top: title.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.bottom: end_turn_button_internal.top
		anchors.bottomMargin: 16 * scale_factor
		anchors.left: parent.left
		anchors.right: parent.right
		visible: selected_province !== null && selected_garrison
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
