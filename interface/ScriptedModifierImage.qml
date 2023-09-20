import QtQuick
import QtQuick.Controls

Image {
	id: modifier_icon
	source: "image://icon/" + scripted_modifier.icon.identifier + "/small/" + (scripted_modifier.negative ? "red" : "green")
	
	property var scripted_modifier_pair: null
	property var scope: null
	readonly property var scripted_modifier: scripted_modifier_pair.key
	readonly property int duration: scripted_modifier_pair.value
	readonly property string modifier_string: scripted_modifier.get_modifier_string(scope)
	
	MouseArea {
		id: icon_mouse_area
		anchors.fill: parent
		hoverEnabled: true
	}
	
	CustomTooltip {
		text: scripted_modifier.name + (modifier_string.length > 0 ? format_text(small_text("\n"
			+ "\nDuration: " + (duration * metternich.defines.months_per_turn) + " Months"
			+ "\n" + modifier_string)) : "")
		visible: icon_mouse_area.containsMouse
	}
}
