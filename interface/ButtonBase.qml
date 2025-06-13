import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Universal

RoundButton {
	id: button
	radius: 5 * scale_factor
	
	property string tooltip: ""
	
	CustomTooltip {
		text: button.tooltip
		visible: button.hovered && button.tooltip.length > 0
	}
}
