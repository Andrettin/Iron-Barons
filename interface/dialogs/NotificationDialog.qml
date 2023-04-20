import QtQuick 2.12
import QtQuick.Controls 2.12
import ".."

DialogBase {
	id: notification_dialog
	panel: 5
	height: column.y + column.height + 8 * scale_factor
	
	property var portrait_object: null
	readonly property string portrait_identifier: portrait_object !== null ? (portrait_object.class_name === "metternich::character" ? portrait_object.game_data.portrait.identifier : portrait_object.identifier) : ""
	property string text: ""
	property var on_closed: null
	
	Column {
		id: column
		anchors.top: title_item.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.left: parent.left
		anchors.leftMargin: 8 * scale_factor
		anchors.right: parent.right
		anchors.rightMargin: 8 * scale_factor
		spacing: 16 * scale_factor
		
		PortraitButton {
			id: portrait
			anchors.horizontalCenter: parent.horizontalCenter
			portrait_identifier: notification_dialog.portrait_identifier
			visible: portrait_identifier.length > 0
			circle: is_character
			tooltip: is_character ? portrait_object.full_name : ""
			
			readonly property bool is_character: portrait_object !== null && portrait_object.class_name === "metternich::character"
		}
		
		SmallText {
			id: text_label
			anchors.horizontalCenter: parent.horizontalCenter
			text: format_text(notification_dialog.text)
			wrapMode: Text.WordWrap
			width: Math.min(contentWidth, parent.width)
			visible: notification_dialog.text.length > 0
		}
		
		TextButton {
			id: ok_button
			anchors.horizontalCenter: parent.horizontalCenter
			text: "OK"
			onClicked: {
				notification_dialog.close()
				notification_dialog.destroy()
				
				if (on_closed) {
					on_closed()
				}
			}
		}
	}
}
