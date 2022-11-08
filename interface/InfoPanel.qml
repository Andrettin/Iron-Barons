import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
	id: infopanel
	
	width: infopanel_image.width
	
	readonly property var end_turn_button: end_turn_button_internal
	
	Image {
		id: infopanel_image
		anchors.top: parent.top
		anchors.left: parent.left
		source: "image://interface/" + interface_style + "/infopanel"
		fillMode: Image.PreserveAspectCrop
	}
	
	IconButton {
		id: capital_settlement_button
		anchors.top: parent.top
		anchors.topMargin: 8 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		icon_identifier: "settlement"
		
		onReleased: {
			menu_stack.push("SettlementView.qml")
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "View Capital Settlement"
			}
		}
	}
	
	IconButton {
		id: diplomatic_map_button
		anchors.top: capital_settlement_button.top
		anchors.left: capital_settlement_button.right
		anchors.leftMargin: 8 * scale_factor
		icon_identifier: "globe"
		
		onReleased: {
			menu_stack.push("DiplomaticMapView.qml", {
				start_tile_x: map_area_start_x + map_area_tile_width / 2,
				start_tile_y: map_area_start_y + map_area_tile_height / 2
			})
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "View Diplomatic Map"
			}
		}
	}
	
	NormalText {
		id: title
		anchors.top: capital_settlement_button.bottom
		anchors.topMargin: 8 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		text: selected_site ? (selected_site.game_data.current_cultural_name) : (selected_civilian_unit ? selected_civilian_unit.type.name : "")
	}
	
	Image {
		id: icon
		anchors.top: title.bottom
		anchors.topMargin: 8 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		source: selected_civilian_unit ? ("image://icon/" + selected_civilian_unit.icon.identifier) : "image://empty/"
	}
	
	TextButton {
		id: settlement_button
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: end_turn_button_internal.top
		anchors.bottomMargin: 8 * scale_factor
		text: qsTr("Settlement")
		width: 64 * scale_factor
		height: 24 * scale_factor
		visible: selected_site !== null && selected_site.settlement
		
		onClicked: {
			menu_stack.push("SettlementView.qml")
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "View Settlement"
			}
		}
	}
	
	TextButton {
		id: end_turn_button_internal
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 8 * scale_factor
		text: qsTr("End Turn")
		width: 64 * scale_factor
		height: 24 * scale_factor
		
		onClicked: {
			metternich.game.do_turn_async()
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "End Turn"
			}
		}
	}
}
