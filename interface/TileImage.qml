import QtQuick
import QtQuick.Controls

Item {
	id: tile_image_item
	
	width: tile_size
	height: tile_size
	
	property string tile_image_source: ""
	
	Image {
		id: tile_image
		source: tile_image_source
		anchors.horizontalCenter: tile_image_item.horizontalCenter
		anchors.verticalCenter: tile_image_item.verticalCenter
		fillMode: Image.Pad
	}
}
