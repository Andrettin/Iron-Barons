import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Universal

ButtonBase {
	id: button
	width: (32 * scale_factor) + 6 * scale_factor
	height: (32 * scale_factor) + 6 * scale_factor
	leftPadding: button.down ? 1 * scale_factor : 0
	topPadding: button.down ? 1 * scale_factor : 0
	icon.source: "image://icon/" + icon_identifier
	icon.color: "transparent"
	radius: circle ? (width * 0.5) : (width * 0.25)
	padding: 0
	
	property string icon_identifier: ""
	property bool circle: false
	property bool use_opacity_mask: true
}
