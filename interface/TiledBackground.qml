import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Universal

Grid {
	id: background_grid
	rowSpacing: 0
	columnSpacing: 0
	
	property string interface_style: "light_wood"
	property int frame_count: 4
	
	Repeater {
		model: Math.max(background_grid.rows * background_grid.columns, 1)
		
		Image {
			id: background_tile
			source: "image://interface/" + interface_style + "/tiled_background/" + random(frame_count)
		}
	}
}
