import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
	id: bottom_panel
	color: interface_background_color
	height: 192 * scale_factor
	
	Rectangle {
		color: "gray"
		anchors.left: parent.left
		anchors.leftMargin: 15 * scale_factor
		anchors.right: parent.right
		anchors.rightMargin: 15 * scale_factor
		anchors.top: parent.top
		height: 1 * scale_factor
	}
	
	IconButton {
		id: political_map_mode_button
		anchors.top: parent.top
		anchors.topMargin: 8 * scale_factor
		anchors.right: parent.right
		anchors.rightMargin: 8 * scale_factor
		icon_identifier: "flag"
		border_color: diplomatic_map.mode === DiplomaticMap.Mode.Political ? "white" : "gray"
		tooltip: "Political Map"
		
		onReleased: {
			diplomatic_map.mode = DiplomaticMap.Mode.Political
		}
	}
	
	IconButton {
		id: diplomatic_map_mode_button
		anchors.top: political_map_mode_button.bottom
		anchors.topMargin: 4 * scale_factor
		anchors.right: political_map_mode_button.right
		icon_identifier: "treaty"
		border_color: diplomatic_map.mode === DiplomaticMap.Mode.Treaty ? "white" : "gray"
		tooltip: "Treaty Map"
		
		onReleased: {
			diplomatic_map.mode = DiplomaticMap.Mode.Treaty
		}
	}
	
	IconButton {
		id: terrain_map_mode_button
		anchors.top: diplomatic_map_mode_button.bottom
		anchors.topMargin: 4 * scale_factor
		anchors.right: political_map_mode_button.right
		icon_identifier: "mountains"
		border_color: diplomatic_map.mode === DiplomaticMap.Mode.Terrain ? "white" : "gray"
		tooltip: "Terrain Map"
		
		onReleased: {
			diplomatic_map.mode = DiplomaticMap.Mode.Terrain
		}
	}
	
	SmallText {
		id: country_text
		text: format_text(selected_country ? (
			selected_country.name
			+ "\n"
			+ "\n" + selected_country.game_data.type_name
			+ (selected_country.game_data.overlord ? (
				"\n" + selected_country.game_data.vassalage_type_name + " of " + selected_country.game_data.overlord.name
			) : "")
			+ (selected_country.game_data.anarchy ? "\nAnarchy" : "")
			+ (selected_country.great_power ? ("\nScore: " + number_string(selected_country.game_data.score) + " (#" + (selected_country.game_data.rank + 1) + ")") : "")
			+ "\nPopulation: " + number_string(selected_country.game_data.population)
			+ "\nPopulation Growth: " + selected_country.game_data.population_growth + "/" + metternich.defines.population_growth_threshold
			+ "\n" + selected_country.game_data.provinces.length + " " + (selected_country.game_data.provinces.length > 1 ? "Provinces" : "Province")
		) : "")
		anchors.left: bottom_panel.left
		anchors.leftMargin: 16 * scale_factor
		anchors.top: bottom_panel.top
		anchors.topMargin: 16 * scale_factor
	}
	
	SmallText {
		id: population_type_chart_label
		anchors.top: country_text.top
		anchors.horizontalCenter: population_type_chart.horizontalCenter
		text: "Population Type"
		visible: population_type_chart.visible
	}
	
	PopulationTypeChart {
		id: population_type_chart
		anchors.top: culture_chart.top
		anchors.right: culture_chart.left
		anchors.rightMargin: 16 * scale_factor
		visible: selected_country !== null
		data_source: selected_country ? selected_country.game_data : null
	}
	
	SmallText {
		id: culture_chart_label
		anchors.top: country_text.top
		anchors.horizontalCenter: culture_chart.horizontalCenter
		text: "Culture"
		visible: culture_chart.visible
	}
	
	CultureChart {
		id: culture_chart
		anchors.top: culture_chart_label.bottom
		anchors.topMargin: 4 * scale_factor
		anchors.right: religion_chart.left
		anchors.rightMargin: 16 * scale_factor
		visible: selected_country !== null
		data_source: selected_country ? selected_country.game_data : null
	}
	
	SmallText {
		id: religion_chart_label
		anchors.top: country_text.top
		anchors.horizontalCenter: religion_chart.horizontalCenter
		text: "Religion"
		visible: religion_chart.visible
	}
	
	ReligionChart {
		id: religion_chart
		anchors.top: population_type_chart.top
		anchors.right: phenotype_chart.left
		anchors.rightMargin: 16 * scale_factor
		visible: selected_country !== null
		data_source: selected_country ? selected_country.game_data : null
	}
	
	SmallText {
		id: phenotype_chart_label
		anchors.top: country_text.top
		anchors.horizontalCenter: phenotype_chart.horizontalCenter
		text: "Phenotype"
		visible: phenotype_chart.visible
	}
	
	PhenotypeChart {
		id: phenotype_chart
		anchors.top: population_type_chart.top
		anchors.right: political_map_mode_button.left
		anchors.rightMargin: 16 * scale_factor
		visible: selected_country !== null
		data_source: selected_country ? selected_country.game_data : null
	}
	
	Row {
		id: diplomatic_actions_row
		anchors.top: parent.top
		anchors.topMargin: 8 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		spacing: 8 * scale_factor
		visible: diplomatic_map.mode === DiplomaticMap.Mode.Treaty && selected_country === null
		
		IconButton {
			id: offer_peace_button
			icon_identifier: "philosophy"
			tooltip: "Offer Peace"
			
			onReleased: {
			}
		}
		
		IconButton {
			id: declare_war_button
			icon_identifier: "crossed_sabers"
			tooltip: "Declare War"
			
			onReleased: {
			}
		}
	}
	
	Row {
		id: alliances_row
		anchors.top: diplomatic_actions_row.bottom
		anchors.topMargin: 8 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		spacing: 8 * scale_factor
		visible: diplomatic_actions_row.visible
		
		IconButton {
			id: offer_pact_button
			icon_identifier: "wall"
			tooltip: "Offer Non-Aggression Pact"
			
			onReleased: {
			}
		}
		
		IconButton {
			id: offer_alliance_button
			icon_identifier: "flag"
			tooltip: "Offer Alliance"
			
			onReleased: {
			}
		}
		
		IconButton {
			id: join_empire_button
			icon_identifier: "crown_imperial"
			tooltip: "Invite to Join Empire"
			
			onReleased: {
			}
		}
	}
	
	Row {
		id: consulates_row
		anchors.top: alliances_row.bottom
		anchors.topMargin: 8 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		spacing: 8 * scale_factor
		visible: diplomatic_actions_row.visible
		
		IconButton {
			id: build_trade_consulate_button
			icon_identifier: "wealth"
			tooltip: "Build a Trade Consulate"
			
			onReleased: {
			}
		}
		
		IconButton {
			id: build_embassy_button
			icon_identifier: "treaty"
			tooltip: "Build an Embassy"
			
			onReleased: {
			}
		}
	}
	
	TextButton {
		id: back_button
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 8 * scale_factor
		text: qsTr("Back")
		width: 64 * scale_factor
		height: 24 * scale_factor
		
		onClicked: {
			menu_stack.pop()
		}
	}
}