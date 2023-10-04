import QtQuick
import QtQuick.Controls

Rectangle {
	id: button_panel
	color: interface_background_color
	width: 64 * scale_factor
	
	Rectangle {
		color: "gray"
		anchors.top: parent.top
		anchors.topMargin: 15 * scale_factor
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 15 * scale_factor
		anchors.left: parent.left
		width: 1 * scale_factor
	}
	
	IconButton {
		id: trade_orders_button
		anchors.top: parent.top
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		icon_identifier: "wealth"
		border_color: trade_view.mode === TradeView.Mode.TradeOrders ? "white" : "gray"
		
		onReleased: {
			trade_view.mode = TradeView.Mode.TradeOrders
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "View Trade Orders"
			} else {
				status_text = ""
			}
		}
	}
	
	IconButton {
		id: government_button
		anchors.top: trade_orders_button.bottom
		anchors.topMargin: 4 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		icon_identifier: "chest"
		border_color: trade_view.mode === TradeView.Mode.BalanceBook ? "white" : "gray"
		
		onReleased: {
			trade_view.mode = TradeView.Mode.BalanceBook
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "View Balance Book"
			} else {
				status_text = ""
			}
		}
	}
}
