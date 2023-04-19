import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
	id: tile
	implicitWidth: tile_size
	implicitHeight: tile_size
	
	readonly property bool tile_selected: site !== null && selected_site === site && !selected_garrison
	readonly property bool civilian_unit_interactable: civilian_unit !== null && civilian_unit.owner === metternich.game.player_country
	readonly property point tile_pos: Qt.point(column, row)
	readonly property bool is_center_tile: province !== null && province.game_data.center_tile_pos === tile_pos
	
	TileImage {
		id: base_terrain_image
		tile_image_source: "image://" + base_image_source
	}
	
	Repeater {
		model: underlay_image_sources
		
		TileImage {
			id: underlay_image
			tile_image_source: "image://" + modelData
		}
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
	
	Image {
		id: garrison_icon
		anchors.left: parent.left
		anchors.leftMargin: is_fleet ? (Math.floor(tile_size / 2) - Math.floor(width / 2)) : (8 * scale_factor)
		anchors.top: parent.top
		anchors.topMargin: is_fleet ? (Math.floor(tile_size / 2) - Math.floor(height / 2)) : (8 * scale_factor)
		source: "image://icon/" + (is_fleet ? "anchor" : "embassy") + (selected ? "/selected" : "")
		visible: province !== null && is_center_tile && province.game_data.military_unit_category_counts.length > 0
		
		readonly property bool is_fleet: visible && province.water_zone
		readonly property bool selected: visible && selected_province === province && selected_garrison
	}
	
	Item {
		id: tile_detail_item
		anchors.fill: parent
		visible: improvement !== null && tile_detail_mode
		
		LargeText {
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.verticalCenter: parent.verticalCenter
			anchors.verticalCenterOffset: -24 * scale_factor
			text: improvement ? improvement.employment_capacity + "x" + improvement.output_multiplier : ""
			visible: improvement !== null && improvement.resource !== null
		}
		
		Image {
			id: tile_detail_resource_icon
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.verticalCenter: parent.verticalCenter
			source: improvement && improvement.resource ? ("image://icon/" + improvement.resource.commodity.icon.identifier) : "image://empty/"
			fillMode: Image.Pad
			visible: improvement !== null && improvement.resource !== null
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
			var explored = metternich.game.player_country.game_data.is_tile_explored(tile_pos)
			
			if (!explored) {
				return
			}
			
			if (selected_civilian_unit !== null && !selected_civilian_unit.moving && !selected_civilian_unit.working) {
				if (tile_pos === selected_civilian_unit.tile_pos) {
					if (selected_civilian_unit.can_build_on_tile()) {
						selected_civilian_unit.build_on_tile()
						selected_civilian_unit = null
						selected_site = null
						selected_province = null
						selected_garrison = false
						return
					}
				} else if (civilian_unit === null && selected_civilian_unit.can_move_to(tile_pos)) {
					selected_civilian_unit.move_to(tile_pos)
					selected_civilian_unit = null
					selected_site = null
					selected_province = null
					selected_garrison = false
					return
				}
			}
			
			if (metternich.selected_military_units.length > 0) {
				metternich.move_selected_military_units_to(tile_pos)
				selected_civilian_unit = null
				selected_site = null
				selected_province = null
				selected_garrison = false
				return
			}
			
			if (civilian_unit !== null && civilian_unit_interactable && civilian_unit !== selected_civilian_unit && !civilian_unit.moving && !civilian_unit.working && (selected_site === null || site !== selected_site || selected_garrison)) {
				selected_civilian_unit = civilian_unit
				selected_site = null
				selected_province = null
			} else if (site !== null && (site !== selected_site || selected_garrison) && (site.settlement || resource || improvement)) {
				selected_site = site
				selected_province = province
				selected_civilian_unit = null
			} else {
				selected_civilian_unit = null
				selected_site = null
				selected_province = null
			}
			
			selected_garrison = false
		}
		
		onDoubleClicked: {
			//maybe move cancellations should be done by a cancel dialog when left-clicking the civilian unit instead
			if (civilian_unit !== null && civilian_unit_interactable) {
				if (civilian_unit.moving) {
					civilian_unit.cancel_move()
				} else if (civilian_unit.working) {
					civilian_unit.cancel_work()
				}
			}
		}
		
		onEntered: {
			var text = "(" + column + ", " + row + ") "
			
			text += "("
			
			var explored = metternich.game.player_country.game_data.is_tile_explored(tile_pos)
			
			if (!explored) {
				text += "Unexplored"
			} else if (site !== null && site.settlement) {
				text += "Settlement"
			} else if (improvement !== null) {
				text += improvement.name
			} else if (resource !== null) {
				text += resource.name
			} else {
				text += terrain.name
			}
			
			text += ") "
			
			if (explored) {
				if (site !== null && (improvement !== null || resource !== null || site.settlement)) {
					text += site.game_data.current_cultural_name
				}
				
				if (province !== null) {
					if (site !== null && (improvement !== null || resource !== null || site.settlement)) {
						text += ", "
					}
					
					text += province.game_data.current_cultural_name
					
					if (province.game_data.owner !== null) {
						text += ", " + province.game_data.owner.name
					}
				}
			}
			
			status_text = text
		}
		onExited: {
			status_text = ""
		}
	}
	
	MouseArea {
		anchors.horizontalCenter: garrison_icon.horizontalCenter
		anchors.verticalCenter: garrison_icon.verticalCenter
		width: Math.min(garrison_icon.width + 8 * scale_factor, tile_size)
		height: Math.min(garrison_icon.height + 8 * scale_factor, tile_size)
		hoverEnabled: true
		enabled: garrison_icon.visible && province !== null && (province.water_zone || (province.game_data.owner !== null && (province.game_data.owner === metternich.game.player_country || province.game_data.owner.game_data.is_any_vassal_of(metternich.game.player_country))))
		visible: enabled
		
		onReleased: {
			selected_civilian_unit = null
			
			if (garrison_icon.selected) {
				selected_site = null
				selected_province = null
				selected_garrison = false
			} else {
				selected_site = site
				selected_province = province
				selected_garrison = true
			}
		}
		
		onEntered: {
			status_text = "Garrison"
		}
		onExited: {
			status_text = ""
		}
	}
}
