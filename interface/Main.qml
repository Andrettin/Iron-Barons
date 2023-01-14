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
	
	Item { //tooltips need to be attached to an item
		id: tooltip_manager
		
		property int tooltip_y_override: 0
		
		//set the shared properties for tooltips
		ToolTip.toolTip.palette.toolTipText: "white"
		ToolTip.toolTip.font.family: berenika_font.name
		ToolTip.toolTip.font.pixelSize: 12 * scale_factor
		ToolTip.toolTip.background: Rectangle {
			color: "black"
			opacity: 0.90
			border.color: "gray"
			border.width: 1
			radius: 5 * scale_factor
		}
		ToolTip.toolTip.contentItem: Text {
			text: ToolTip.toolTip.text
			font: ToolTip.toolTip.font
			wrapMode: Text.WordWrap
			color: ToolTip.toolTip.palette.toolTipText
			textFormat: Text.RichText
			width: Math.min(contentWidth, 512 * scale_factor)
		}
		ToolTip.toolTip.onOpened: {
			if (tooltip_manager.tooltip_y_override !== 0) {
				ToolTip.toolTip.y = tooltip_manager.tooltip_y_override
				tooltip_manager.tooltip_y_override = 0
			}
		}
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
				//metternich.get_map_template("earth").write_river_image()
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
	
	function format_text(text) {
		var str = text
		str = str.replace(/\n/g, "<br>")
		str = str.replace(/\t/g, "<font color=\"transparent\">aaaa</font>") //whitespaces are ignored after a <br>
		str = str.replace(/~</g, "<font color=\"gold\">")
		str = str.replace(/~>/g, "</font>")
		return str
	}
	
	function font_size_text(text, font_size) {
		return "<span style='font-size: " + font_size + "px;'>" + text + "</span>"
	}
	
	function small_text(text) {
		return font_size_text(text, 10 * scale_factor)
	}
	
	//generate a random number
	function random(n) {
		return Math.floor(Math.random() * n)
	}
	
	//format a number as text
	function number_string(n) {
		return n.toLocaleString(Qt.locale("en_US"), 'f', 0)
	}
	
	function roman_number_string(n) {
		const dict = {
			M: 1000,
			CM:900,
			D:500,
			CD:400,
			C:100,
			XC:90,
			L:50,
			XL:40,
			X:10,
			IX:9,
			V:5,
			IV:4,
			I:1
		}
		
		var str = ""
		
		for (var key in dict) {
			while (n >= dict[key]) {
				str += key
				n -= dict[key]
			}
		}
		
		return str
	}
	
	function date_string(date) {
		var year_str = date_year_string(date)
		var season_str = date_season_string(date)
		
		return season_str + ", " + year_str
	}
	
	function date_year_string(date) {
		var year = date.getUTCFullYear()
		
		if (year < 0) {
			year = year - 1 //-1 is needed, as otherwise negative dates are off by one
		}
		
		return year_string(year)
	}
	
	function year_string(year) {
		var year_suffix = ""
		
		if (year < 0) {
			year_suffix = " BC"
			year = Math.abs(year)
		}
		
		var year_str
		if (year >= 10000) {
			year_str = number_string(year)
		} else {
			year_str = year
		}
		
		return year_str + year_suffix
	}
	
	function date_season_string(date) {
		var month = date.getUTCMonth()
		var season = Math.floor(month / 3 + 1)
		
		return season_string(season)
	}
	
	function season_string(season) {
		switch (season) {
			case 1:
				return "Winter"
			case 2:
				return "Spring"
			case 3:
				return "Summer"
			case 4:
				return "Autumn"
		}
		
		return "Invalid Season: " + season
	}
	
	function color_hex_string(color) {
		var red_hex_str = Math.floor(color.r * 255).toString(16)
		if (red_hex_str.length < 2) {
			red_hex_str = "0" + red_hex_str
		}
		
		var green_hex_str = Math.floor(color.g * 255).toString(16)
		if (green_hex_str.length < 2) {
			green_hex_str = "0" + green_hex_str
		}
		
		var blue_hex_str = Math.floor(color.b * 255).toString(16)
		if (blue_hex_str.length < 2) {
			blue_hex_str = "0" + blue_hex_str
		}
		
		return red_hex_str + green_hex_str + blue_hex_str
	}
	
	function string_list_to_string(str_list, separator) {
		var str = ""
		
		for (var i = 0; i < str_list.length; i++) {
			if (i > 0) {
				str += separator
			}
			
			str += str_list[i]
		}
		
		return str
	}
	
	function object_list_to_name_list(object_list) {
		var name_list = []
		
		for (var object of object_list) {
			name_list.push(object.name)
		}
		
		return name_list
	}
}
