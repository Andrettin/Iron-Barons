import QtQuick
import QtQuick.Controls
import ".."

DialogBase {
	id: character_dialog
	title: character ? character.full_name : ""
	width: Math.max(256 * scale_factor, modifier_text.contentWidth + 16 * scale_factor)
	height: ok_button.y + ok_button.height + 8 * scale_factor
	
	property var character: null
	property string modifier_string: ""
	
	SmallText {
		id: modifier_text
		anchors.top: title_item.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		text: format_text(modifier_string)
	}
	
	SmallText {
		id: lived_text
		anchors.top: modifier_text.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		text: character ? ("Lived: " + date_year_range_string(character.birth_date, character.death_date)) : ""
	}
	
	SmallText {
		id: description_text
		anchors.top: lived_text.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.left: parent.left
		anchors.leftMargin: 8 * scale_factor
		anchors.right: parent.right
		anchors.rightMargin: 8 * scale_factor
		text: character ? format_text(character.description) : ""
		visible: text.length > 0
		wrapMode: Text.WordWrap
	}
	
	TextButton {
		id: ok_button
		anchors.top: description_text.visible ? description_text.bottom : lived_text.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		text: "OK"
		onClicked: {
			character_dialog.close()
		}
	}
}
