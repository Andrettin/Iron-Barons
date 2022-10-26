import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
	id: infopanel
	
	height: status_bar_image.height
	
	Image {
		id: status_bar_image
		anchors.bottom: parent.bottom
		anchors.left: parent.left
		source: "image://interface/" + interface_style + "/status_bar"
		fillMode: Image.PreserveAspectCrop
	}
	
	SmallText {
		id: left_status_label
		text: status_text
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 1 * scale_factor
		anchors.left: parent.left
		anchors.leftMargin: 16 * scale_factor
	}
}
