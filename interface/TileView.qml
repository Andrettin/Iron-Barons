import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
	id: tile
	
	implicitWidth: tile_size
	implicitHeight: tile_size
	
	TileImage {
		id: base_terrain_image
		tile_image_source: "image://tile/" + base_image_source
	}
	
	TileImage {
		id: terrain_image
		tile_image_source: "image://tile/" + image_source
	}
}
