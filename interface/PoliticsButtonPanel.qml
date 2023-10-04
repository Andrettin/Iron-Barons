import QtQuick
import QtQuick.Controls

Rectangle {
	id: button_panel
	color: interface_background_color
	width: 64 * scale_factor
	
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
}
