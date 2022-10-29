import QtQuick 2.12
import QtQuick.Controls 2.12

Image {
	id: minimap
	anchors.horizontalCenter: parent.horizontalCenter
	anchors.verticalCenter: parent.verticalCenter
	anchors.verticalCenterOffset: -2 * scale_factor
	source: "image://diplomatic_map/minimap/" + metternich.game.turn
	width: 128 * scale_factor
	height: 64 * scale_factor
	fillMode: Image.Stretch
	smooth: true
	cache: false
	
	readonly property real tiles_per_pixel: sourceSize.width / width
	
	Rectangle {
		id: visible_area_rectangle
		color: "transparent"
		border.color: "white"
		border.width: 1
		x: map_area_start_x / tiles_per_pixel
		y: map_area_start_y / tiles_per_pixel
		width: map_area_tile_width / tiles_per_pixel
		height: map_area_tile_height / tiles_per_pixel
	}
	
	MouseArea {
		anchors.fill: parent
		
		onPositionChanged: {
			center(mouse.x, mouse.y)
		}
		
		onClicked: {
			center(mouse.x, mouse.y)
		}
		
		function center(pixel_x, pixel_y) {
			var tile_x = Math.floor(pixel_x * tiles_per_pixel)
			var tile_y = Math.floor(pixel_y * tiles_per_pixel)
			map.center_on_tile(tile_x, tile_y)
		}
	}
}
