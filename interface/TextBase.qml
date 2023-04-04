import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

Text {
	id: label
	color: "white"
	font.family: berenika_font.name
	
	property int shadow_offset: 0
	property var shadow_color: "black"
	
	Text {
		id: text_shadow
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.horizontalCenterOffset: shadow_offset
		anchors.verticalCenter: parent.verticalCenter
		anchors.verticalCenterOffset: shadow_offset
		width: parent.width
		height: parent.height
		text: colored_text(parent.text, shadow_color)
		color: shadow_color
		font: parent.font
		wrapMode: parent.wrapMode
		horizontalAlignment: parent.horizontalAlignment
		verticalAlignment: parent.verticalAlignment
		z: -1 //draw below parent
	}
}
