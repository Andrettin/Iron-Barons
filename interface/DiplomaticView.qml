import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
	id: diplomatic_map_view
	
	property int start_tile_x: 0
	property int start_tile_y: 0
	readonly property var selected_country: diplomatic_map.selected_country
	
	Rectangle {
		id: diplomatic_map_background
		anchors.top: top_bar.bottom
		anchors.bottom: bottom_panel.top
		anchors.left: left_bar.right
		anchors.right: right_bar.left
		color: Qt.rgba(0.0 / 255.0, 0.0 / 255.0, 0.0 / 255.0, 1)
	}
	
	DiplomaticMap {
		id: diplomatic_map
		anchors.top: diplomatic_map_background.top
		anchors.bottom: diplomatic_map_background.bottom
		anchors.left: diplomatic_map_background.left
		anchors.right: diplomatic_map_background.right
		ocean_suffix: "0"
	}
	
	LeftBar {
		id: left_bar
		anchors.top: parent.top
		anchors.bottom: bottom_panel.top
		anchors.bottomMargin: -16 * scale_factor
		anchors.left: parent.left
	}
	
	RightBar {
		id: right_bar
		anchors.top: parent.top
		anchors.bottom: bottom_panel.top
		anchors.bottomMargin: -16 * scale_factor
		anchors.right: parent.right
	}
	
	DiplomacyBottomPanel {
		id: bottom_panel
		anchors.bottom: parent.bottom
		anchors.left: parent.left
		anchors.right: parent.right
	}
	
	TopBar {
		id: top_bar
		anchors.top: parent.top
		anchors.left: left_bar.right
		anchors.right: right_bar.left
	}
	
	Component.onCompleted: {
		diplomatic_map.center_on_tile_pos(start_tile_x, start_tile_y)
	}
}