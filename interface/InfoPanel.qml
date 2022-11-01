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
	
	NormalText {
		id: title
		anchors.top: parent.top
		anchors.topMargin: 8 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		text: selected_settlement ? (selected_settlement.game_data.current_cultural_name) : (selected_civilian_unit ? selected_civilian_unit.type.name : "")
	}
	
	Image {
		id: icon
		anchors.top: title.bottom
		anchors.topMargin: 8 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		source: selected_civilian_unit ? ("image://icon/" + selected_civilian_unit.icon.identifier) : "image://empty/"
	}
	
	Button {
		id: end_turn_button_internal
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 8 * scale_factor
		text: qsTr("End Turn")
		width: 64 * scale_factor
		height: 24 * scale_factor
		
		onReleased: {
			metternich.game.do_turn_async()
		}
	}
}
