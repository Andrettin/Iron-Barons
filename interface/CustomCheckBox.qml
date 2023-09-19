import QtQuick
import QtQuick.Controls

CheckBox {
	id: checkbox
	font.family: berenika_font.name
	ToolTip.text: tooltip
	ToolTip.visible: hovered && tooltip.length > 0
	ToolTip.delay: 1000
	
	property string tooltip: ""
}
