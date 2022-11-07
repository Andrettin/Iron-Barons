import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
	id: settlement_view
	
	TextButton {
		id: back_button
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 64 * scale_factor
		text: qsTr("Back")
		width: 64 * scale_factor
		height: 24 * scale_factor
		
		onClicked: {
			menu_stack.pop()
		}
	}
}
