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
		visible: metternich.running
	}
	
	Connections {
		target: metternich
		function onRunningChanged() {
			if (metternich.running) {
				//metternich.get_map_template("earth").write_province_image()
				//metternich.get_map_template("earth").write_terrain_image()
			}
		}
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
	
	//format a number as text
	function number_string(n) {
		return n.toLocaleString(Qt.locale("en_US"), 'f', 0)
	}
	
	function date_year_string(date) {
		var year = date.getUTCFullYear()
		
		if (year < 0) {
			year = year - 1 //-1 is needed, as otherwise negative dates are off by one
		}
		
		return year_string(year)
	}
	
	function year_string(year) {
		var year_suffix
		
		if (year >= 0) {
			year_suffix = "AD"
		} else {
			year_suffix = "BC"
			year = Math.abs(year)
		}
		
		var year_str
		if (year >= 10000) {
			year_str = number_string(year)
		} else {
			year_str = year
		}
		
		return year_str + " " + year_suffix
	}
}
