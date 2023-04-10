import QtQuick 2.12
import QtQuick.Controls 2.12
import "./dialogs"

Item {
	id: advisors_view
	
	property var country: null
	readonly property var country_game_data: country ? country.game_data : null
	property var new_advisor: null
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
			portrait_identifier: advisor.game_data.portrait.identifier
			
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
			
			Grid {
				id: new_advisor_cover
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.verticalCenter: parent.verticalCenter
				width: 64 * scale_factor
				height: 64 * scale_factor
				columns: 64 * scale_factor
				rows: 64 * scale_factor
				visible: advisor === new_advisor
				
				property var cover_pixels: []
				
				Repeater {
					model: (advisor === new_advisor) ? (new_advisor_cover.width * new_advisor_cover.height) : 0
					
					Rectangle {
						color: "black"
						width: 1
						height: 1
						
						Component.onCompleted: {
							new_advisor_cover.cover_pixels.push(this)
						}
					}
				}
				
				Timer {
					id: new_advisor_timer
					running: new_advisor_cover.visible
					repeat: true
					interval: 1
					onTriggered: {
						var pixel_change_count = Math.floor(2 * scale_factor * scale_factor)
						for (var i = 0; i < pixel_change_count; i++) {
							if (new_advisor_cover.cover_pixels.length === 0) {
								running = false
								repeat = false
								return
							}
							
							var pixel_index = random(new_advisor_cover.cover_pixels.length)
							var pixel_item = new_advisor_cover.cover_pixels[pixel_index]
							pixel_item.color = "transparent"
							new_advisor_cover.cover_pixels.splice(pixel_index, 1)
						}
					}
				}
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
