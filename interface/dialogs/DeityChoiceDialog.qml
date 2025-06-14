import QtQuick
import QtQuick.Controls
import ".."

DialogBase {
	id: dialog
	title: "Choose Patron Deity"
	width: 256 * scale_factor
	height: content_height
	
	readonly property int content_height: cancel_button.y + cancel_button.height + 8 * scale_factor
	
	property var deity_slot: null
	property var deities: deity_slot ? metternich.game.player_country.game_data.get_appointable_deities_qvariant_list(deity_slot) : []
	
	SmallText {
		id: text_label
		anchors.top: title_item.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.left: parent.left
		anchors.leftMargin: 8 * scale_factor
		anchors.right: parent.right
		anchors.rightMargin: 8 * scale_factor
		text: "Which deity shall we worship?"
		wrapMode: Text.WordWrap
	}
	
	Column {
		id: deity_button_column
		anchors.top: text_label.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		spacing: 8 * scale_factor
		visible: deities.length > 0
		
		Repeater {
			model: deities
			
			TextButton {
				id: deity_button
				text: format_text(deity.get_cultural_name_qstring(metternich.game.player_country.culture))
				width: dialog.width - 16 * scale_factor
				tooltip: modifier_string.length > 0 ? format_text(small_text(modifier_string)) : ""
				
				readonly property var deity: model.modelData
				readonly property string modifier_string: deity.get_modifier_qstring(metternich.game.player_country)
				
				onClicked: {
					metternich.game.player_country.game_data.set_appointed_deity(deity_slot, deity)
					dialog.close()
				}
			}
		}
	}
	
	TextButton {
		id: cancel_button
		anchors.top: deity_button_column.visible ? deity_button_column.bottom : text_label.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		text: "Cancel"
		onClicked: {
			dialog.close()
		}
	}
}
