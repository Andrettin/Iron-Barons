import QtQuick
import QtQuick.Controls

Grid {
	id: background_grid
	anchors.top: parent.top
	anchors.topMargin: -(parent.y % (32 * scale_factor))
	anchors.bottom: parent.bottom
	anchors.left: parent.left
	anchors.leftMargin: -(parent.x % (32 * scale_factor))
	anchors.right: parent.right
	rows: Math.ceil(parent.height / (32 * scale_factor)) + 1
	columns: Math.ceil(parent.width / (32 * scale_factor)) + 1
	rowSpacing: 0
	columnSpacing: 0
	
	Repeater {
		model: Math.max(background_grid.rows * background_grid.columns, 1)
		
		Image {
			id: background_tile
			source: "image://interface/wood_2/tiled_background/" + random(4)
		}
	}
}
