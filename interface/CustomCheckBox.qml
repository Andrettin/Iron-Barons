import QtQuick 2.12
import QtQuick.Controls 2.12

CheckBox {
	id: checkbox
	font.family: berenika_font.name
	ToolTip.text: tooltip
	ToolTip.visible: hovered && tooltip.length > 0
	ToolTip.delay: 1000
	
	property string tooltip: ""
}
