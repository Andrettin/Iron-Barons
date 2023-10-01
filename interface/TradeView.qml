import QtQuick
import QtQuick.Controls
import "./dialogs"

Item {
	id: trade_view
	
	readonly property var country: metternich.game.player_country
	readonly property var country_game_data: country ? country.game_data : null
	property string status_text: ""
	property string middle_status_text: ""
	
	ListView {
		id: commodity_list
		anchors.top: top_bar.bottom
		anchors.bottom: status_bar.top
		anchors.left: left_bar.right
		anchors.right: infopanel.left
		boundsBehavior: Flickable.StopAtBounds
		clip: true
		model: country_game_data.tradeable_commodities
		delegate: Item {
			width: commodity_list.width
			height: commodity_icon.height + 4 * scale_factor * 2
			
			readonly property var commodity: model.modelData
			
			Image {
				id: commodity_icon
				anchors.verticalCenter: parent.verticalCenter
				anchors.left: parent.left
				anchors.leftMargin: 4 * scale_factor
				source: "image://icon/" + commodity.icon.identifier
				fillMode: Image.Pad
			}
			
			SmallText {
				id: commodity_label
				text: commodity.name
				anchors.verticalCenter: parent.verticalCenter
				anchors.left: commodity_icon.right
				anchors.leftMargin: 8 * scale_factor
			}
			
			Rectangle {
				id: commodity_border
				color: "gray"
				anchors.bottom: parent.bottom
				anchors.left: parent.left
				anchors.right: parent.right
				height: 1 * scale_factor
				visible: index !== (commodity_list.model.length - 1)
			}
			
			TextButton {
				id: bid_button
				anchors.verticalCenter: parent.verticalCenter
				anchors.right: offer_button.left
				anchors.rightMargin: 16 * scale_factor
				text: qsTr("Bid")
				width: 48 * scale_factor
				height: 24 * scale_factor
				highlighted: country_game_data.bids.length > 0 && country_game_data.get_bid(commodity) > 0
				
				onClicked: {
					if (country_game_data.get_bid(commodity) === 0) {
						country_game_data.set_bid(commodity, 10)
					} else {
						country_game_data.set_bid(commodity, 0)
					}
				}
			}
			
			TextButton {
				id: offer_button
				anchors.verticalCenter: parent.verticalCenter
				anchors.right: price_area.left
				anchors.rightMargin: 16 * scale_factor
				text: qsTr("Offer")
				width: 48 * scale_factor
				height: 24 * scale_factor
				highlighted: country_game_data.offers.length > 0 && country_game_data.get_offer(commodity) > 0
				
				onClicked: {
					if (country_game_data.get_offer(commodity) === 0) {
						country_game_data.set_offer(commodity, 10)
					} else {
						country_game_data.set_offer(commodity, 0)
					}
				}
			}
			
			Item {
				id: price_area
				anchors.top: parent.top
				anchors.bottom: parent.bottom
				anchors.right: available_area.left
				width: 96 * scale_factor
				
				Rectangle {
					id: price_border
					color: "gray"
					anchors.top: parent.top
					anchors.bottom: parent.bottom
					anchors.left: parent.left
					width: 1 * scale_factor
				}
				
				SmallText {
					id: price_label
					text: "$" + number_string(commodity.base_price)
					anchors.verticalCenter: parent.verticalCenter
					anchors.right: parent.right
					anchors.rightMargin: 32 * scale_factor
				}
			}
			
			Item {
				id: available_area
				anchors.top: parent.top
				anchors.bottom: parent.bottom
				anchors.right: quantity_to_trade_area.left
				width: 96 * scale_factor
				
				Rectangle {
					id: available_border
					color: "gray"
					anchors.top: parent.top
					anchors.bottom: parent.bottom
					anchors.left: parent.left
					width: 1 * scale_factor
				}
				
				SmallText {
					id: available_label
					text: number_string(country_game_data.get_stored_commodity(commodity))
					anchors.verticalCenter: parent.verticalCenter
					anchors.right: parent.right
					anchors.rightMargin: 32 * scale_factor
				}
			}
			
			Item {
				id: quantity_to_trade_area
				anchors.top: parent.top
				anchors.bottom: parent.bottom
				anchors.right: parent.right
				width: 256 * scale_factor
				
				Rectangle {
					id: quantity_to_trade_border
					color: "gray"
					anchors.top: parent.top
					anchors.bottom: parent.bottom
					anchors.left: parent.left
					width: 1 * scale_factor
				}
				
				SmallText {
					id: quantity_to_trade_label
					text: ""
					anchors.horizontalCenter: parent.horizontalCenter
					anchors.verticalCenter: parent.verticalCenter
				}
			}
		}
	}
	
	TradeInfoPanel {
		id: infopanel
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		anchors.right: parent.right
	}
	
	LeftBar {
		id: left_bar
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		anchors.left: parent.left
	}
	
	StatusBar {
		id: status_bar
		anchors.bottom: parent.bottom
		anchors.left: left_bar.right
		anchors.right: infopanel.left
	}
	
	TopBar {
		id: top_bar
		anchors.top: parent.top
		anchors.left: left_bar.right
		anchors.right: infopanel.left
		
		Item {
			id: price_top_area
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			anchors.right: available_top_area.left
			width: 96 * scale_factor
			
			SmallText {
				id: price_top_label
				text: "Price:"
				anchors.top: parent.top
				anchors.topMargin: 1 * scale_factor
				anchors.horizontalCenter: parent.horizontalCenter
			}
		}
		
		Item {
			id: available_top_area
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			anchors.right: quantity_to_trade_top_area.left
			width: 96 * scale_factor
			
			SmallText {
				id: available_top_label
				text: "Available:"
				anchors.top: parent.top
				anchors.topMargin: 1 * scale_factor
				anchors.horizontalCenter: parent.horizontalCenter
			}
		}
		
		Item {
			id: quantity_to_trade_top_area
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			anchors.right: parent.right
			width: 256 * scale_factor
			
			SmallText {
				id: quantity_to_trade_top_label
				text: "Quantity to Trade:"
				anchors.top: parent.top
				anchors.topMargin: 1 * scale_factor
				anchors.horizontalCenter: parent.horizontalCenter
			}
		}
	}
}
