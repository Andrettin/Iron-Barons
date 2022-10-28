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
	
	TileImage {
		id: civilian_unit_image
		tile_image_source: civilian_unit ? ("image://icon/" + civilian_unit.icon.identifier + (selected ? "/selected" : "")) : "image://empty/"
		visible: civilian_unit !== null
		
		readonly property bool selected: selected_civilian_unit === civilian_unit
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
		
		onClicked: {
			if (civilian_unit !== null && civilian_unit !== selected_civilian_unit) {
				selected_civilian_unit = civilian_unit
			} else {
				selected_civilian_unit = null
			}
		}
		
		onEntered: {
			var text = "(" + column + ", " + row + ") "
			
			text += "("
			
			if (site !== null && site.settlement) {
				text += "Settlement"
			} else if (resource !== null) {
				text += resource.name
			} else {
				text += terrain.name
			}
			
			text += ") "
			
			if (site !== null) {
				text += site.game_data.current_cultural_name
			}
			
			if (province !== null) {
				if (site !== null) {
					text += ", "
				}
				
				text += province.game_data.current_cultural_name
				
				if (province.game_data.owner !== null) {
					text += ", " + province.game_data.owner.name
				}
			}
			
			status_text = text
		}
	}
}
