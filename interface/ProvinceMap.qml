import QtQuick 2.12
import QtQuick.Controls 2.12
import MaskedMouseArea 1.0

Flickable {
	id: province_map
	contentWidth: metternich.game.diplomatic_map_image_size.width * scale_factor
	contentHeight: metternich.game.diplomatic_map_image_size.height * scale_factor
	boundsBehavior: Flickable.StopAtBounds
	clip: true
	
	property string ocean_suffix: ""
	property string province_suffix: "0"
	property var selected_province: null
	
	Image {
		id: ocean_image
		source: ocean_suffix.length > 0 ? ("image://diplomatic_map/ocean/" + ocean_suffix) : "image://empty/"
		cache: false
	}
	
	MouseArea {
		width: province_map.contentWidth
		height: province_map.contentHeight
		
		onClicked: {
			province_map.selected_province = null
		}
	}
	
	Repeater {
		model: metternich.map.provinces
		
		Image {
			id: country_image
			x: province.game_data.province_map_image_rect.x
			y: province.game_data.province_map_image_rect.y
			source: "image://diplomatic_map/province/" + province.identifier + (selected ? "/selected" : "") + "/" + province_suffix
			cache: false
			
			readonly property var province: model.modelData
			readonly property var selected: selected_province === province
			
			MaskedMouseArea {
				anchors.fill: parent
				alphaThreshold: 0.4
				maskSource: parent.source
				ToolTip.text: province.name
				ToolTip.visible: containsMouse
				ToolTip.delay: 1000
				
				onClicked: {
					if (selected || province.water_zone) {
						province_map.selected_province = null
					} else {
						province_map.selected_province = province
					}
				}
			}
		}
	}
	
	function center_on_tile_pos(tile_x, tile_y) {
		var pixel_x = tile_x * metternich.game.diplomatic_map_tile_pixel_size * scale_factor - province_map.width / 2
		var pixel_y = tile_y * metternich.game.diplomatic_map_tile_pixel_size * scale_factor - province_map.height / 2
		
		province_map.contentX = Math.min(Math.max(pixel_x, 0), province_map.contentWidth - province_map.width)
		province_map.contentY = Math.min(Math.max(pixel_y, 0), province_map.contentHeight - province_map.height)
	}
	
	function center_on_selected_province() {
		var capital_game_data = selected_province.capital_settlement.game_data
		var capital_x = capital_game_data.tile_pos.x
		var capital_y = capital_game_data.tile_pos.y
		center_on_tile_pos(capital_x, capital_y)
	}
}
