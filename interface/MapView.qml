import QtQuick 2.12
import QtQuick.Controls 2.12
import map_grid_model 1.0

Item {
	id: map_view
	
	Rectangle {
		id: map_view_background
		color: "black"
		anchors.fill: parent
	}
	
	readonly property int tile_size: metternich.defines.tile_size.width * scale_factor
	
	TableView {
		id: map
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		anchors.left: parent.left
		anchors.right: parent.right
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
				y: settlement ? settlement.game_data.tile_pos.y * tile_size + tile_size + 4 * scale_factor : 0
				z: 40
				
				readonly property var province: model.modelData
				readonly property var settlement: province.capital_settlement
			}
		}
	}
}
