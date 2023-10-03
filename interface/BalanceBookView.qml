import QtQuick
import QtQuick.Controls

Item {
	id: balance_book_view
	
	readonly property var country: metternich.game.player_country
	readonly property var country_turn_data: country ? country.turn_data : null
	property string status_text: ""
	property string middle_status_text: ""
	
	Item {
		id: transactions_area
		anchors.top: top_bar.bottom
		anchors.bottom: status_bar.top
		anchors.left: left_bar.right
		anchors.right: infopanel.left
		
		ListView {
			id: income_transactions_list
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			anchors.left: parent.left
			anchors.right: parent.horizontalCenter
			boundsBehavior: Flickable.StopAtBounds
			clip: true
			model: country_turn_data.income_transactions
			delegate: Item {
				width: income_transactions_list.width
				height: commodity_icon.height + 4 * scale_factor * 2
				
				readonly property var income_transaction: model.modelData
				
				Image {
					id: commodity_icon
					anchors.verticalCenter: parent.verticalCenter
					anchors.left: parent.left
					anchors.leftMargin: 4 * scale_factor
					source: "image://icon/" + income_transaction.commodity.icon.identifier
					fillMode: Image.Pad
				}
				
				SmallText {
					id: commodity_label
					text: income_transaction.commodity.name + " $" + number_string(income_transaction.commodity.wealth_value !== 0 ? income_transaction.commodity.wealth_value : metternich.game.get_price(income_transaction.commodity))
					anchors.verticalCenter: parent.verticalCenter
					anchors.left: commodity_icon.right
					anchors.leftMargin: 8 * scale_factor
				}
				
				Item {
					id: description_area
					anchors.top: parent.top
					anchors.bottom: parent.bottom
					anchors.right: parent.right
					width: 192 * scale_factor
					
					SmallText {
						id: description_label
						text: income_transaction.description
						anchors.verticalCenter: parent.verticalCenter
						anchors.left: parent.left
						anchors.leftMargin: 8 * scale_factor
						anchors.right: parent.left
						anchors.rightMargin: 8 * scale_factor
						wrapMode: Text.WordWrap
					}
				}
			}
		}
	}
	
	BalanceBookInfoPanel {
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
	}
}
