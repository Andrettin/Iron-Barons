import QtQuick
import QtQuick.Controls

Rectangle {
	id: menu_button_bar
	color: interface_background_color
	width: 176 * scale_factor
	height: 50 * scale_factor
	clip: true
	
	PanelTiledBackground {
	}
	
	Rectangle {
		color: "gray"
		anchors.top: parent.top
		anchors.topMargin: 15 * scale_factor
		anchors.bottom: parent.bottom
		anchors.right: parent.right
		width: 1 * scale_factor
	}
	
	IconButton {
		id: politics_button
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 6 * scale_factor
		anchors.left: parent.left
		anchors.leftMargin: 6 * scale_factor
		icon_identifier: "flag"
		
		onReleased: {
			menu_stack.push("PoliticsView.qml", {
				country: metternich.game.player_country
			})
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "View Politics"
			} else {
				status_text = ""
			}
		}
	}
	
	IconButton {
		id: technology_button
		anchors.top: politics_button.top
		anchors.left: politics_button.right
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
	
	IconButton {
		id: journal_button
		anchors.top: politics_button.top
		anchors.left: technology_button.right
		anchors.leftMargin: 4 * scale_factor
		icon_identifier: "newspaper"
		
		onReleased: {
			menu_stack.push("JournalView.qml")
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "View Journal"
			} else {
				status_text = ""
			}
		}
	}
}
