import QtQuick
import QtQuick.Controls
import "./dialogs"

Item {
	id: advisors_view
	
	readonly property var ministers: get_ministers(country_game_data.office_holders)
	readonly property var office_holders: filter_office_holders(country_game_data.office_holders)
	
	PortraitGridItem {
		id: ruler_portrait
		anchors.top: parent.top
		anchors.topMargin: advisor_portrait_grid.spacing
		anchors.horizontalCenter: parent.horizontalCenter
		portrait_identifier: ruler ? ruler.game_data.portrait.identifier : ""
		visible: ruler !== null
		
		onClicked: {
			character_dialog.character = ruler
			character_dialog.modifier_string = ruler.game_data.get_office_modifier_qstring(country, ruler.game_data.office)
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
		id: minister_portrait_grid
		anchors.top: ruler_portrait.visible ? ruler_portrait.bottom : parent.top
		anchors.topMargin: spacing
		anchors.horizontalCenter: parent.horizontalCenter
		width: columns * (portrait_width + spacing) - spacing
		columns: Math.min(Math.floor((parent.width - min_spacing) / (portrait_width + min_spacing)), ministers.length)
		spacing: columns === ministers.length ? min_spacing : Math.max(min_spacing, Math.floor((parent.width - columns * portrait_width) / (columns + 1)))
		visible: ministers.length > 0
		
		readonly property int portrait_width: 64 * scale_factor + 2 * scale_factor
		readonly property int min_spacing: 16 * scale_factor
		
		Repeater {
			model: ministers
			
			PortraitGridItem {
				portrait_identifier: office_holder.game_data.portrait.identifier
				
				readonly property var office: model.modelData.key
				readonly property var office_holder: model.modelData.value
				
				onClicked: {
					character_dialog.character = office_holder
					character_dialog.modifier_string = office_holder.game_data.get_office_modifier_qstring(country, office)
					character_dialog.open()
				}
				
				onEntered: {
					status_text = office_holder.game_data.titled_name
				}
				
				onExited: {
					status_text = ""
				}
			}
		}
	}
	
	Grid {
		id: office_holder_portrait_grid
		anchors.top: minister_portrait_grid.visible ? minister_portrait_grid.bottom : (ruler_portrait.visible ? ruler_portrait.bottom : parent.top)
		anchors.topMargin: spacing
		anchors.horizontalCenter: parent.horizontalCenter
		width: columns * (portrait_width + spacing) - spacing
		columns: Math.min(Math.floor((parent.width - min_spacing) / (portrait_width + min_spacing)), office_holders.length)
		spacing: columns === office_holders.length ? min_spacing : Math.max(min_spacing, Math.floor((parent.width - columns * portrait_width) / (columns + 1)))
		visible: office_holders.length > 0
		
		readonly property int portrait_width: 64 * scale_factor + 2 * scale_factor
		readonly property int min_spacing: 16 * scale_factor
		
		Repeater {
			model: office_holders
			
			PortraitGridItem {
				portrait_identifier: office_holder.game_data.portrait.identifier
				
				readonly property var office: model.modelData.key
				readonly property var office_holder: model.modelData.value
				
				onClicked: {
					character_dialog.character = office_holder
					character_dialog.modifier_string = office_holder.game_data.get_office_modifier_qstring(country, office)
					character_dialog.open()
				}
				
				onEntered: {
					status_text = office_holder.game_data.titled_name
				}
				
				onExited: {
					status_text = ""
				}
			}
		}
	}
	
	Grid {
		id: advisor_portrait_grid
		anchors.top: office_holder_portrait_grid.visible ? office_holder_portrait_grid.bottom : (minister_portrait_grid.visible ? minister_portrait_grid.bottom : (ruler_portrait.visible ? ruler_portrait.bottom : parent.top))
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
			}
		}
	}
	
	CharacterDialog {
		id: character_dialog
	}
	
	function get_ministers(office_holders) {
		var result = []
		
		for (var kv_pair of office_holders) {
			if (!kv_pair.key.minister) {
				continue
			}
			
			result.push(kv_pair)
		}
		
		return result
	}
	
	function filter_office_holders(office_holders) {
		var result = []
		
		for (var kv_pair of office_holders) {
			if (kv_pair.key.ruler || kv_pair.key.minister) {
				continue
			}
			
			result.push(kv_pair)
		}
		
		return result
	}
}
