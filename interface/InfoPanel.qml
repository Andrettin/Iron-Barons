import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
	id: infopanel
	width: infopanel_image.width
	
	readonly property var end_turn_button: end_turn_button_internal
	
	Image {
		id: infopanel_image
		anchors.top: parent.top
		anchors.left: parent.left
		source: "image://interface/" + interface_style + "/infopanel"
		fillMode: Image.PreserveAspectCrop
	}
	
	IconButton {
		id: capital_settlement_button
		anchors.top: parent.top
		anchors.topMargin: 8 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		icon_identifier: "settlement"
		
		onReleased: {
			menu_stack.push("SettlementView.qml", {
				settlement: metternich.game.player_country.capital_province.capital_settlement,
				interface_style: map_view.interface_style
			})
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "View Capital Settlement"
			} else {
				status_text = ""
			}
		}
	}
	
	IconButton {
		id: diplomatic_map_button
		anchors.top: capital_settlement_button.top
		anchors.left: capital_settlement_button.right
		anchors.leftMargin: 8 * scale_factor
		icon_identifier: "globe"
		
		onReleased: {
			menu_stack.push("DiplomaticMapView.qml", {
				start_tile_x: map_area_start_x + map_area_tile_width / 2,
				start_tile_y: map_area_start_y + map_area_tile_height / 2
			})
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "View Diplomatic Map"
			} else {
				status_text = ""
			}
		}
	}
	
	NormalText {
		id: title
		anchors.top: capital_settlement_button.bottom
		anchors.topMargin: 8 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		text: selected_site ? (selected_site.game_data.current_cultural_name) : (selected_civilian_unit ? selected_civilian_unit.type.name : "")
	}
	
	Image {
		id: icon
		anchors.top: title.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		source: icon_identifier.length > 0 ? ("image://icon/" + icon_identifier) : "image://empty/"
		
		readonly property string icon_identifier: selected_civilian_unit ? selected_civilian_unit.icon.identifier : (
			selected_site ? (
				selected_site.settlement ? "settlement" : (
					selected_site.resource.icon ? selected_site.resource.icon.identifier : selected_site.resource.commodity.icon.identifier
				)
			) : ""
		)
		
		MouseArea {
			anchors.fill: parent
			hoverEnabled: true
			
			onEntered: {
				status_text = title.text
				if (subtitle.text.length > 0) {
					status_text += " (" + subtitle.text + ")"
				}
			}
			
			onExited: {
				status_text = ""
			}
		}
	}
	
	SmallText {
		id: subtitle
		anchors.top: icon.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		text: selected_site ? (
			selected_site.settlement ? "Settlement" : (
				selected_site.game_data.improvement ? selected_site.game_data.improvement.name : (
					selected_site.resource ? selected_site.resource.name : ""
				)
			)
		) : ""
	}
	
	PopulationTypeChart {
		id: population_type_chart
		anchors.top: culture_chart.top
		anchors.right: culture_chart.left
		anchors.rightMargin: 8 * scale_factor
		width: 48 * scale_factor
		height: 48 * scale_factor
		visible: selected_site && selected_site.settlement
		data_source: selected_site && selected_site.settlement ? selected_site.game_data.province.game_data : null
	}
	
	CultureChart {
		id: culture_chart
		anchors.top: subtitle.bottom
		anchors.topMargin: 8 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		width: 48 * scale_factor
		height: 48 * scale_factor
		visible: selected_site && selected_site.settlement
		data_source: selected_site && selected_site.settlement ? selected_site.game_data.province.game_data : null
	}
	
	SmallText {
		id: info_text
		anchors.top: culture_chart.bottom
		anchors.topMargin: 8 * scale_factor
		anchors.left: parent.left
		anchors.leftMargin: 16 * scale_factor
		text: province_game_data ? (
			"Population: " + number_string(province_game_data.population)
			+ "\n\nPopulation Growth: " + province_game_data.population_growth + "/" + metternich.defines.population_growth_threshold
		) : ""
		visible: selected_site && selected_site.settlement
		
		readonly property var province_game_data: (selected_site && selected_site.settlement) ? selected_site.game_data.province.game_data : null
	}
	
	TextButton {
		id: settlement_button
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: end_turn_button_internal.top
		anchors.bottomMargin: 8 * scale_factor
		text: qsTr("Settlement")
		width: 64 * scale_factor
		height: 24 * scale_factor
		visible: selected_site !== null && selected_site.settlement
		
		onClicked: {
			menu_stack.push("SettlementView.qml", {
				settlement: selected_site,
				interface_style: map_view.interface_style
			})
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "View Settlement"
			} else {
				status_text = ""
			}
		}
	}
	
	TextButton {
		id: disband_button
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: end_turn_button_internal.top
		anchors.bottomMargin: 8 * scale_factor
		text: qsTr("Disband")
		width: 64 * scale_factor
		height: 24 * scale_factor
		visible: selected_civilian_unit !== null
		
		onClicked: {
			selected_civilian_unit.disband()
			selected_civilian_unit = null
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "Disband Civilian Unit"
			} else {
				status_text = ""
			}
		}
	}
	
	TextButton {
		id: end_turn_button_internal
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 8 * scale_factor
		text: qsTr("End Turn")
		width: 64 * scale_factor
		height: 24 * scale_factor
		
		onClicked: {
			metternich.game.do_turn_async()
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "End Turn"
			} else {
				status_text = ""
			}
		}
	}
}
