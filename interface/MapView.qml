import QtQuick 2.12
import QtQuick.Controls 2.12
import map_grid_model 1.0

Item {
	id: map_view
	
	property string status_text: ""
	property string interface_style: "dwarven"
	readonly property int tile_size: metternich.defines.tile_size.width * scale_factor
	
	Rectangle {
		id: map_view_background
		color: "black"
		anchors.fill: parent
	}
	
	TableView {
		id: map
		anchors.top: top_bar.bottom
		anchors.bottom: status_bar.top
		anchors.left: infopanel.right
		anchors.right: right_bar.left
		leftMargin: 0
		rightMargin: 0
		topMargin: 0
		bottomMargin: 0
		contentWidth: tile_size * metternich.map.width
		contentHeight: tile_size * metternich.map.height
		boundsBehavior: Flickable.StopAtBounds
		clip: true
		model: MapGridModel {}
		delegate: TileView {}
		
		Repeater {
			model: metternich.map.provinces
			
			TinyText {
				text: settlement ? province.game_data.current_cultural_name : ""
				x: settlement ? settlement.game_data.tile_pos.x * tile_size + tile_size / 2 - width / 2 : 0
				y: settlement ? settlement.game_data.tile_pos.y * tile_size + tile_size + 2 * scale_factor : 0
				z: 40
				
				readonly property var province: model.modelData
				readonly property var settlement: province.capital_settlement
			}
		}
		
		function center_on_tile(tile_x, tile_y) {
			var pixel_x = tile_x * tile_size - map.width / 2
			var pixel_y = tile_y * tile_size - map.height / 2
			
			map.contentX = Math.min(Math.max(pixel_x, 0), map.contentWidth - map.width)
			map.contentY = Math.min(Math.max(pixel_y, 0), map.contentHeight - map.height)
		}
		
		function center_on_country_capital(country) {
			var capital_game_data = country.capital_province.capital_settlement.game_data
			var capital_x = capital_game_data.tile_pos.x
			var capital_y = capital_game_data.tile_pos.y
			
			center_on_tile(capital_x, capital_y)
		}
	}
	
	Image {
		id: right_bar
		anchors.top: parent.top
		anchors.right: parent.right
		source: "image://interface/" + interface_style + "/right_bar"
		fillMode: Image.PreserveAspectCrop
	}
	
	Image {
		id: status_bar
		anchors.bottom: parent.bottom
		anchors.left: infopanel.right
		source: "image://interface/" + interface_style + "/status_bar"
		fillMode: Image.PreserveAspectCrop
		
		SmallText {
			text: status_text
			anchors.bottom: parent.bottom
			anchors.bottomMargin: 1 * scale_factor
			anchors.left: parent.left
			anchors.leftMargin: 16 * scale_factor
		}
	}
	
	Image {
		id: top_bar
		anchors.top: parent.top
		anchors.left: menu_button_bar.right
		source: "image://interface/" + interface_style + "/top_bar"
		fillMode: Image.PreserveAspectCrop
	}
	
	Image {
		id: menu_button_bar
		anchors.top: parent.top
		anchors.left: parent.left
		source: "image://interface/" + interface_style + "/menu_button_bar"
		fillMode: Image.PreserveAspectCrop
	}
	
	Image {
		id: minimap
		anchors.top: menu_button_bar.bottom
		anchors.left: parent.left
		source: "image://interface/" + interface_style + "/minimap"
		fillMode: Image.PreserveAspectCrop
	}
	
	Image {
		id: infopanel
		anchors.top: minimap.bottom
		anchors.left: parent.left
		source: "image://interface/" + interface_style + "/infopanel"
		fillMode: Image.PreserveAspectCrop
	}
	
	Component.onCompleted: {
		map.center_on_country_capital(metternich.game.player_country)
	}
}
