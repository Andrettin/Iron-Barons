import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
	id: top_bar
	color: interface_background_color
	height: 16 * scale_factor
	
	Rectangle {
		color: "gray"
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.bottom: parent.bottom
		height: 1 * scale_factor
		z: 1 //draw on top of everything else
	}
	
	readonly property var stored_commodities: metternich.game.player_country.game_data.stored_commodities
	
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
