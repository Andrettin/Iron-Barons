import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

PortraitButton {
	id: portrait
	portrait_identifier: character.portrait.identifier
	tooltip: character.full_name + format_text(small_text("\n"
		+ (character_landed_titles_tooltip.length > 0 ? ("\n" + character_landed_titles_tooltip) : "")
		+ (character.game_data.office ? ("\n" + character.game_data.office.name) : "")
		+ "\nCulture: " + character.culture.name
		+ "\nReligion: " + character.religion.name
		+ "\nSkill: " + character.game_data.skill
		+ (character.game_data.ruler ? "\nCountry Modifier:\n" + character.game_data.country_modifier_string : "")
	))
	
	property var character: null
	readonly property string character_landed_titles_tooltip: string_list_to_string(get_character_landed_titles_tooltip(character.game_data.landed_titles), "\n")
	
	function get_character_landed_titles_tooltip(landed_titles) {
		var str_list = []
		
		for (var landed_title of landed_titles) {
			str_list.push(landed_title.game_data.ruler_title_name + " of " + landed_title.name)
		}
		
		return str_list
	}
}
