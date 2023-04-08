import QtQuick 2.12
import QtQuick.Controls 2.12
import ".."

DialogBase {
	id: building_dialog
	title: building ? building.name : ""
	
	property var building_slot: null
	readonly property var building: building_slot ? building_slot.building : null
}
