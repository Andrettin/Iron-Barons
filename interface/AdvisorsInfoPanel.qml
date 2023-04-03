import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
	id: infopanel
	color: interface_background_color
	width: 64 * scale_factor + 8 * scale_factor * 2
	
	Rectangle {
		color: "gray"
		anchors.top: parent.top
		anchors.topMargin: 15 * scale_factor
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 15 * scale_factor
		anchors.right: parent.right
		width: 1 * scale_factor
	}
	
	IndustryCounter {
		id: civics_counter
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: parent.top
		anchors.topMargin: 96 * scale_factor
		name: "Civics"
		icon_identifier: "flag"
		count: country_game_data.get_stored_commodity("civics")
	}
	
	SmallText {
		id: advisor_cost_label
		text: "(" + number_string(country_game_data.advisor_cost) + ")"
		anchors.top: civics_counter.bottom
		anchors.topMargin: 4 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
	}
	
	SmallText {
		id: next_advisor_label
		text: "Next Advisor"
		anchors.top: advisor_cost_label.bottom
		anchors.topMargin: 32 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		visible: next_advisor_portrait.visible
	}
	
	PortraitButton {
		id: next_advisor_portrait
		anchors.top: next_advisor_label.bottom
		anchors.topMargin: 8 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		portrait_identifier: country_game_data.next_advisor ? country_game_data.next_advisor.game_data.portrait.identifier : ""
		visible: country_game_data.next_advisor !== null
		
		onHoveredChanged: {
			if (hovered && country_game_data.next_advisor) {
				status_text = country_game_data.next_advisor.full_name
			} else {
				status_text = ""
			}
		}
	}
	
	TextButton {
		id: back_button
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 16 * scale_factor
		text: qsTr("Back")
		width: 48 * scale_factor
		height: 24 * scale_factor
		
		onClicked: {
			menu_stack.pop()
		}
	}
}
