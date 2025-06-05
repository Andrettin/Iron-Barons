import QtQuick
import QtQuick.Controls

Rectangle {
	id: infopanel
	color: interface_background_color
	width: 64 * scale_factor + 8 * scale_factor * 2
	
	Rectangle {
		color: "gray"
		anchors.top: parent.top
		anchors.topMargin: 15 * scale_factor
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 15 * scale_factor
		anchors.right: parent.right
		width: 1 * scale_factor
	}
	
	IndustryCounter {
		id: research_counter
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: parent.top
		anchors.topMargin: 16 * scale_factor
		name: metternich.defines.research_commodity.name
		icon_identifier: metternich.defines.research_commodity.icon.identifier
		count: country_game_data.get_stored_commodity(metternich.defines.research_commodity)
		visible: current_research_portrait.visible
	}
	
	SmallText {
		id: research_cost_label
		text: "(" + number_string(country_game_data.current_research ? country_game_data.current_research.get_cost_for_country(country) : 0) + ")"
		anchors.top: research_counter.bottom
		anchors.topMargin: 4 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		visible: current_research_portrait.visible
		
		MouseArea {
			anchors.fill: parent
			hoverEnabled: true
			
			onEntered: {
				status_text = "Research required to discover the technology"
			}
			
			onExited: {
				status_text = ""
			}
		}
	}
	
	SmallText {
		id: current_research_label
		text: "Current Research"
		anchors.top: research_cost_label.bottom
		anchors.topMargin: 32 * scale_factor
		anchors.left: parent.left
		anchors.leftMargin: 4 * scale_factor * 2
		anchors.right: parent.right
		anchors.rightMargin: 4 * scale_factor * 2
		visible: current_research_portrait.visible
		wrapMode: Text.WordWrap
		horizontalAlignment: Text.AlignHCenter
	}
	
	PortraitButton {
		id: current_research_portrait
		anchors.top: current_research_label.bottom
		anchors.topMargin: 8 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		portrait_identifier: country_game_data.current_research ? country_game_data.current_research.portrait.identifier : ""
		visible: country_game_data.current_research !== null
		radius: 0
		
		onHoveredChanged: {
			if (hovered && country_game_data.current_research) {
				status_text = country_game_data.current_research.name
			} else {
				status_text = ""
			}
		}
	}
	
	IconButton {
		id: researched_mode_button
		anchors.top: current_research_portrait.visible ? current_research_portrait.bottom : parent.top
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		icon_identifier: "architecture"
		border_color: technology_view_mode === TechnologyView.Mode.Researched ? "white" : "gray"
		
		onReleased: {
			technology_view_mode = TechnologyView.Mode.Researched
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "Researched Technologies"
			} else {
				status_text = ""
			}
		}
	}
	
	IconButton {
		id: available_mode_button
		anchors.top: researched_mode_button.bottom
		anchors.topMargin: 4 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		icon_identifier: "research"
		border_color: technology_view_mode === TechnologyView.Mode.Available ? "white" : "gray"
		
		onReleased: {
			technology_view_mode = TechnologyView.Mode.Available
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "Available Technologies"
			} else {
				status_text = ""
			}
		}
	}
	
	IconButton {
		id: future_mode_button
		anchors.top: available_mode_button.bottom
		anchors.topMargin: 4 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		icon_identifier: "philosophy"
		border_color: technology_view_mode === TechnologyView.Mode.Future ? "white" : "gray"
		
		onReleased: {
			technology_view_mode = TechnologyView.Mode.Future
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "Future Technologies"
			} else {
				status_text = ""
			}
		}
	}
	
	IconButton {
		id: show_all_mode_button
		anchors.top: future_mode_button.bottom
		anchors.topMargin: 4 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		icon_identifier: "university"
		border_color: technology_view_mode === TechnologyView.Mode.ShowAll ? "white" : "gray"
		
		onReleased: {
			technology_view_mode = TechnologyView.Mode.ShowAll
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "Show All"
			} else {
				status_text = ""
			}
		}
	}
	
	IconButton {
		id: tech_tree_mode_button
		anchors.top: show_all_mode_button.bottom
		anchors.topMargin: 4 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		icon_identifier: "cog"
		border_color: technology_view_mode === TechnologyView.Mode.TechTree ? "white" : "gray"
		
		onReleased: {
			technology_view_mode = TechnologyView.Mode.TechTree
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "Technology Tree"
			} else {
				status_text = ""
			}
		}
	}
	
	TextButton {
		id: back_button
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 16 * scale_factor
		text: qsTr("Back")
		width: 48 * scale_factor
		height: 24 * scale_factor
		
		onClicked: {
			menu_stack.pop()
		}
	}
}
