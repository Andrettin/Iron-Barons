import QtQuick 2.12
import QtQuick.Controls 2.12

Image {
	id: top_bar
	source: "image://interface/" + interface_style + "/top_bar"
	fillMode: Image.PreserveAspectCrop
	
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
	
	Image {
		id: research_icon
		source: "image://icon/research/small"
		anchors.top: parent.top
		anchors.left: wealth_label.left
		anchors.leftMargin: 96 * scale_factor
	}
	
	SmallText {
		id: research_label
		text: number_string(get_stored_commodity("research", stored_commodities))
		anchors.top: parent.top
		anchors.topMargin: 1 * scale_factor
		anchors.left: research_icon.right
		anchors.leftMargin: 2 * scale_factor
	}
	
	MouseArea {
		anchors.top: research_icon.top
		anchors.bottom: research_icon.bottom
		anchors.left: research_icon.left
		anchors.right: research_label.right
		hoverEnabled: true
		onEntered: {
			status_text = "Research"
		}
		onExited: {
			status_text = ""
		}
	}
	
	function get_stored_commodity(commodity_identifier, stored_commodities) {
		for (var kv_pair of stored_commodities) {
			var commodity = kv_pair.key
			if (commodity.identifier === commodity_identifier) {
				return kv_pair.value
			}
		}
		
		return 0
	}
}
