import QtQuick
import QtQuick.Controls
import ".."

DialogBase {
	id: tradition_choice_dialog
	title: "Choose Tradition"
	width: 256 * scale_factor
	height: content_height
	
	readonly property int content_height: tradition_button_column.y + tradition_button_column.height + 8 * scale_factor
	
	property var potential_traditions: []
	
	SmallText {
		id: text_label
		anchors.top: title_item.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.left: parent.left
		anchors.leftMargin: 8 * scale_factor
		anchors.right: parent.right
		anchors.rightMargin: 8 * scale_factor
		text: "Which tradition shall we acquire next?"
		wrapMode: Text.WordWrap
	}
	
	Column {
		id: tradition_button_column
		anchors.top: text_label.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		spacing: 8 * scale_factor
		
		Repeater {
			model: potential_traditions
			
			TextButton {
				id: tradition_button
				text: format_text(tradition.name)
				width: tradition_choice_dialog.width - 16 * scale_factor
				tooltip: format_text(small_text(tradition.get_modifier_string(metternich.game.player_country)))
				
				readonly property var tradition: model.modelData
				
				onClicked: {
					metternich.game.player_country.game_data.next_tradition = tradition
					tradition_choice_dialog.close()
				}
			}
		}
	}
}
