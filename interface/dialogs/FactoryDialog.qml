import QtQuick 2.12
import QtQuick.Controls 2.12
import ".."

DialogBase {
	id: factory_dialog
	title: building ? building.name : ""
	panel: 5
	width: production_types_column.width + 8 * scale_factor * 2
	height: ok_button.y + ok_button.height + 8 * scale_factor
	
	property var building_slot: null
	readonly property var building: building_slot ? building_slot.building : null
	readonly property int capacity: building_slot ? building_slot.capacity : 0
	
	SmallText {
		id: capacity_label
		anchors.top: title_item.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		text: "Capacity: " + capacity
	}
	
	Column {
		id: production_types_column
		anchors.top: capacity_label.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		spacing: 16 * scale_factor
		
		Repeater {
			model: building_slot ? building_slot.available_production_types : []
			
			Item {
				width: production_slider.width + 16 * scale_factor + production_formula_row.width
				height: production_formula_row.height
				
				readonly property var production_type: model.modelData
				readonly property var output_commodity: production_type.output_commodity
				property int employed_capacity: building_slot.get_production_type_employed_capacity(production_type)
				property int output_value: building_slot.get_production_type_output(production_type)
				
				Row {
					id: production_formula_row
					anchors.verticalCenter: parent.verticalCenter
					anchors.left: parent.left
					
					Repeater {
						model: production_type.input_commodities
						
						Row {
							readonly property var input_commodity: model.modelData.key
							readonly property int input_value: model.modelData.value
							
							Item {
								width: 32 * scale_factor
								height: 32 * scale_factor
								visible: index > 0
								
								NormalText {
									text: "+"
									anchors.verticalCenter: parent.verticalCenter
									anchors.horizontalCenter: parent.horizontalCenter
								}
							}
							
							Repeater {
								model: input_value
								
								Image {
									id: output_commodity_icon
									source: "image://icon/" + input_commodity.icon.identifier
								}
							}
						}
					}
					
					Item {
						width: 32 * scale_factor
						height: 32 * scale_factor
						
						NormalText {
							text: "→"
							anchors.verticalCenter: parent.verticalCenter
							anchors.horizontalCenter: parent.horizontalCenter
						}
					}
					
					Image {
						id: output_commodity_icon
						source: "image://icon/" + output_commodity.icon.identifier
					}
				}
				
				MouseArea {
					anchors.fill: production_formula_row
					hoverEnabled: true
					
					onEntered: {
						status_text = get_production_string(production_type)
					}
					
					onExited: {
						status_text = ""
					}
				}
				
				Item {
					id: production_slider
					anchors.verticalCenter: production_formula_row.verticalCenter
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
						color: "black"
						border.color: "gray"
						border.width: 1 * scale_factor
						
						Rectangle {
							anchors.top: parent.top
							anchors.topMargin: 1 * scale_factor
							anchors.bottom: parent.bottom
							anchors.bottomMargin: 1 * scale_factor
							anchors.left: parent.left
							anchors.leftMargin: 1 * scale_factor
							width: Math.floor((parent.width - 2 * scale_factor) * employed_capacity / capacity)
							color: "dimGray"
						}
						
						SmallText {
							id: output_label
							text: number_string(employed_capacity) + (output_value != employed_capacity ? (" (" + number_string(output_value) + ")") : "")
							anchors.verticalCenter: parent.verticalCenter
							anchors.horizontalCenter: parent.horizontalCenter
						}
						
						MouseArea {
							anchors.top: parent.top
							anchors.bottom: parent.bottom
							anchors.left: parent.left
							anchors.leftMargin: 8 * scale_factor
							anchors.right: parent.right
							anchors.rightMargin: 8 * scale_factor
		
							onClicked: {
								var current_employed_capacity = employed_capacity
								var target_employed_capacity = Math.round(mouse.x * capacity / width)
								
								if (target_employed_capacity > current_employed_capacity) {
									while (target_employed_capacity > current_employed_capacity) {
										if (!building_slot.can_increase_production(production_type)) {
											break
										}
										
										building_slot.increase_production(production_type)
										current_employed_capacity = building_slot.get_production_type_employed_capacity(production_type)
									}
								} else if (target_employed_capacity < current_employed_capacity) {
									while (target_employed_capacity < current_employed_capacity) {
										if (!building_slot.can_decrease_production(production_type)) {
											break
										}
										
										building_slot.decrease_production(production_type)
										current_employed_capacity = building_slot.get_production_type_employed_capacity(production_type)
									}
								} else {
									return
								}
								
								employed_capacity = current_employed_capacity
								output_value = building_slot.get_production_type_output(production_type)
							}
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
								employed_capacity = building_slot.get_production_type_employed_capacity(production_type)
								output_value = building_slot.get_production_type_output(production_type)
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
								employed_capacity = building_slot.get_production_type_employed_capacity(production_type)
								output_value = building_slot.get_production_type_output(production_type)
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
	
	function get_production_string(production_type) {
		var str = ""
		
		var input_commodities = production_type.input_commodities
		
		for (var kv_pair of input_commodities) {
			var commodity = kv_pair.key
			var quantity = kv_pair.value
			
			if (str.length > 0) {
				str += " + "
			}
			
			str += quantity + " " + commodity.name
		}
		
		str += " makes " + production_type.output_value + " " + production_type.output_commodity.name
		
		return str
	}
}
