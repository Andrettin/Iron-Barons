import QtQuick
import QtQuick.Controls
import "./dialogs"

Item {
	id: religion_view
	
	readonly property var deity_slots: country_game_data.available_deity_slots
	
	SmallText {
		id: religion_label
		text: "Religion"
		anchors.top: parent.top
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
	}
	
	CustomIconImage {
		id: religion_icon
		anchors.top: religion_label.bottom
		anchors.topMargin: 8 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		icon_identifier: country_game_data.religion.icon.identifier
		name: country_game_data.religion.name
	}
	
	PortraitGrid {
		id: deity_portrait_grid
		anchors.top: government_type_icon.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		entries: deity_slots
		delegate: PortraitGridItem {
			portrait_identifier: appointed_deity ? appointed_deity.portrait.identifier + "/grayscale" : (deity ? deity.portrait.identifier : "no_character")
			
			readonly property var deity_slot: model.modelData
			readonly property var deity: country_game_data.deities.length > 0 ? country_game_data.get_deity(deity_slot) : null //the check here is for the sake of property binding
			readonly property var appointed_deity: country_game_data.appointed_deities.length > 0 ? country_game_data.get_appointed_deity(deity_slot) : null //the check here is for the sake of property binding
			
			onClicked: {
				if (deity !== null || appointed_deity !== null) {
					deity_dialog.deity_slot = deity_slot
					deity_dialog.deity = appointed_deity ? appointed_deity : deity
					deity_dialog.open()
				} else {
					deity_choice_dialog.deity_slot = deity_slot
					deity_choice_dialog.open()
				}
			}
			
			onEntered: {
				status_text = appointed_deity ? "Appointing " + appointed_deity.get_cultural_name_qstring(country.culture) : (deity ? deity.get_cultural_name_qstring(country.culture) : deity_slot.name + " Slot")
			}
			
			onExited: {
				status_text = ""
			}
		}
	}
	
	DeityDialog {
		id: deity_dialog
	}
	
	DeityChoiceDialog {
		id: deity_choice_dialog
	}
}
