import QtQuick 2.12
import QtQuick.Controls 2.12
import ".."

DialogBase {
	id: factory_dialog
	title: building ? building.name : ""
	panel: 5
	width: 256 * scale_factor + 8 * scale_factor * 2
	height: ok_button.y + ok_button.height + 8 * scale_factor
	
	property var building_slot: null
	readonly property var building: building_slot ? building_slot.building : null
	
	SmallText {
		id: capacity_label
		anchors.top: title_item.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		text: "Capacity: " + (building ? building.base_capacity : "")
	}
	
	Column {
		id: production_types_column
		anchors.top: capacity_label.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		
		Repeater {
			model: building ? building.production_types : []
			
			Item {
				width: 176 * scale_factor + 16 * scale_factor + commodity_icon.width
				height: 32 * scale_factor + 16 * scale_factor
				
				readonly property var production_type: model.modelData
				readonly property var output_commodity: production_type.output_commodity
				property int output_value: building_slot.get_production_type_employed_capacity(production_type)
				
				Image {
					id: commodity_icon
					anchors.top: parent.top
					anchors.left: parent.left
					source: "image://icon/" + output_commodity.icon.identifier
				}
				
				Item {
					id: production_slider
					anchors.verticalCenter: commodity_icon.verticalCenter
					anchors.right: parent.right
					width: 176 * scale_factor
					height: 16 * scale_factor
					
					Rectangle {
						anchors.verticalCenter: parent.verticalCenter
						anchors.left: parent.left
						anchors.leftMargin: 8 * scale_factor
						anchors.right: parent.right
						anchors.rightMargin: 8 * scale_factor
						height: 16 * scale_factor
						color: "transparent"
						border.color: "gray"
						border.width: 1 * scale_factor
						
						SmallText {
							id: stored_label
							text: number_string(output_value)
							anchors.verticalCenter: parent.verticalCenter
							anchors.horizontalCenter: parent.horizontalCenter
						}
					}
					
					IconButton {
						anchors.verticalCenter: parent.verticalCenter
						anchors.left: parent.left
						width: 16 * scale_factor
						height: 16 * scale_factor
						icon_identifier: "trade_consulate"
						
						onReleased: {
							if (building_slot.can_decrease_production(production_type)) {
								building_slot.decrease_production(production_type)
								output_value = building_slot.get_production_type_employed_capacity(production_type)
							}
						}
					}
					
					IconButton {
						anchors.verticalCenter: parent.verticalCenter
						anchors.right: parent.right
						width: 16 * scale_factor
						height: 16 * scale_factor
						icon_identifier: "trade_consulate"
						
						onReleased: {
							if (building_slot.can_increase_production(production_type)) {
								building_slot.increase_production(production_type)
								output_value = building_slot.get_production_type_employed_capacity(production_type)
							}
						}
					}
				}
			}
		}
	}
	
	TextButton {
		id: ok_button
		anchors.top: production_types_column.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		text: "OK"
		onClicked: {
			factory_dialog.close()
		}
	}
}
