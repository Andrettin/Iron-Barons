import QtQuick
import QtQuick.Controls
import ".."

ModifierDialog {
	id: dialog
	title: research_organization ? research_organization.name : ""
	portrait_identifier: research_organization ? (research_organization.portrait.identifier + (is_appointee ? "/grayscale" : "")) : ""
	modifier_string: research_organization ? research_organization.get_modifier_qstring(country) : ""
	ok_button_top_anchor: appoint_button.bottom
	ok_button_top_margin: 8 * scale_factor
	
	property var research_organization: null
	property var research_organization_slot: null
	readonly property bool is_appointee: research_organization_slot ? metternich.game.player_country.game_data.get_appointed_research_organization(research_organization_slot) === research_organization : false
	
	TextButton {
		id: appoint_button
		anchors.top: modified_text_item.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		text: is_appointee ? "Unappoint" : "Appoint"
		onClicked: {
			if (is_appointee) {
				metternich.game.player_country.game_data.set_appointed_research_organization(research_organization_slot, null)
				dialog.close()
			} else {
				dialog.close()
				research_organization_choice_dialog.research_organization_slot = research_organization_slot
				research_organization_choice_dialog.open()
			}
		}
	}
}
