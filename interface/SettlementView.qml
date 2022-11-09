import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
	id: settlement_view
	
	property var settlement: null
	readonly property var settlement_game_data: settlement.game_data
	readonly property var province: settlement_game_data.province
	readonly property var province_game_data: province.game_data
	property string interface_style: "dwarven"
	property string status_text: ""
	
	Image {
		id: right_bar
		anchors.top: parent.top
		anchors.right: parent.right
		source: "image://interface/" + interface_style + "/right_bar"
		fillMode: Image.PreserveAspectCrop
	}
	
	StatusBar {
		id: status_bar
		anchors.bottom: parent.bottom
		anchors.left: infopanel.right
		anchors.right: parent.right
	}
	
	TopBar {
		id: top_bar
		anchors.top: parent.top
		anchors.left: infopanel.right
	}
	
	SettlementInfoPanel {
		id: infopanel
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		anchors.left: parent.left
	}
}
