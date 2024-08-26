import QtQuick
import QtQuick.Controls
import ".."

DialogBase {
	id: belief_choice_dialog
	title: "Choose Belief"
	width: 256 * scale_factor
	height: content_height
	
	readonly property int content_height: belief_button_column.y + belief_button_column.height + 8 * scale_factor
	
	property var potential_beliefs: []
	
	SmallText {
		id: text_label
		anchors.top: title_item.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.left: parent.left
		anchors.leftMargin: 8 * scale_factor
		anchors.right: parent.right
		anchors.rightMargin: 8 * scale_factor
		text: "Which belief shall we adopt next?"
		wrapMode: Text.WordWrap
	}
	
	Column {
		id: belief_button_column
		anchors.top: text_label.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		spacing: 8 * scale_factor
		
		Repeater {
			model: potential_beliefs
			
			TextButton {
				id: belief_button
				text: format_text(belief.name)
				width: belief_choice_dialog.width - 16 * scale_factor
				tooltip: format_text(small_text(belief.get_modifier_string(metternich.game.player_country)))
				
				readonly property var belief: model.modelData
				
				onClicked: {
					metternich.game.player_country.game_data.next_belief = belief
					belief_choice_dialog.close()
				}
			}
		}
	}
}
