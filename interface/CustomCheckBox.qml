import QtQuick
import QtQuick.Controls

CheckBox {
	id: checkbox
	font.family: berenika_font.name
	
	property string tooltip: ""
	
	CustomTooltip {
		text: checkbox.tooltip
		visible: checkbox.hovered && checkbox.tooltip.length > 0
	}
}
