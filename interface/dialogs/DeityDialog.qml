import QtQuick
import QtQuick.Controls
import ".."

ModifierDialog {
	id: dialog
	title: deity ? deity.get_cultural_name_qstring(metternich.game.player_country.culture) : ""
	portrait_identifier: deity ? (deity.portrait.identifier + (is_appointee ? "/grayscale" : "")) : ""
	modifier_string: deity ? deity.get_modifier_qstring(country) : ""
	ok_button_top_anchor: appoint_button.bottom
	ok_button_top_margin: 8 * scale_factor
	
	property var deity: null
	property var deity_slot: null
	readonly property bool is_appointee: deity_slot ? metternich.game.player_country.game_data.get_appointed_deity(deity_slot) === deity : false
	
	TextButton {
		id: appoint_button
		anchors.top: modifier_text_item.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		text: is_appointee ? "Unappoint" : "Appoint"
		onClicked: {
			if (is_appointee) {
				metternich.game.player_country.game_data.set_appointed_deity(deity_slot, null)
				dialog.close()
			} else {
				dialog.close()
				deity_choice_dialog.deity_slot = deity_slot
				deity_choice_dialog.open()
			}
		}
	}
}
