import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
	id: tile_image_item
	
	width: tile_size
	height: tile_size
	
	property string tile_image_source: ""
	
	Image {
		id: tile_image
		source: tile_image_source
	}
}
