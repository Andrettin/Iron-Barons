import QtQuick
import QtQuick.Controls
import "./dialogs"

Item {
	id: traditions_view
	
	PortraitButtonTree {
		id: traditions_tree
		anchors.fill: parent
		entries: country_game_data.available_traditions
		delegate: TreePortraitButton {
			border_color: country_game_data.next_tradition === tradition ? "white" : "gray"
			transparent: !country_game_data.has_tradition(tradition)
			
			readonly property var tradition: model.modelData
			
			onClicked: {
				tradition_dialog.tradition = tradition
				tradition_dialog.open()
			}
		}
	}
	
	TraditionDialog {
		id: tradition_dialog
	}
}
