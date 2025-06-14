import QtQuick
import QtQuick.Controls
import "./dialogs"

Item {
	id: politics_view
	
	enum Mode {
		Advisors,
		Government,
		Traditions,
		Religion,
		ResearchOrganizations
	}
	
	property var country: null
	readonly property var country_game_data: country ? country.game_data : null
	readonly property var ruler: country_game_data ? country_game_data.ruler : null
	property var new_tradition: null
	property string status_text: ""
	property string middle_status_text: ""
	
	Rectangle {
		id: background
		anchors.top: top_bar.bottom
		anchors.bottom: status_bar.top
		anchors.left: infopanel.right
		anchors.right: button_panel.left
		color: "black"
	}
	
	AdvisorsView {
		id: advisors_view
		anchors.top: top_bar.bottom
		anchors.bottom: status_bar.top
		anchors.left: infopanel.right
		anchors.right: button_panel.left
		visible: politics_view_mode === PoliticsView.Mode.Advisors
	}
	
	GovernmentView {
		id: government_view
		anchors.top: top_bar.bottom
		anchors.bottom: status_bar.top
		anchors.left: infopanel.right
		anchors.right: button_panel.left
		visible: politics_view_mode === PoliticsView.Mode.Government
	}
	
	TraditionsView {
		id: traditions_view
		anchors.top: top_bar.bottom
		anchors.bottom: status_bar.top
		anchors.left: infopanel.right
		anchors.right: button_panel.left
		visible: politics_view_mode === PoliticsView.Mode.Traditions
	}
	
	ReligionView {
		id: religion_view
		anchors.top: top_bar.bottom
		anchors.bottom: status_bar.top
		anchors.left: infopanel.right
		anchors.right: button_panel.left
		visible: politics_view_mode === PoliticsView.Mode.Religion
	}
	
	ResearchOrganizationsView {
		id: research_organizations_view
		anchors.top: top_bar.bottom
		anchors.bottom: status_bar.top
		anchors.left: infopanel.right
		anchors.right: button_panel.left
		visible: politics_view_mode === PoliticsView.Mode.ResearchOrganizations
	}
	
	PoliticsButtonPanel {
		id: button_panel
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		anchors.right: parent.right
	}
	
	AdvisorsInfoPanel {
		id: infopanel
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		anchors.left: parent.left
		visible: politics_view_mode !== PoliticsView.Mode.Traditions
	}
	
	TraditionsInfoPanel {
		id: traditions_infopanel
		anchors.top: parent.top
		anchors.bottom: parent.bottom
		anchors.left: parent.left
		visible: politics_view_mode === PoliticsView.Mode.Traditions
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
}
