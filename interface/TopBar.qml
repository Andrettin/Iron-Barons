import QtQuick 2.12
import QtQuick.Controls 2.12

Image {
	id: top_bar
	source: "image://interface/" + interface_style + "/top_bar"
	fillMode: Image.PreserveAspectCrop
	
	SmallText {
		id: date_label
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
	
	SmallText {
		id: wealth_label
		text: "$" + number_string(metternich.game.player_country.game_data.wealth)
		anchors.top: parent.top
		anchors.topMargin: 1 * scale_factor
		anchors.left: date_label.left
		anchors.leftMargin: 128 * scale_factor
		
		MouseArea {
			anchors.fill: parent
			hoverEnabled: true
			onEntered: {
				status_text = "Wealth"
			}
			onExited: {
				status_text = ""
			}
		}
	}
}
