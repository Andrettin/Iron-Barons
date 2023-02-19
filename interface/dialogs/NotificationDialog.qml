import QtQuick 2.12
import QtQuick.Controls 2.12
import ".."

DialogBase {
	id: notification_dialog
	panel: 5
	height: Math.max(content_height, default_height)
	
	readonly property int content_height: text_label.y + text_label.contentHeight + 16 * scale_factor + ok_button.height + 8 * scale_factor
	
	property var portrait_object: null
	readonly property string portrait_identifier: portrait_object !== null ? (portrait_object.class_name === "metternich::character" ? portrait_object.game_data.portrait.identifier : portrait_object.identifier) : ""
	property string text: ""
	
	PortraitButton {
		id: portrait
		anchors.top: title_item.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		portrait_identifier: notification_dialog.portrait_identifier
		visible: portrait_identifier.length > 0
		circle: is_character
		tooltip: is_character ? portrait_object.full_name : ""
		
		readonly property bool is_character: portrait_object !== null && portrait_object.class_name === "metternich::character"
	}
	
	SmallText {
		id: text_label
		anchors.top: portrait.visible ? portrait.bottom : title_item.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.left: parent.left
		anchors.leftMargin: 8 * scale_factor
		anchors.right: parent.right
		anchors.rightMargin: 8 * scale_factor
		anchors.bottom: ok_button.top
		anchors.bottomMargin: 16 * scale_factor
		text: notification_dialog.text
		wrapMode: Text.WordWrap
	}
	
	TextButton {
		id: ok_button
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 8 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		text: "OK"
		onClicked: {
			notification_dialog.close()
			notification_dialog.destroy()
		}
	}
}
