import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Window 2.12

Window {
	property real scale_factor: 1

	id: window
	visible: true
	width: 640
	height: 480
	title: qsTr("Iron Barons")
	flags: Qt.FramelessWindowHint
	visibility: "Maximized"
	//visibility: "FullScreen"

	Item { //tooltips need to be attached to an item
		//set the shared properties for tooltips
		ToolTip.toolTip.palette.text: "white"
		ToolTip.toolTip.font.family: "tahoma"
		ToolTip.toolTip.font.pixelSize: 14 * scale_factor
		ToolTip.toolTip.contentWidth: (tooltip_metrics.width + 8)
		ToolTip.toolTip.background: Rectangle {
			color: "black"
			opacity: 0.90
			border.color: "gray"
			border.width: 1
			radius: 5 * scale_factor
		}
		ToolTip.toolTip.onTextChanged: tooltip_metrics.text = get_longest_line(remove_text_colors(ToolTip.toolTip.text), 64)

		TextMetrics {
			id: tooltip_metrics
			font.family: "tahoma"
			font.pixelSize: 14 * scale_factor
		}

		FontMetrics {
			id: font_metrics
			font.family: "tahoma"
			font.pixelSize: 14 * scale_factor
		}
	}

	//format tooltip text
	function tooltip(text) {
		return "<font color=\"white\">" + text + "</font>"
	}

	//highlight text
	function highlight(text) {
		return "<font color=\"gold\">" + text + "</font>"
	}

	function remove_text_colors(text) {
		var str = text
		str = str.replace(/<font color="gold">/g, "")
		str = str.replace(/<font color="transparent">/g, "")
		str = str.replace(/<font color="white">/g, "")
		str = str.replace(/<\/font>/g, "")
		return str
	}

	function get_longest_line(str, max_len) {
		var str_arr = str.split("<br>")
		var longest_line = ""
		var best_length = 0
		for (var i = 0; i < str_arr.length; i++) {
			var length = font_metrics.advanceWidth(str_arr[i])
			if (length > best_length) {
				longest_line = str_arr[i]
				best_length = length
			}
		}

		while (longest_line.length > max_len && longest_line.lastIndexOf(" ") !== -1) {
			var last_index = longest_line.lastIndexOf(" ")
			longest_line = longest_line.substr(0, last_index)
		}

		return longest_line
	}

	//function to format numbers as text
	function number_str(n) {
		return n.toLocaleString(Qt.locale("en_US"), 'f', 0)
	}

	//function to format numbers with two decimal places
	function centesimal(number, always_use_sign = false) {
		var abs_number = Math.abs(number)
		var src_number_string = ""
		src_number_string += abs_number
		var dest_number_string = ""
		if (always_use_sign && number >= 0) {
			dest_number_string += "+"
		} else if (number < 0) {
			dest_number_string += "-"
		}
		if (abs_number < 100) {
			dest_number_string += "0."
		} else {
			dest_number_string += src_number_string.slice(0, src_number_string.length - 2) + "."
		}
		if (abs_number < 10) {
			dest_number_string += "0"
		}
		dest_number_string += src_number_string.slice(src_number_string.length - 2)
		return dest_number_string.toLocaleString(Qt.locale("en_US"), 'f', 2)
	}
	
	//replace the tooltip highlight text coloring with the panel highlight one
	function use_panel_highlight(text) {
		return text.replace(/<font color="gold">/g, "<font color=\"maroon\">")
	}

	function start_game() {
		var component = Qt.createComponent("GameView.qml");
		component.createObject(window);
	}

	Connections {
		target: metternich.game
		onRunningChanged: {
			if (metternich.game.running) {
				start_game()
			}
		}
	}

	Text {
		id: loading_message
		visible: !metternich.game.running
		text: metternich.loading_message
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		color: "black"
		font.pixelSize: 14 * scale_factor
		font.family: "tahoma"
	}
}
