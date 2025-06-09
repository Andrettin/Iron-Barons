import QtQuick
import QtQuick.Controls
import "./dialogs"

Item {
	id: research_organizations_view
	
	readonly property var research_organization_slots: country_game_data.available_research_organization_slots
	
	PortraitGrid {
		id: research_organization_portrait_grid
		anchors.top: parent.top
		anchors.topMargin: spacing
		anchors.horizontalCenter: parent.horizontalCenter
		entries: research_organization_slots
		delegate: PortraitGridItem {
			portrait_identifier: research_organization ? research_organization.portrait.identifier : "no_character"
			
			readonly property var research_organization_slot: model.modelData
			readonly property var research_organization: country_game_data.get_research_organization(research_organization_slot)
			
			onClicked: {
				if (research_organization !== null) {
					research_organization_dialog.title = research_organization.name
					research_organization_dialog.modifier_string = research_organization.get_modifier_qstring(country)
					research_organization_dialog.open()
				}
			}
			
			onEntered: {
				status_text = research_organization ? research_organization.name : research_organization_slot.name + " Slot"
			}
			
			onExited: {
				status_text = ""
			}
		}
	}
	
	ModifierDialog {
		id: research_organization_dialog
	}
}
