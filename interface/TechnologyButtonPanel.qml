import QtQuick
import QtQuick.Controls

Rectangle {
	id: button_panel
	color: interface_background_color
	width: 64 * scale_factor
	
	Rectangle {
		color: "gray"
		anchors.top: parent.top
		anchors.topMargin: 15 * scale_factor
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 15 * scale_factor
		anchors.left: parent.left
		width: 1 * scale_factor
	}
	
	Column {
		id: category_button_column
		anchors.top: parent.top
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		spacing: 4 * scale_factor
		
		Repeater {
			model: metternich.get_technology_categories()
			
			IconButton {
				id: category_button
				icon_identifier: "grain"
				border_color: technology_view_category === button_category ? "white" : "gray"
				visible: technology_view_mode !== TechnologyView.Mode.TechTree
						
				readonly property var button_category: model.modelData
				
				onReleased: {
					technology_view_category = button_category
				}
				
				onHoveredChanged: {
					if (hovered) {
						status_text = button_category.name
					} else {
						status_text = ""
					}
				}
			}
		}
	}
	
	IconButton {
		id: no_category_button
		anchors.top: category_button_column.bottom
		anchors.topMargin: 4 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		icon_identifier: "university"
		border_color: technology_view_category === null ? "white" : "gray"
		visible: technology_view_mode !== TechnologyView.Mode.TechTree
		
		onReleased: {
			technology_view_category = null
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
		id: researched_mode_button
		anchors.bottom: available_mode_button.top
		anchors.bottomMargin: 4 * scale_factor
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
		anchors.bottom: future_mode_button.top
		anchors.bottomMargin: 4 * scale_factor
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
		anchors.bottom: tech_tree_mode_button.top
		anchors.bottomMargin: 4 * scale_factor
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
		id: tech_tree_mode_button
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 16 * scale_factor
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
}
