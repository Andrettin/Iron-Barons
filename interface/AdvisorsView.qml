import QtQuick
import QtQuick.Controls
import "./dialogs"

Item {
	id: advisors_view
	
	readonly property var minister_offices: get_minister_offices(country_game_data.available_offices)
	readonly property var offices: filter_offices(country_game_data.available_offices)
	
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
	
	PortraitGrid {
		id: minister_portrait_grid
		anchors.top: ruler_portrait.visible ? ruler_portrait.bottom : parent.top
		anchors.topMargin: spacing
		anchors.horizontalCenter: parent.horizontalCenter
		entries: minister_offices
		delegate: PortraitGridItem {
			portrait_identifier: office_holder ? office_holder.game_data.portrait.identifier : "no_character"
			
			readonly property var office: model.modelData
			readonly property var office_holder: country_game_data.get_office_holder(office)
			
			onClicked: {
				if (office_holder !== null) {
					character_dialog.character = office_holder
					character_dialog.modifier_string = office_holder.game_data.get_office_modifier_qstring(country, office)
					character_dialog.open()
				}
			}
			
			onEntered: {
				status_text = office_holder ? office_holder.game_data.titled_name : country_game_data.get_office_title_name_qstring(office)
			}
			
			onExited: {
				status_text = ""
			}
		}
	}
	
	PortraitGrid {
		id: office_holder_portrait_grid
		anchors.top: minister_portrait_grid.visible ? minister_portrait_grid.bottom : (ruler_portrait.visible ? ruler_portrait.bottom : parent.top)
		anchors.topMargin: spacing
		anchors.horizontalCenter: parent.horizontalCenter
		entries: offices
		delegate: PortraitGridItem {
			portrait_identifier: office_holder ? office_holder.game_data.portrait.identifier : "no_character"
			
			readonly property var office: model.modelData
			readonly property var office_holder: country_game_data.get_office_holder(office)
			
			onClicked: {
				if (office_holder !== null) {
					character_dialog.character = office_holder
					character_dialog.modifier_string = office_holder.game_data.get_office_modifier_qstring(country, office)
					character_dialog.open()
				}
			}
			
			onEntered: {
				status_text = office_holder ? office_holder.game_data.titled_name : country_game_data.get_office_title_name_qstring(office)
			}
			
			onExited: {
				status_text = ""
			}
		}
	}
	
	PortraitGrid {
		id: advisor_portrait_grid
		anchors.top: office_holder_portrait_grid.visible ? office_holder_portrait_grid.bottom : (minister_portrait_grid.visible ? minister_portrait_grid.bottom : (ruler_portrait.visible ? ruler_portrait.bottom : parent.top))
		anchors.topMargin: spacing
		anchors.bottom: parent.bottom
		anchors.horizontalCenter: parent.horizontalCenter
		entries: country_game_data.advisors
		delegate: PortraitGridItem {
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
	
	CharacterDialog {
		id: character_dialog
	}
	
	function get_minister_offices(offices) {
		var result = []
		
		for (var office of offices) {
			if (!office.minister) {
				continue
			}
			
			result.push(office)
		}
		
		return result
	}
	
	function filter_offices(offices) {
		var result = []
		
		for (var office of offices) {
			if (office.ruler || office.minister) {
				continue
			}
			
			result.push(office)
		}
		
		return result
	}
}
