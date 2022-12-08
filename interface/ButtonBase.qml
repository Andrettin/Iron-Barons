import QtQuick 2.12
import QtQuick.Controls 2.12

RoundButton {
	id: button
	radius: 5 * scale_factor
	ToolTip.text: tooltip
	ToolTip.visible: hovered && tooltip.length > 0
	ToolTip.delay: 1000
	
	property string tooltip: ""
}
