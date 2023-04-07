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
		id: research_counter
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: parent.top
		anchors.topMargin: 96 * scale_factor
		name: "Research"
		icon_identifier: "research"
		count: country_game_data.get_stored_commodity("research")
		visible: current_research_portrait.visible
	}
	
	SmallText {
		id: research_cost_label
		text: "(" + number_string(country_game_data.current_research ? country_game_data.current_research.cost : 0) + ")"
		anchors.top: research_counter.bottom
		anchors.topMargin: 4 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		visible: current_research_portrait.visible
		
		MouseArea {
			anchors.fill: parent
			hoverEnabled: true
			
			onEntered: {
				status_text = "Research required to discover the technology"
			}
			
			onExited: {
				status_text = ""
			}
		}
	}
	
	SmallText {
		id: current_research_label
		text: "Current Research"
		anchors.top: research_cost_label.bottom
		anchors.topMargin: 32 * scale_factor
		anchors.left: parent.left
		anchors.leftMargin: 4 * scale_factor * 2
		anchors.right: parent.right
		anchors.rightMargin: 4 * scale_factor * 2
		visible: current_research_portrait.visible
		wrapMode: Text.WordWrap
		horizontalAlignment: Text.AlignHCenter
	}
	
	PortraitButton {
		id: current_research_portrait
		anchors.top: current_research_label.bottom
		anchors.topMargin: 8 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		portrait_identifier: country_game_data.current_research ? country_game_data.current_research.portrait.identifier : ""
		visible: country_game_data.current_research !== null
		radius: 0
		
		onHoveredChanged: {
			if (hovered && country_game_data.current_research) {
				status_text = country_game_data.current_research.name
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
