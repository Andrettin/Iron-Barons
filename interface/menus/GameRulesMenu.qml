import QtQuick
import QtQuick.Controls
import ".."

MenuBase {
	id: game_rules_menu
	title: qsTr("Game Rules")
	
	property var selected_scenario: null
	property bool rules_changed: false
	
	Grid {
		anchors.left: parent.left
		anchors.leftMargin: 16 * scale_factor
		anchors.right: parent.right
		anchors.rightMargin: 16 * scale_factor
		anchors.top: title_item.bottom
		anchors.topMargin: 32 * scale_factor
		anchors.bottom: previous_menu_button.top
		anchors.bottomMargin: 32 * scale_factor
		spacing: 16 * scale_factor
		
		Repeater {
			model: metternich.preferences.game_rules.rules
			
			CustomCheckBox {
				id: game_rule_checkbox
				text: qsTr(game_rule.name)
				checked: metternich.preferences.game_rules.get_value(game_rule)
				checkable: true
				tooltip: small_text(metternich.preferences.game_rules.description)
				visible: !game_rule.hidden
				onCheckedChanged: {
					if (metternich.preferences.game_rules.get_value(game_rule) !== checked) {
						metternich.preferences.game_rules.set_value(game_rule, checked)
						rules_changed = true
					}
				}
				
				readonly property var game_rule: model.modelData
			}
		}
	}
	
	TextButton {
		id: previous_menu_button
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 16 * scale_factor
		text: qsTr("Previous Menu")
		width: 96 * scale_factor
		height: 24 * scale_factor
		
		onClicked: {
			if (rules_changed) {
				metternich.preferences.save()
				metternich.game.setup_scenario(selected_scenario).then(() => {
					menu_stack.pop()
				})
			} else {
				menu_stack.pop()
			}
		}
	}
}
