import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
	id: technology_view
	
	enum Mode {
		Researched,
		Available,
		Future
	}
	
	property int mode: TechnologyView.Mode.Available
	
	IconButton {
		id: researched_mode_button
		anchors.top: parent.top
		anchors.topMargin: 16 * scale_factor
		anchors.right: parent.right
		anchors.rightMargin: 16 * scale_factor
		icon_identifier: "cog"
		tooltip: "Researched Technologies"
		
		onReleased: {
			technology_view.mode = TechnologyView.Mode.Researched
		}
	}
	
	IconButton {
		id: available_mode_button
		anchors.top: researched_mode_button.bottom
		anchors.right: researched_mode_button.right
		icon_identifier: "research"
		tooltip: "Available Technologies"
		
		onReleased: {
			technology_view.mode = TechnologyView.Mode.Available
		}
	}
	
	IconButton {
		id: future_mode_button
		anchors.top: available_mode_button.bottom
		anchors.right: researched_mode_button.right
		icon_identifier: "philosophy"
		tooltip: "Future Technologies"
		
		onReleased: {
			technology_view.mode = TechnologyView.Mode.Future
		}
	}
	
	ListView {
		id: technology_list
		anchors.left: parent.left
		anchors.leftMargin: 16 * scale_factor
		anchors.top: parent.top
		anchors.topMargin: 16 * scale_factor
		width: (64 / 2 + 256 + 1) * scale_factor
		height: Math.min(contentHeight, parent.height - y - (parent.height - back_button.y) - 16 * scale_factor)
		boundsBehavior: Flickable.StopAtBounds
		clip: true
		model: technology_view.mode === TechnologyView.Mode.Researched ? metternich.game.player_country.game_data.technologies : (
			technology_view.mode === TechnologyView.Mode.Available ? metternich.game.player_country.game_data.available_technologies : metternich.game.player_country.game_data.future_technologies
		)
		delegate: Item {
			width: portrait.width / 2 + technology_rectangle.width
			height: portrait.height
			
			readonly property var technology: model.modelData
			readonly property string technology_tooltip: portrait.tooltip
			
			Rectangle {
				id: technology_rectangle
				anchors.verticalCenter: parent.verticalCenter
				anchors.left: portrait.horizontalCenter
				width: 256 * scale_factor
				height: portrait.height
				color: "black"
				border.color: "gray"
				border.width: 1
				
				SmallText {
					id: technology_label
					text: technology.name
					anchors.verticalCenter: parent.verticalCenter
					anchors.left: parent.left
					anchors.leftMargin: 8 * scale_factor + portrait.width / 2
				}
			}
			
			MouseArea {
				anchors.fill: parent
				ToolTip.text: technology_tooltip
				ToolTip.visible: containsMouse
				ToolTip.delay: 1000
				hoverEnabled: true
			}
			
			IconButton {
				id: portrait
				icon_identifier: technology.icon.identifier
				tooltip: technology.name + ((modifier_string.length + enabled_buildings_string.length > 0 + enabled_improvements_string.length) > 0 ? format_text(small_text("\n"
					+ (modifier_string.length > 0 ? ("\n" + modifier_string) : "")
					+ (enabled_buildings_string.length > 0 ? ("\n" + enabled_buildings_string) : "")
					+ (enabled_improvements_string.length > 0 ? ("\n" + enabled_improvements_string) : "")
				)) : "")
				
				readonly property string modifier_string: technology.modifier_string
				readonly property var enabled_buildings: technology.get_enabled_buildings_for_culture(metternich.game.player_country.culture)
				readonly property string enabled_buildings_string: enabled_buildings.length > 0 ? string_list_to_string(object_list_to_name_list(enabled_buildings, "Enables "), "\n") : ""
				readonly property string enabled_improvements_string: technology.enabled_improvements.length > 0 ? string_list_to_string(object_list_to_name_list(technology.enabled_improvements, "Enables "), "\n") : ""
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
