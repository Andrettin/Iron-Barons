import QtQuick 2.12
import QtQuick.Controls 2.12
import "./dialogs"

Item {
	id: advisors_view
	
	property var country: null
	readonly property var country_game_data: country ? country.game_data : null
	property string status_text: ""
	
	Rectangle {
		id: portrait_grid_view_background
		anchors.fill: portrait_grid_view
		color: "black"
	}
	
	GridView {
		id: portrait_grid_view
		anchors.top: top_bar.bottom
		anchors.bottom: status_bar.top
		anchors.left: infopanel.right
		anchors.right: right_bar.left
		leftMargin: 0
		rightMargin: 0
		topMargin: 0
		bottomMargin: 0
		cellWidth: 80 * scale_factor
		cellHeight: 80 * scale_factor
		boundsBehavior: Flickable.StopAtBounds
		clip: true
		model: country_game_data.advisors
		
		delegate: PortraitGridItem {
			icon_identifier: advisor.game_data.portrait.identifier
			
			readonly property var advisor: model.modelData
			
			onClicked: {
				advisor_dialog.title = advisor.full_name
				advisor_dialog.modifier_string = advisor.advisor_modifier_string
				advisor_dialog.description = advisor.description
				advisor_dialog.open()
			}
			
			onEntered: {
				status_text = advisor.full_name
			}
			
			onExited: {
				status_text = ""
			}
		}
	}
	
	RightBar {
		id: right_bar
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		anchors.right: parent.right
	}
	
	AdvisorsInfoPanel {
		id: infopanel
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		anchors.left: parent.left
	}
	
	StatusBar {
		id: status_bar
		anchors.bottom: parent.bottom
		anchors.left: infopanel.right
		anchors.right: right_bar.left
	}
	
	TopBar {
		id: top_bar
		anchors.top: parent.top
		anchors.left: infopanel.right
		anchors.right: right_bar.left
	}
	
	ModifierDialog {
		id: advisor_dialog
	}
}
