import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
	id: tile
	implicitWidth: tile_size
	implicitHeight: tile_size
	
	readonly property bool tile_selected: site !== null && selected_settlement === site
	
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
	
	Rectangle {
		id: selection_rectangle
		anchors.fill: parent
		color: "transparent"
		border.color: "white"
		border.width: 1 * scale_factor
		visible: tile_selected
	}
	
	TileImage {
		id: civilian_unit_image
		tile_image_source: civilian_unit ? (
			"image://icon/" + civilian_unit.icon.identifier + (unit_selected ? "/selected" : (civilian_unit.moving && !civilian_unit.working ? "/grayscale" : ""))
		) : "image://empty/"
		visible: civilian_unit !== null
		
		readonly property bool unit_selected: selected_civilian_unit === civilian_unit
		
		Image {
			id: working_icon
			anchors.left: parent.left
			anchors.bottom: parent.bottom
			source: "image://icon/cog"
			fillMode: Image.Pad
			visible: civilian_unit !== null && civilian_unit.working
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
		
		onReleased: {
			var tile_pos = Qt.point(column, row)
			if (selected_civilian_unit !== null && civilian_unit === null && selected_civilian_unit.can_move_to(tile_pos)) {
				selected_civilian_unit.move_to(tile_pos)
				selected_civilian_unit = null
				selected_settlement = null
				return
			}
			
			if (civilian_unit !== null && civilian_unit !== selected_civilian_unit && !civilian_unit.moving && (selected_settlement === null || site !== selected_settlement)) {
				selected_civilian_unit = civilian_unit
				selected_settlement = null
			} else if (site !== null && site.settlement && site !== selected_settlement) {
				selected_settlement = site
				selected_civilian_unit = null
			} else {
				selected_civilian_unit = null
				selected_settlement = null
			}
		}
		
		onDoubleClicked: {
			//maybe move cancellations should be done by a cancel dialog when left-clicking the civilian unit instead
			if (civilian_unit !== null && civilian_unit.moving) {
				civilian_unit.cancel_move()
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
