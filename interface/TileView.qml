import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
	id: tile
	
	implicitWidth: tile_size
	implicitHeight: tile_size
	
	TileImage {
		id: base_terrain_image
		tile_image_source: "image://" + base_image_source
	}
	
	TileImage {
		id: terrain_image
		tile_image_source: "image://" + image_source
	}
	
	Repeater {
		model: overlay_image_sources
		
		TileImage {
			id: overlay_image
			tile_image_source: "image://" + modelData
		}
	}
	
	MouseArea {
		anchors.fill: parent
		ToolTip.text: province ? (site ? (site.game_data.current_cultural_name + ", " + province.game_data.current_cultural_name) : province.game_data.current_cultural_name) : ""
		ToolTip.visible: containsMouse && ToolTip.text !== ""
		ToolTip.delay: 1000
		hoverEnabled: true
	}
}
