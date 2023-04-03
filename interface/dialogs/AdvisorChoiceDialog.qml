import QtQuick 2.12
import QtQuick.Controls 2.12
import ".."

DialogBase {
	id: advisor_choice_dialog
	title: "Choose Advisor"
	width: 256 * scale_factor
	height: 256 * scale_factor
	
	property var potential_advisors: []
	
	SmallText {
		id: text_label
		anchors.top: title_item.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.left: parent.left
		anchors.leftMargin: 8 * scale_factor
		anchors.right: parent.right
		anchors.rightMargin: 8 * scale_factor
		anchors.bottom: advisor_button_column.top
		anchors.bottomMargin: 16 * scale_factor
		text: "Which advisor shall we recruit next?"
		wrapMode: Text.WordWrap
	}
	
	Column {
		id: advisor_button_column
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 8 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		spacing: 8 * scale_factor
		
		Repeater {
			model: potential_advisors
			
			TextButton {
				id: advisor_button
				text: format_text(advisor.full_name)
				width: advisor_choice_dialog.width - 16 * scale_factor
				tooltip: format_text(small_text(advisor.advisor_modifier_string))
				
				readonly property var advisor: model.modelData
				
				onClicked: {
					metternich.game.player_country.game_data.next_advisor = advisor
					advisor_choice_dialog.close()
				}
			}
		}
	}
}
