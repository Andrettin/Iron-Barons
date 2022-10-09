import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import "./menus"

Window {
	id: window
	visible: true
	title: qsTr("Iron Barons")
	width: Screen.width
	height: Screen.height + 1 //it needs to be +1 otherwise it becomes (non-borderless) fullscreen automatically
	flags: Qt.FramelessWindowHint | Qt.Window
	color: "black"
	
	readonly property real scale_factor: metternich.scale_factor
	
	FontLoader {
		id: berenika_font
		source: "../fonts/berenika.ttf"
	}
	
	FontLoader {
		id: berenika_bold_font
		source: "../fonts/berenika_bold.ttf"
	}
	
	MenuStack {
		id: menu_stack
		initialItem: "menus/MainMenu.qml"
	}
	
	Connections {
		target: metternich.game
		function onRunningChanged() {
			if (metternich.game.running) {
				menu_stack.push("MapView.qml")
			}
		}
	}
	
	function highlight(text) {
		//highlight text
		return "<font color=\"gold\">" + text + "</font>"
	}
	
	//generate a random number
	function random(n) {
		return Math.floor(Math.random() * n)
	}
}
