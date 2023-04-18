import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
	id: menu_button_bar
	color: interface_background_color
	width: 176 * scale_factor
	height: 50 * scale_factor
	
	Rectangle {
		color: "gray"
		anchors.top: parent.top
		anchors.topMargin: 15 * scale_factor
		anchors.bottom: parent.bottom
		anchors.right: parent.right
		width: 1 * scale_factor
	}
	
	IconButton {
		id: advisors_button
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 6 * scale_factor
		anchors.left: parent.left
		anchors.leftMargin: 6 * scale_factor
		icon_identifier: "rifle_infantry_light_small"
		visible: metternich.game.rules.advisors_enabled
		
		onReleased: {
			menu_stack.push("AdvisorsView.qml", {
				country: metternich.game.player_country
			})
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "View Advisors"
			} else {
				status_text = ""
			}
		}
	}
	
	IconButton {
		id: technology_button
		anchors.top: advisors_button.top
		anchors.left: advisors_button.right
		anchors.leftMargin: 4 * scale_factor
		icon_identifier: "cog"
		
		onReleased: {
			menu_stack.push("TechnologyView.qml")
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "View Technologies"
			} else {
				status_text = ""
			}
		}
	}
}
