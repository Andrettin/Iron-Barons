import QtQuick 2.12
import QtQuick.Controls 2.12
import MaskedMouseArea 1.0

Flickable {
	id: diplomatic_map
	contentWidth: metternich.map.diplomatic_map_image_size.width * scale_factor
	contentHeight: metternich.map.diplomatic_map_image_size.height * scale_factor
	boundsBehavior: Flickable.StopAtBounds
	clip: true
	
	enum Mode {
		Country,
		Culture
	}
	
	property string ocean_suffix: ""
	property string country_suffix: "0"
	property var selected_country: null
	property int mode: DiplomaticMap.Mode.Country
	
	Image {
		id: ocean_image
		source: ocean_suffix.length > 0 ? ("image://diplomatic_map/ocean/" + ocean_suffix) : "image://empty/"
		cache: false
	}
	
	MouseArea {
		width: diplomatic_map.contentWidth
		height: diplomatic_map.contentHeight
		
		onClicked: {
			diplomatic_map.selected_country = null
		}
	}
	
	Repeater {
		model: metternich.game.countries
		
		Image {
			id: country_image
			x: country.game_data.diplomatic_map_image_rect.x
			y: country.game_data.diplomatic_map_image_rect.y
			source: "image://diplomatic_map/" + country.identifier + (selected ? "/selected" : (
				diplomatic_map.mode === DiplomaticMap.Mode.Culture ? "/culture" : ""
			)) + "/" + country_suffix
			cache: false
			
			readonly property var country: model.modelData
			readonly property var selected: selected_country === country
			
			MaskedMouseArea {
				anchors.fill: parent
				alphaThreshold: 0.4
				maskSource: parent.source
				ToolTip.text: country.name + tooltip_suffix
				ToolTip.visible: containsMouse
				ToolTip.delay: 1000
				
				property string tooltip_suffix: ""
				
				onClicked: {
					if (selected) {
						diplomatic_map.selected_country = null
					} else {
						diplomatic_map.selected_country = country
					}
				}
				
				onMousePosChanged: {
					var new_tooltip_suffix = get_tooltip_suffix(mousePos.x, mousePos.y)
					if (new_tooltip_suffix !== tooltip_suffix) {
						tooltip_suffix = new_tooltip_suffix
					}
				}
				
				function get_tooltip_suffix(mouse_x, mouse_y) {
					if (diplomatic_map.mode !== DiplomaticMap.Mode.Culture) {
						return ""
					}
					
					var relative_tile_x = Math.floor(mouse_x * country.game_data.territory_rect.width / country.game_data.diplomatic_map_image_rect.width)
					var relative_tile_y = Math.floor(mouse_y * country.game_data.territory_rect.height / country.game_data.diplomatic_map_image_rect.height)
					
					var tile_x = country.game_data.territory_rect.x + relative_tile_x
					var tile_y = country.game_data.territory_rect.y + relative_tile_y
					
					var tile_province = metternich.map.get_tile_province(tile_x, tile_y)
					if (tile_province !== null && tile_province.game_data.culture !== null) {
						return " (" + tile_province.game_data.culture.name + ")"
					}
					
					return ""
				}
			}
		}
	}
	
	/*
	Repeater {
		model: metternich.game.countries
		
		TinyText {
			id: country_label
			text: country.name
			x: Math.floor(territory_rect.x * metternich.map.diplomatic_map_tile_pixel_size * scale_factor + territory_rect_width / 2 - width / 2)
			y: Math.floor(territory_rect.y * metternich.map.diplomatic_map_tile_pixel_size * scale_factor + territory_rect_height / 2 - height / 2)
			visible: width <= territory_rect_width
			font.pixelSize: 8 * scale_factor
			shadow_offset: 1 * scale_factor
			font.bold: true
					
			readonly property var country: model.modelData
			readonly property var territory_rect: country.game_data.main_contiguous_territory_rect
			readonly property int territory_rect_width: territory_rect.width * metternich.map.diplomatic_map_tile_pixel_size * scale_factor
			readonly property int territory_rect_height: territory_rect.height * metternich.map.diplomatic_map_tile_pixel_size * scale_factor
		}
	}
	*/
	
	Repeater {
		model: selected_country ? selected_country.game_data.consulates : []
		
		Image {
			id: consulate_icon
			x: other_country.capital_province.capital_settlement.game_data.tile_pos.x * metternich.map.diplomatic_map_tile_pixel_size * scale_factor - width / 2
			y: other_country.capital_province.capital_settlement.game_data.tile_pos.y * metternich.map.diplomatic_map_tile_pixel_size * scale_factor - height / 2
			source: "image://icon/" + consulate.icon.identifier
			visible: !selected_country.game_data.anarchy && !other_country.game_data.anarchy
			
			readonly property var other_country: model.modelData.key
			readonly property var consulate: model.modelData.value
			
			MaskedMouseArea {
				anchors.fill: parent
				alphaThreshold: 0.4
				maskSource: parent.source
				ToolTip.text: small_text(consulate.name)
				ToolTip.visible: containsMouse
				ToolTip.delay: 1000
				
				onClicked: {
					diplomatic_map.selected_country = other_country
				}
			}
		}
	}
	
	function center_on_tile_pos(tile_x, tile_y) {
		var pixel_x = tile_x * metternich.map.diplomatic_map_tile_pixel_size * scale_factor - diplomatic_map.width / 2
		var pixel_y = tile_y * metternich.map.diplomatic_map_tile_pixel_size * scale_factor - diplomatic_map.height / 2
		
		diplomatic_map.contentX = Math.min(Math.max(pixel_x, 0), diplomatic_map.contentWidth - diplomatic_map.width)
		diplomatic_map.contentY = Math.min(Math.max(pixel_y, 0), diplomatic_map.contentHeight - diplomatic_map.height)
	}
	
	function center_on_selected_country_capital() {
		var capital_game_data = selected_country.capital_province.capital_settlement.game_data
		var capital_x = capital_game_data.tile_pos.x
		var capital_y = capital_game_data.tile_pos.y
		center_on_tile_pos(capital_x, capital_y)
	}
}
