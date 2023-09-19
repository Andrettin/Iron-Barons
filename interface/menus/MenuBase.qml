import QtQuick
import QtQuick.Controls
import ".."

Item {
	id: menu
	focus: true

	property string title: ""
	//property string background: wyrmgus.defines.default_menu_background_file
	property string music_type: "menu"
	readonly property var title_item: title_text
	
	LargeText {
		id: title_text
		text: highlight(menu.title)
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: parent.top
		anchors.topMargin: 36 * scale_factor
	}
}
