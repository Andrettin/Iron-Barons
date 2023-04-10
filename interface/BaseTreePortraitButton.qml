import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
	readonly property var tree_item: parent.parent
	readonly property var entry: model.modelData
	readonly property string name: entry.full_name ? entry.full_name : entry.name
	readonly property int horizontal_padding: 8 * scale_factor
	readonly property int vertical_padding: 16 * scale_factor
	property int button_x: 0
	property int button_y: 0
	property int button_width: 1 //the width in buttons
	property bool has_tree_parent: false
	property int parent_button_x: 0
	property int parent_button_y: 0
	property int parent_button_width: 1
	readonly property int parent_x: parent_button_x * width + (parent_button_width - 1) * width / 2 + horizontal_padding
	readonly property int parent_y: parent_button_y * height + vertical_padding
	property string parent_name: ""
	readonly property int parent_text_height: parent_text_height_reference.contentHeight + 2 * scale_factor * 2
	property bool tree_line_visible: true
	property bool grayscale: false
	property bool transparent: false
	property bool disabled: false
	property color border_color: "gray"
	readonly property bool hovered: portrait_button.hovered
	
	signal clicked()
	
	width: portrait_button.width + horizontal_padding * 2
	height: portrait_button.height + vertical_padding * 2
	x: button_x * width + (button_width - 1) * width / 2 + horizontal_padding
	y: button_y * height + vertical_padding
	z: -button_y //make it so buttons farther below are on a lower Z level, so that their lines aren't drawn over upper buttons' text
	
	PortraitButton {
		id: portrait_button
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		portrait_identifier: entry.portrait.identifier
		border_color: parent.border_color
		//grayscale: parent.grayscale
		//transparent: parent.transparent
		//disabled: parent.disabled
		
		onClicked: {
			parent.clicked()
		}
	}
	
	TinyText {
		id: label
		anchors.top: portrait_button.bottom
		anchors.topMargin: 2 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		text: name
		width: parent.width
		wrapMode: Text.WordWrap
		horizontalAlignment: Text.AlignHCenter
	}
	
	TinyText {
		id: parent_text_height_reference
		opacity: 0 //make it 100% transparent, this is for calculating the parent text height only, it shouldn't be visible
		text: parent.parent_name
		width: parent.width
		wrapMode: Text.WordWrap
		horizontalAlignment: Text.AlignHCenter
	}
	
	Rectangle {
		id: parent_line
		width: 2 * scale_factor
		height: vertical_padding - parent_text_height
		color: "gray"
		x: parent.parent_x - parent.x + parent.width / 2 - (width / 2)
		y: parent.parent_y - parent.y + parent.height - vertical_padding + parent_text_height
		visible: parent.has_tree_parent && parent.tree_line_visible
	}
	
	Rectangle {
		id: child_line
		width: 2 * scale_factor
		height: vertical_padding + (parent.x == parent.parent_x && parent_line.height < 0 ? parent_line.height : 0)
		color: "gray"
		x: parent.width / 2 - (width / 2)
		y: 0 - (parent.x == parent.parent_x && parent_line.height < 0 ? parent_line.height : 0)
		visible: parent.has_tree_parent && parent.tree_line_visible
	}
	
	Rectangle {
		id: horizontal_line
		width: get_base_width() + 2 * scale_factor
		height: 2 * scale_factor
		color: "gray"
		x: parent.width / 2 - (child_line.width / 2) - (parent.x > parent.parent_x ? get_base_width() : 0)
		y: 0
		visible: parent.has_tree_parent && parent.x != parent.parent_x && parent.tree_line_visible
		
		function get_base_width() {
			var base_width = 0
			
			if (parent.x < parent.parent_x) {
				base_width = parent.parent_x - parent.x
			} else if (parent.x > parent.parent_x) {
				base_width = parent.x - parent.parent_x
			}
			
			if (parent_text_height > vertical_padding) {
				base_width -= parent_text_height_reference.contentWidth / 2
				base_width -= 2 * scale_factor
			}
			
			return base_width
		}
	}
}
