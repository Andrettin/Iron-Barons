import QtQuick
import QtQuick.Controls

RoundButton {
	id: button
	radius: 5 * scale_factor
	ToolTip.text: tooltip
	ToolTip.visible: hovered && tooltip.length > 0
	ToolTip.delay: 1000
	
	property string tooltip: ""
}
