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
			portrait_identifier: appointed_research_organization ? appointed_research_organization.portrait.identifier + "/grayscale" : (research_organization ? research_organization.portrait.identifier : "no_character")
			
			readonly property var research_organization_slot: model.modelData
			readonly property var research_organization: country_game_data.research_organizations.length > 0 ? country_game_data.get_research_organization(research_organization_slot) : null //the check here is for the sake of property binding
			readonly property var appointed_research_organization: country_game_data.appointed_research_organizations.length > 0 ? country_game_data.get_appointed_research_organization(research_organization_slot) : null //the check here is for the sake of property binding
			
			onClicked: {
				if (research_organization !== null || appointed_research_organization !== null) {
					research_organization_dialog.research_organization_slot = research_organization_slot
					research_organization_dialog.research_organization = appointed_research_organization ? appointed_research_organization : research_organization
					research_organization_dialog.open()
				} else {
					research_organization_choice_dialog.research_organization_slot = research_organization_slot
					research_organization_choice_dialog.open()
				}
			}
			
			onEntered: {
				status_text = appointed_research_organization ? "Appointing " + appointed_research_organization.name : (research_organization ? research_organization.name : research_organization_slot.name + " Slot")
			}
			
			onExited: {
				status_text = ""
			}
		}
	}
	
	ResearchOrganizationDialog {
		id: research_organization_dialog
	}
	
	ResearchOrganizationChoiceDialog {
		id: research_organization_choice_dialog
	}
}
