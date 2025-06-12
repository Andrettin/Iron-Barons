import QtQuick
import QtQuick.Controls
import ".."

ModifierDialog {
	id: dialog
	title: research_organization ? research_organization.name : ""
	portrait_identifier: research_organization ? research_organization.portrait.identifier : ""
	modifier_string: research_organization ? research_organization.get_modifier_qstring(country) : ""
	ok_button_top_anchor: appoint_button.bottom
	ok_button_top_margin: 8 * scale_factor
	
	property var research_organization: null
	property var research_organization_slot: null
	
	TextButton {
		id: appoint_button
		anchors.top: modified_text_item.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		text: "Appoint"
		onClicked: {
			dialog.close()
			research_organization_choice_dialog.research_organization_slot = research_organization_slot
			research_organization_choice_dialog.open()
		}
	}
}
