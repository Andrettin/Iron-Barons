import QtQuick 2.12
import QtQuick.Controls 2.12
import ".."

Popup {
	id: dialog
	x: Math.floor(parent.width / 2 - (width / 2))
	y: Math.floor(parent.height / 2 - (height / 2))
	width: default_width
	height: default_height
	padding: 0
	modal: true
	dim: false
	focus: false
	closePolicy: Popup.NoAutoClose
	clip: true
	
	readonly property int default_width: 256 * scale_factor
	readonly property int default_height: 256 * scale_factor
	property string interface_style: "default"
	property int panel: 1
	property string title: ""
	readonly property var title_item: title_text
	property bool open_when_menu_is_closed: false
	
	background: Rectangle {
		width: dialog.width
		height: dialog.height
		color: interface_background_color
		radius: 5 * scale_factor
        border.color: "gray"
        border.width: 1 * scale_factor
	}
	
	MouseArea {
		anchors.fill: parent
		hoverEnabled: true
		//prevent events from propagating below
	}
	
	Pane {
		id: pane
		anchors.fill: parent
		focusPolicy: Qt.ClickFocus
		background: null
	}
	
	LargeText {
		id: title_text
		text: dialog.title
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: parent.top
		anchors.topMargin: 16 * scale_factor
	}
	
	onOpened: {
		dialog.receive_focus()
		
		if (parent.dialogs) {
			parent.dialogs.push(this)
		}
	}
	
	onClosed: {
		dialog.give_up_focus()
		
		if (parent.dialogs) {
			const dialog_index = parent.dialogs.indexOf(this)
			if (dialog_index != -1) {
				parent.dialogs.splice(dialog_index, 1)
			}
		}
	}
	
	function give_up_focus() {
		//give focus to a different open dialog, if any
		if (parent.dialogs) {
			for (var i = 0; i < parent.dialogs.length; ++i) {
				var child_item = parent.dialogs[i]
				
				if (child_item == this) {
					continue
				}
				
				if (child_item instanceof DialogBase) {
					child_item.receive_focus()
					return
				}
			}
		}
		
		parent.forceActiveFocus()
	}
	
	function receive_focus() {
		pane.forceActiveFocus()
	}
}
