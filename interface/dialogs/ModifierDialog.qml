import QtQuick 2.12
import QtQuick.Controls 2.12
import ".."

DialogBase {
	id: modifier_dialog
	width: 256 * scale_factor
	height: ok_button.y + ok_button.height + 8 * scale_factor
	
	property string modifier_string: ""
	property string description: ""
	
	SmallText {
		id: modifier_text
		anchors.top: title_item.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.left: parent.left
		anchors.leftMargin: 8 * scale_factor
		anchors.right: parent.right
		anchors.rightMargin: 8 * scale_factor
		text: format_text(modifier_string)
		horizontalAlignment: Text.AlignHCenter
	}
	
	SmallText {
		id: description_text
		anchors.top: modifier_text.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.left: parent.left
		anchors.leftMargin: 8 * scale_factor
		anchors.right: parent.right
		anchors.rightMargin: 8 * scale_factor
		text: format_text(description)
		visible: description.length > 0
		wrapMode: Text.WordWrap
	}
	
	TextButton {
		id: ok_button
		anchors.top: description_text.visible ? description_text.bottom : modifier_text.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		text: "OK"
		onClicked: {
			modifier_dialog.close()
		}
	}
}
