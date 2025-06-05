import QtQuick
import QtQuick.Controls
import "./dialogs"

Item {
	id: technology_view
	
	enum Mode {
		Researched,
		Available,
		Future,
		ShowAll,
		TechTree
	}
	
	readonly property var country: metternich.game.player_country
	readonly property var country_game_data: country ? country.game_data : null
	property string status_text: ""
	property string middle_status_text: ""
	
	readonly property var technologies: technology_view_mode === TechnologyView.Mode.Researched ? country_game_data.technologies : (technology_view_mode === TechnologyView.Mode.Available ? country_game_data.researchable_technologies : (technology_view_mode === TechnologyView.Mode.Future ? country_game_data.future_technologies : country.available_technologies))
	readonly property var category_technologies: get_category_technologies(technologies, technology_view_category, technology_view_subcategory)
	
	ListView {
		id: technology_list
		anchors.top: top_bar.bottom
		anchors.bottom: status_bar.top
		anchors.left: infopanel.right
		anchors.right: button_panel.left
		boundsBehavior: Flickable.StopAtBounds
		clip: true
		model: category_technologies
		delegate: Item {
			width: technology_list.width
			height: technology_rectangle.height + entry_border.height
			
			readonly property var technology: model.modelData
			
			readonly property string effects_string: technology.get_effects_string(metternich.game.player_country)
			
			Image {
				id: portrait
				anchors.top: parent.top
				anchors.left: parent.left
				source: "image://portrait/" + technology.portrait.identifier
				fillMode: Image.Pad
				
				MouseArea {
					anchors.fill: parent
					
					onReleased: {
						if (technology_view_mode === TechnologyView.Mode.Available) {
							country_game_data.current_research = technology
						}
					}
				}
			}
			
			Rectangle {
				id: portrait_border
				color: "gray"
				anchors.left: portrait.right
				anchors.top: parent.top
				anchors.bottom: parent.bottom
				width: 1 * scale_factor
			}
			
			Rectangle {
				id: technology_rectangle
				anchors.top: parent.top
				anchors.left: portrait_border.right
				anchors.right: parent.right
				height: portrait.height
				color: "black"
				clip: true
				
				SmallText {
					id: technology_label
					text: technology.name
					anchors.verticalCenter: parent.verticalCenter
					anchors.left: parent.left
					anchors.leftMargin: 8 * scale_factor
					width: 192 * scale_factor
					wrapMode: Text.WordWrap
				}
				
				Column {
					id: technology_costs_column
					anchors.verticalCenter: parent.verticalCenter
					anchors.left: technology_label.right
					anchors.right: technology_effects_label.left
					spacing: 4 * scale_factor
					visible: technology_view_mode === TechnologyView.Mode.Available
					
					Row {
						id: commodity_costs_row
						spacing: 8 * scale_factor
						
						SmallText {
							id: wealth_cost_label
							anchors.verticalCenter: commodity_costs_row.verticalCenter
							text: "$" + number_string(technology.get_wealth_cost_for_country(country))
						}
						
						Repeater {
							model: technology.get_commodity_costs_for_country_qvariant_list(country)
							
							Row {
								spacing: 4 * scale_factor
								
								readonly property var commodity: model.modelData.key
								readonly property var commodity_cost: model.modelData.value
								
								Image {
									id: commodity_icon
									source: "image://icon/" + commodity.icon.identifier
								}
								
								SmallText {
									id: cost_label
									text: number_string(commodity_cost)
									anchors.verticalCenter: commodity_icon.verticalCenter
								}
							}
						}
					}
				}
				
				SmallText {
					id: technology_effects_label
					text: format_text(effects_string)
					anchors.verticalCenter: parent.verticalCenter
					anchors.right: parent.right
					anchors.rightMargin: 8 * scale_factor
					width: 288 * scale_factor
				}
			}
			
			Rectangle {
				id: entry_border
				color: "gray"
				anchors.top: technology_rectangle.bottom
				anchors.left: parent.left
				anchors.right: parent.right
				height: 1 * scale_factor
			}
		}
	}
	
	Rectangle {
		id: tech_tree_background
		anchors.fill: tech_tree
		color: "black"
		visible: tech_tree.visible
	}
	
	PortraitButtonTree {
		id: tech_tree
		anchors.top: top_bar.bottom
		anchors.bottom: status_bar.top
		anchors.left: infopanel.right
		anchors.right: button_panel.left
		entries: country.available_technologies
		visible: technology_view_mode === TechnologyView.Mode.TechTree
		delegate: TreePortraitButton {
			border_color: country_game_data.current_research === technology ? "white" : (country_game_data.has_technology(technology) ? Qt.rgba(64.0 / 255.0, 64.0 / 255.0, 64.0 / 255.0, 1) : "gray")
			
			readonly property var technology: model.modelData
			
			onClicked: {
				technology_dialog.technology = technology
				technology_dialog.open()
			}
		}
	}
	
	TechnologyButtonPanel {
		id: button_panel
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		anchors.right: parent.right
	}
	
	TechnologyInfoPanel {
		id: infopanel
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		anchors.left: parent.left
	}
	
	StatusBar {
		id: status_bar
		anchors.bottom: parent.bottom
		anchors.left: infopanel.right
		anchors.right: button_panel.left
	}
	
	TopBar {
		id: top_bar
		anchors.top: parent.top
		anchors.left: infopanel.right
		anchors.right: button_panel.left
	}
	
	TechnologyDialog {
		id: technology_dialog
	}
	
	function get_category_technologies(technologies, category, subcategory) {
		if (category === null) {
			return technologies
		}
		
		var category_technologies = []
		
		for (var technology of technologies) {
			if (technology.category === category && (subcategory === null || technology.subcategory === subcategory)) {
				category_technologies.push(technology)
			}
		}
		
		return category_technologies
	}
}
