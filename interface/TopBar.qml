import QtQuick 2.12
import QtQuick.Controls 2.12

Image {
	id: top_bar
	source: "image://interface/" + interface_style + "/top_bar"
	fillMode: Image.PreserveAspectCrop
	
	SmallText {
		text: date_string(metternich.game.date)
		anchors.top: parent.top
		anchors.topMargin: 1 * scale_factor
		anchors.left: parent.left
		anchors.leftMargin: 16 * scale_factor
		
		MouseArea {
			anchors.fill: parent
			hoverEnabled: true
			onEntered: {
				status_text = "Current Season and Year"
			}
			onExited: {
				status_text = ""
			}
		}
	}
}
