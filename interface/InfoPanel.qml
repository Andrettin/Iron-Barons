import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
	id: infopanel
	
	width: infopanel_image.width
	
	Image {
		id: infopanel_image
		anchors.top: parent.top
		anchors.left: parent.left
		source: "image://interface/" + interface_style + "/infopanel"
		fillMode: Image.PreserveAspectCrop
	}
	
	Button {
		id: end_turn_button
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
