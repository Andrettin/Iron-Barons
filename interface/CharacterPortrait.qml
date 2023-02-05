import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

PortraitButton {
	id: portrait
	portrait_identifier: character ? character.portrait.identifier : "no_character"
	tooltip: character ? (character.full_name + format_text(small_text("\n"
		+ (character_landed_titles_tooltip.length > 0 ? ("\n" + character_landed_titles_tooltip) : "")
		+ (character.game_data.office ? ("\n" + character.game_data.office.name) : "")
		+ (character.dynasty ? ("\nDynasty: " + character.dynasty.name) : "")
		+ "\nCulture: " + character.culture.name
		+ "\nReligion: " + character.religion.name
		+ "\nPrimary Attribute: " + character.type.primary_attribute_name
		+ (character.game_data.diplomacy > 0 ? ("\nDiplomacy: " + character.game_data.diplomacy) : "")
		+ (character.game_data.martial > 0 ? ("\nMartial: " + character.game_data.martial) : "")
		+ (character.game_data.stewardship > 0 ? ("\nStewardship: " + character.game_data.stewardship) : "")
		+ (character.game_data.intrigue > 0 ? ("\nIntrigue: " + character.game_data.intrigue) : "")
		+ (character.game_data.learning > 0 ? ("\nLearning: " + character.game_data.learning) : "")
		+ (character.game_data.wealth !== 0 ? ("\nWealth: " + number_string(character.game_data.wealth)) : "")
		+ (character.game_data.prestige !== 0 ? ("\nPrestige: " + number_string(character.game_data.prestige)) : "")
		+ (character.game_data.piety !== 0 ? ("\nPiety: " + number_string(character.game_data.piety)) : "")
		+ (((character.game_data.ruler || character.game_data.office) && country_modifier_tooltip.length > 0) ? "\n\nCountry Modifier:\n" + country_modifier_tooltip : "")
	))) : ""
	
	property var character: null
	readonly property string character_landed_titles_tooltip: character ? string_list_to_string(get_character_landed_titles_tooltip(character.game_data.landed_titles), "\n") : ""
	readonly property string country_modifier_tooltip: character ? character.game_data.get_country_modifier_string(0) : ""
	
	function get_character_landed_titles_tooltip(landed_titles) {
		var str_list = []
		
		for (var landed_title of landed_titles) {
			str_list.push(landed_title.game_data.ruler_title_name + " of " + landed_title.name)
		}
		
		return str_list
	}
}
