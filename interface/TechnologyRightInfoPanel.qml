import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
	id: infopanel
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
	
	IconButton {
		id: gathering_category_button
		anchors.top: parent.top
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		icon_identifier: "grain"
		border_color: technology_view.category === TechnologyView.Category.Gathering ? "white" : "gray"
		
		onReleased: {
			technology_view.category = TechnologyView.Category.Gathering
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "Gathering"
			} else {
				status_text = ""
			}
		}
	}
	
	IconButton {
		id: industry_category_button
		anchors.top: gathering_category_button.bottom
		anchors.topMargin: 4 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		icon_identifier: "tools"
		border_color: technology_view.category === TechnologyView.Category.Industry ? "white" : "gray"
		
		onReleased: {
			technology_view.category = TechnologyView.Category.Industry
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "Industry"
			} else {
				status_text = ""
			}
		}
	}
	
	IconButton {
		id: army_category_button
		anchors.top: industry_category_button.bottom
		anchors.topMargin: 4 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		icon_identifier: "crossed_sabers"
		border_color: technology_view.category === TechnologyView.Category.Army ? "white" : "gray"
		
		onReleased: {
			technology_view.category = TechnologyView.Category.Army
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "Army"
			} else {
				status_text = ""
			}
		}
	}
	
	IconButton {
		id: navy_category_button
		anchors.top: army_category_button.bottom
		anchors.topMargin: 4 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		icon_identifier: "anchor"
		border_color: technology_view.category === TechnologyView.Category.Navy ? "white" : "gray"
		
		onReleased: {
			technology_view.category = TechnologyView.Category.Navy
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "Navy"
			} else {
				status_text = ""
			}
		}
	}
	
	IconButton {
		id: finance_category_button
		anchors.top: navy_category_button.bottom
		anchors.topMargin: 4 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		icon_identifier: "wealth"
		border_color: technology_view.category === TechnologyView.Category.Finance ? "white" : "gray"
		
		onReleased: {
			technology_view.category = TechnologyView.Category.Finance
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "Finance"
			} else {
				status_text = ""
			}
		}
	}
	
	IconButton {
		id: no_category_button
		anchors.top: finance_category_button.bottom
		anchors.topMargin: 4 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		icon_identifier: "university"
		border_color: technology_view.category === TechnologyView.Category.None ? "white" : "gray"
		
		onReleased: {
			technology_view.category = TechnologyView.Category.None
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
		icon_identifier: "cog"
		border_color: technology_view.mode === TechnologyView.Mode.Researched ? "white" : "gray"
		
		onReleased: {
			technology_view.mode = TechnologyView.Mode.Researched
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
		border_color: technology_view.mode === TechnologyView.Mode.Available ? "white" : "gray"
		
		onReleased: {
			technology_view.mode = TechnologyView.Mode.Available
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
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		icon_identifier: "philosophy"
		border_color: technology_view.mode === TechnologyView.Mode.Future ? "white" : "gray"
		
		onReleased: {
			technology_view.mode = TechnologyView.Mode.Future
		}
		
		onHoveredChanged: {
			if (hovered) {
				status_text = "Future Technologies"
			} else {
				status_text = ""
			}
		}
	}
}