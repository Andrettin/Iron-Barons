import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Universal

RoundButton {
	id: button
	radius: 5 * scale_factor
	clip: true
	
	Rectangle {
		anchors.fill: parent
		color: Universal.background
		radius: parent.radius
		z: -1
	}
	
	property string tooltip: ""
	
	CustomTooltip {
		text: button.tooltip
		visible: button.hovered && button.tooltip.length > 0
	}
}
