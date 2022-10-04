import QtQuick 2.12
import QtQuick.Controls 2.12
import ".."

Item {
	id: menu
	focus: true

	property string title: ""
	property string music_type: "menu"
	
	LargeText {
		id: title_text
		text: highlight(menu.title)
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: parent.top
		anchors.topMargin: 36 * scale_factor
	}
	}
}
