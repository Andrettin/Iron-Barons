import QtQuick 2.12
import QtQuick.Controls 2.12

Image {
	id: modifier_icon
	source: "image://icon/" + scripted_modifier.icon.identifier + "/small/" + (scripted_modifier.negative ? "red" : "green")
	
	property var scripted_modifier_pair: null
	readonly property var scripted_modifier: scripted_modifier_pair.key
	readonly property int duration: scripted_modifier_pair.value
	readonly property string modifier_string: scripted_modifier.modifier_string
	
	MouseArea {
		anchors.fill: parent
		ToolTip.text: scripted_modifier.name + (modifier_string.length > 0 ? format_text(small_text("\n"
			+ "\nDuration: " + (duration * metternich.defines.months_per_turn) + " Months"
			+ "\n" + modifier_string)) : "")
		ToolTip.visible: containsMouse
		ToolTip.delay: 1000
		hoverEnabled: true
	}
}
