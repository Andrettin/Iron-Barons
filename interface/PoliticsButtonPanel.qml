import QtQuick
import QtQuick.Controls

Rectangle {
	id: button_panel
	color: interface_background_color
	width: 64 * scale_factor
	clip: true
	
	TiledBackground {
	}
	
	Rectangle {
		color: "gray"
		anchors.top: parent.top
		anchors.topMargin: 15 * scale_factor
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 15 * scale_factor
		anchors.left: parent.left
		width: 1 * scale_factor
	}
	
	IconButton {
		id: advisors_button
		anchors.top: parent.top
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		icon_identifier: "rifle_infantry_light_small"
		border_color: politics_view_mode === PoliticsView.Mode.Advisors ? "white" : "gray"
		
		onReleased: {
			politics_view_mode = PoliticsView.Mode.Advisors
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
		id: government_button
		anchors.top: advisors_button.bottom
		anchors.topMargin: 4 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		icon_identifier: "flag"
		border_color: politics_view_mode === PoliticsView.Mode.Government ? "white" : "gray"
		
		onReleased: {
			politics_view_mode = PoliticsView.Mode.Government
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "View Government"
			} else {
				status_text = ""
			}
		}
	}
	
	IconButton {
		id: traditions_button
		anchors.top: government_button.bottom
		anchors.topMargin: 4 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		icon_identifier: "music"
		border_color: politics_view_mode === PoliticsView.Mode.Traditions ? "white" : "gray"
		
		onReleased: {
			politics_view_mode = PoliticsView.Mode.Traditions
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "View Traditions"
			} else {
				status_text = ""
			}
		}
	}
	
	IconButton {
		id: religion_button
		anchors.top: traditions_button.bottom
		anchors.topMargin: 4 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		icon_identifier: "wooden_cross"
		border_color: politics_view_mode === PoliticsView.Mode.Religion ? "white" : "gray"
		
		onReleased: {
			politics_view_mode = PoliticsView.Mode.Religion
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "View Religion"
			} else {
				status_text = ""
			}
		}
	}
	
	IconButton {
		id: research_organizations_button
		anchors.top: religion_button.bottom
		anchors.topMargin: 4 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		icon_identifier: "cog"
		border_color: politics_view_mode === PoliticsView.Mode.ResearchOrganizations ? "white" : "gray"
		
		onReleased: {
			politics_view_mode = PoliticsView.Mode.ResearchOrganizations
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "View Research Organizations"
			} else {
				status_text = ""
			}
		}
	}
}
