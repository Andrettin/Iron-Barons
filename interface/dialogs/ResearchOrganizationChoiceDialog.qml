import QtQuick
import QtQuick.Controls
import ".."

DialogBase {
	id: dialog
	title: "Choose Research Organization"
	width: 256 * scale_factor
	height: content_height
	
	readonly property int content_height: cancel_button.y + cancel_button.height + 8 * scale_factor
	
	property var research_organization_slot: null
	property var research_organizations: research_organization_slot ? metternich.game.player_country.game_data.get_appointable_research_organizations_qvariant_list(research_organization_slot) : []
	
	SmallText {
		id: text_label
		anchors.top: title_item.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.left: parent.left
		anchors.leftMargin: 8 * scale_factor
		anchors.right: parent.right
		anchors.rightMargin: 8 * scale_factor
		text: "Which research organization shall we establish a contract with?"
		wrapMode: Text.WordWrap
	}
	
	Column {
		id: research_organization_button_column
		anchors.top: text_label.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		spacing: 8 * scale_factor
		visible: research_organizations.length > 0
		
		Repeater {
			model: research_organizations
			
			TextButton {
				id: research_organization_button
				text: format_text(research_organization.name)
				width: dialog.width - 16 * scale_factor
				tooltip: modifier_string.length > 0 ? format_text(small_text(modifier_string)) : ""
				
				readonly property var research_organization: model.modelData
				readonly property string modifier_string: research_organization.get_modifier_qstring(metternich.game.player_country)
				
				onClicked: {
					metternich.game.player_country.game_data.set_appointed_research_organization(research_organization_slot, research_organization)
					dialog.close()
				}
			}
		}
	}
	
	TextButton {
		id: cancel_button
		anchors.top: research_organization_button_column.visible ? research_organization_button_column.bottom : text_label.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		text: "Cancel"
		onClicked: {
			dialog.close()
		}
	}
}
