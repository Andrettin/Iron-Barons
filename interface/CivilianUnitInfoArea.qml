import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
	id: civilian_unit_info_area
	
	Grid {
		id: improvable_resources_grid
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		anchors.horizontalCenter: parent.horizontalCenter
		columns: 4
		columnSpacing: 4 * scale_factor
		rowSpacing: 4 * scale_factor
		
		Repeater {
			model: selected_civilian_unit ? selected_civilian_unit.improvable_resource_tiles : []
			
			Item {
				width: resource_icon.width + 4 * scale_factor
				height: resource_icon.height
				
				readonly property var resource: model.modelData.key
				readonly property var tiles: model.modelData.value
				property int next_tile_index: 0
				
				Image {
					id: resource_icon
					anchors.verticalCenter: parent.verticalCenter
					anchors.left: parent.left
					source: "image://icon/" + resource.icon.identifier
				}
				
				SmallText {
					id: count_label
					text: number_string(tiles.length)
					anchors.right: parent.right
					anchors.bottom: parent.bottom
				}
				
				MouseArea {
					anchors.fill: parent
					hoverEnabled: true
					
					onReleased: {
						map.center_on_tile(tiles[next_tile_index].x, tiles[next_tile_index].y)
						
						next_tile_index += 1
						if (next_tile_index >= tiles.length) {
							next_tile_index = 0
						}
					}
					
					onEntered: {
						status_text = resource.name
					}
					
					onExited: {
						status_text = ""
					}
				}
			}
		}
	}
}