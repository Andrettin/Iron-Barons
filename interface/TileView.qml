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
	
	TinyText {
		anchors.fill: parent
		text: upper_label
		visible: upper_label.length > 0
		wrapMode: Text.WordWrap
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignTop
	}
	
	MouseArea {
		anchors.fill: parent
		hoverEnabled: true
		onEntered: {
			var text = ""
			
			if (site !== null) {
				text += site.game_data.current_cultural_name + " ("
				
				if (site.settlement) {
					text += "Settlement"
				} else if (resource !== null) {
					text += resource.name
				} else {
					text += terrain.name
				}
				
				text += ")"
			} else {
				text += terrain.name
			}
			
			if (province !== null) {
				text += ", " + province.game_data.current_cultural_name
			}
			
			status_text = text
		}
	}
}
