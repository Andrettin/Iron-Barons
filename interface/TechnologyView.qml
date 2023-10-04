import QtQuick
import QtQuick.Controls
import "./dialogs"

Item {
	id: technology_view
	
	enum Mode {
		Researched,
		Available,
		Future,
		TechTree
	}
	
	enum Category {
		None,
		Gathering,
		Industry,
		Army,
		Navy,
		Finance,
		Culture
	}
	
	property int mode: TechnologyView.Mode.Available
	property int category: TechnologyView.Category.None
	readonly property var country: metternich.game.player_country
	readonly property var country_game_data: country ? country.game_data : null
	property string status_text: ""
	property string middle_status_text: ""
	
	readonly property var technologies: technology_view.mode === TechnologyView.Mode.Researched ? country_game_data.technologies : (technology_view.mode === TechnologyView.Mode.Available ? country_game_data.available_technologies : country_game_data.future_technologies)
	readonly property var category_technologies: get_category_technologies(technologies, category)
	
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
						if (technology_view.mode === TechnologyView.Mode.Available) {
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
					width: 256 * scale_factor
					wrapMode: Text.WordWrap
				}
				
				Item {
					anchors.top: parent.top
					anchors.bottom: parent.bottom
					anchors.left: technology_label.right
					anchors.right: technology_effects_label.left
					visible: technology_view.mode === TechnologyView.Mode.Available
					
					Image {
						id: research_cost_icon
						anchors.verticalCenter: parent.verticalCenter
						anchors.right: parent.horizontalCenter
						anchors.rightMargin: 32 * scale_factor
						source: "image://icon/" + metternich.defines.research_commodity.icon.identifier
					}
					
					SmallText {
						id: research_cost_label
						text: number_string(Math.floor(technology.cost * country_game_data.research_cost_modifier / 100))
						anchors.left: research_cost_icon.right
						anchors.leftMargin: 4 * scale_factor
						anchors.verticalCenter: research_cost_icon.verticalCenter
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
		entries: metternich.get_technologies()
		visible: technology_view.mode === TechnologyView.Mode.TechTree
		delegate: TreePortraitButton {
			border_color: country_game_data.current_research === technology ? "white" : (country_game_data.has_technology(technology) ? Qt.rgba(64.0 / 255.0, 64.0 / 255.0, 64.0 / 255.0, 1) : "gray")
			
			readonly property var technology: model.modelData
			
			onClicked: {
				technology_dialog.title = technology.name
				technology_dialog.modifier_string = technology.get_effects_string(metternich.game.player_country)
				technology_dialog.description = technology.description
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
	
	ModifierDialog {
		id: technology_dialog
	}
	
	function get_category_technologies(technologies, category) {
		if (category === TechnologyView.Category.None) {
			return technologies
		}
		
		var category_technologies = []
		
		for (var technology of technologies) {
			if (technology.category_index === category) {
				category_technologies.push(technology)
			}
		}
		
		return category_technologies
	}
}
