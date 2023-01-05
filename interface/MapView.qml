import QtQuick 2.12
import QtQuick.Controls 2.12
import map_grid_model 1.0

Item {
	id: map_view
	
	property string status_text: ""
	property string interface_style: "dwarven"
	readonly property int tile_size: metternich.defines.tile_size.width * scale_factor
	readonly property real map_area_start_x: map.contentX / tile_size
	readonly property real map_area_start_y: map.contentY / tile_size
	readonly property real map_area_tile_width: map.width / tile_size
	readonly property real map_area_tile_height: map.height / tile_size
	
	property var selected_civilian_unit: null
	property var selected_site: null
	
	property bool tile_detail_mode: false
	
	readonly property var event_dialog_component: Qt.createComponent("dialogs/EventDialog.qml")
	
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
		
		function pixel_to_tile_pos(pixel_x, pixel_y) {
			var tile_x = Math.floor(pixel_x / tile_size)
			var tile_y = Math.floor(pixel_y / tile_size)
			
			return Qt.point(tile_x, tile_y)
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
	
	StatusBar {
		id: status_bar
		anchors.bottom: parent.bottom
		anchors.left: infopanel.right
		anchors.right: parent.right
	}
	
	TopBar {
		id: top_bar
		anchors.top: parent.top
		anchors.left: menu_button_bar.right
	}
	
	Image {
		id: menu_button_bar
		anchors.top: parent.top
		anchors.left: parent.left
		source: "image://interface/" + interface_style + "/menu_button_bar"
		fillMode: Image.PreserveAspectCrop
	}
	
	Image {
		id: minimap_area
		anchors.top: menu_button_bar.bottom
		anchors.left: parent.left
		source: "image://interface/" + interface_style + "/minimap"
		fillMode: Image.PreserveAspectCrop
		
		Minimap {
			id: minimap
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.verticalCenter: parent.verticalCenter
			anchors.verticalCenterOffset: -2 * scale_factor
		}
	}
	
	InfoPanel {
		id: infopanel
		anchors.top: minimap_area.bottom
		anchors.bottom: parent.bottom
		anchors.left: parent.left
	}
	
	Keys.onPressed: {
		switch (event.key) {
			case Qt.Key_E:
				infopanel.end_turn_button.down = true
				break
			case Qt.Key_Shift:
				tile_detail_mode = true
				break
		}
	}
	
	Keys.onReleased: {
		if (event.isAutoRepeat) {
			return
		}
		
		switch (event.key) {
			case Qt.Key_E:
				infopanel.end_turn_button.down = undefined
				infopanel.end_turn_button.onReleased()
				break
			case Qt.Key_Shift:
				tile_detail_mode = false
				break
		}
	}
	
	Connections {
		target: metternich
		
		function onEvent_fired(event_instance) {
			if (event_dialog_component.status == Component.Error) {
				console.error(event_dialog_component.errorString())
				return
			}
			
			var event_dialog = event_dialog_component.createObject(map_view, {
				event_instance: event_instance,
				interface_style: map_view.interface_style
			})
			
			event_dialog.open()
		}
	}
	
	Component.onCompleted: {
		map.center_on_country_capital(metternich.game.player_country)
	}
}
