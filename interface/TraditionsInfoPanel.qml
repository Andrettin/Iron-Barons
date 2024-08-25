import QtQuick
import QtQuick.Controls

Rectangle {
	id: infopanel
	color: interface_background_color
	width: 64 * scale_factor + 8 * scale_factor * 2
	
	readonly property var tradition_commodity: metternich.defines.tradition_commodity
	
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
		id: tradition_commodity_counter
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: parent.top
		anchors.topMargin: 16 * scale_factor
		name: tradition_commodity.name
		icon_identifier: tradition_commodity.icon.identifier
		count: country_game_data.stored_commodities.length > 0 ? country_game_data.get_stored_commodity(tradition_commodity) : 0
	}
	
	SmallText {
		id: tradition_cost_label
		text: "(" + number_string(country_game_data.tradition_cost) + ")"
		anchors.top: tradition_commodity_counter.bottom
		anchors.topMargin: 4 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		visible: next_tradition_portrait.visible
		
		MouseArea {
			anchors.fill: parent
			hoverEnabled: true
			
			onEntered: {
				status_text = tradition_commodity.name + " required for the next tradition"
			}
			
			onExited: {
				status_text = ""
			}
		}
	}
	
	SmallText {
		id: next_tradition_label
		text: "Next Tradition"
		anchors.top: tradition_cost_label.bottom
		anchors.topMargin: 32 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		visible: next_tradition_portrait.visible
	}
	
	PortraitButton {
		id: next_tradition_portrait
		anchors.top: next_tradition_label.bottom
		anchors.topMargin: 8 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		portrait_identifier: country_game_data.next_tradition ? country_game_data.next_tradition.portrait.identifier : ""
		visible: country_game_data.next_tradition !== null
		radius: 0
		
		onHoveredChanged: {
			if (hovered && country_game_data.next_tradition) {
				status_text = country_game_data.next_tradition.name
			} else {
				status_text = ""
			}
		}
	}
	
	IndustryCounter {
		id: piety_commodity_counter
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: next_tradition_portrait.visible ? next_tradition_portrait.bottom : tradition_commodity_counter.bottom
		anchors.topMargin: next_tradition_portrait.visible ? 32 * scale_factor : 166 * scale_factor
		name: "Piety"
		icon_identifier: "wooden_cross"
		count: country_game_data.stored_commodities.length > 0 ? country_game_data.get_stored_commodity(metternich.defines.piety_commodity) : 0
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
