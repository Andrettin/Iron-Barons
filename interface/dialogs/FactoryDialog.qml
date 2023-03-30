import QtQuick 2.12
import QtQuick.Controls 2.12
import ".."

DialogBase {
	id: factory_dialog
	title: building ? building.name : ""
	panel: 5
	width: 256 * scale_factor + 8 * scale_factor * 2
	height: ok_button.y + ok_button.height + 8 * scale_factor
	
	property var building_slot: null
	readonly property var building: building_slot ? building_slot.building : null
	
	SmallText {
		id: capacity_label
		anchors.top: title_item.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		text: "Capacity: " + (building ? building.base_capacity : "")
	}
	
	TextButton {
		id: ok_button
		anchors.top: capacity_label.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		text: "OK"
		onClicked: {
			factory_dialog.close()
		}
	}
}
