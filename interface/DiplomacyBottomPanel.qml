import QtQuick
import QtQuick.Controls

Rectangle {
	id: bottom_panel
	color: interface_background_color
	height: 192 * scale_factor
	
	readonly property var selected_country_ruler: selected_country_game_data ? selected_country_game_data.ruler : null
	
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
	
	IconButton {
		id: cultural_map_mode_button
		anchors.top: terrain_map_mode_button.bottom
		anchors.topMargin: 4 * scale_factor
		anchors.right: political_map_mode_button.right
		icon_identifier: "music"
		border_color: diplomatic_map.mode === DiplomaticMap.Mode.Cultural ? "white" : "gray"
		tooltip: "Cultural Map"
		
		onReleased: {
			diplomatic_map.mode = DiplomaticMap.Mode.Cultural
		}
	}
	
	IconButton {
		id: religious_map_mode_button
		anchors.top: cultural_map_mode_button.top
		anchors.right: cultural_map_mode_button.left
		anchors.rightMargin: 4 * scale_factor
		icon_identifier: "wooden_cross"
		border_color: diplomatic_map.mode === DiplomaticMap.Mode.Religious ? "white" : "gray"
		tooltip: "Religious Map"
		
		onReleased: {
			diplomatic_map.mode = DiplomaticMap.Mode.Religious
		}
	}
	
	SmallText {
		id: country_text
		text: format_text(selected_country && selected_country_game_data ? (
			selected_country_game_data.name
			+ "\n"
			+ "\n" + selected_country_game_data.type_name
			+ (selected_country_game_data.overlord ? (
				"\n" + selected_country_game_data.vassalage_type_name + " of " + selected_country_game_data.overlord.name
			) : "")
			+ "\n" + selected_country_game_data.title_name
			+ (selected_country_game_data.anarchy ? "\nAnarchy" : "")
			+ (selected_country.great_power && !selected_country_game_data.anarchy ? ("\nScore: " + number_string(selected_country_game_data.score) + " (#" + (selected_country_game_data.rank + 1) + ")") : "")
			+ "\nPopulation: " + number_string(selected_country_game_data.population.size)
			+ "\nPopulation Growth: " + selected_country_game_data.population_growth + "/" + metternich.defines.population_growth_threshold
			+ "\n" + selected_country_game_data.provinces.length + " " + (selected_country_game_data.provinces.length > 1 ? "Provinces" : "Province")
		) : "")
		anchors.left: bottom_panel.left
		anchors.leftMargin: 16 * scale_factor
		anchors.top: bottom_panel.top
		anchors.topMargin: 16 * scale_factor
	}
	
	SmallText {
		id: ruler_label
		anchors.top: population_type_chart_label.top
		anchors.horizontalCenter: ruler_portrait.horizontalCenter
		text: "Ruler"
		visible: ruler_portrait.visible
	}
	
	PortraitButton {
		id: ruler_portrait
		anchors.top: population_type_chart.top
		anchors.topMargin: 8 * scale_factor
		anchors.right: population_type_chart.left
		anchors.rightMargin: 32 * scale_factor
		portrait_identifier: selected_country_ruler && selected_country_ruler.game_data.portrait ? selected_country_ruler.game_data.portrait.identifier : ""
		visible: selected_country_ruler !== null
		tooltip: selected_country_ruler ? (selected_country.game_data.ruler_title_name + " " + selected_country_ruler.full_name) : ""
		circle: true
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
		data_source: selected_country_game_data ? selected_country_game_data.population : null
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
		data_source: selected_country_game_data ? selected_country_game_data.population : null
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
		anchors.right: ideology_chart.left
		anchors.rightMargin: 16 * scale_factor
		visible: selected_country !== null
		data_source: selected_country_game_data ? selected_country_game_data.population : null
	}
	
	SmallText {
		id: ideology_chart_label
		anchors.top: country_text.top
		anchors.horizontalCenter: ideology_chart.horizontalCenter
		text: "Ideology"
		visible: ideology_chart.visible
	}
	
	IdeologyChart {
		id: ideology_chart
		anchors.top: population_type_chart.top
		anchors.right: religious_map_mode_button.left
		anchors.rightMargin: 16 * scale_factor
		visible: selected_country !== null
		data_source: selected_country_game_data ? selected_country_game_data.population : null
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
