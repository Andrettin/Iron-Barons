import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

PortraitButton {
	id: portrait
	portrait_identifier: character ? character.game_data.portrait.identifier : "no_character"
	circle: true
	tooltip: character ? (character.full_name + format_text(small_text("\n"
		+ (character.dynasty ? ("\nDynasty: " + character.dynasty.name) : "")
		+ "\nCulture: " + character.culture.name
		+ "\nReligion: " + character.religion.name
		+ (character.game_data.spouse ? ("\nSpouse: " + character.game_data.spouse.full_name) : "")
		+ "\nPrimary Attribute: " + character.type.primary_attribute_name
		+ (character.game_data.diplomacy > 0 ? ("\nDiplomacy: " + character.game_data.diplomacy) : "")
		+ (character.game_data.martial > 0 ? ("\nMartial: " + character.game_data.martial) : "")
		+ (character.game_data.stewardship > 0 ? ("\nStewardship: " + character.game_data.stewardship) : "")
		+ (character.game_data.intrigue > 0 ? ("\nIntrigue: " + character.game_data.intrigue) : "")
		+ (character.game_data.learning > 0 ? ("\nLearning: " + character.game_data.learning) : "")
		+ (character.game_data.prowess > 0 ? ("\nProwess: " + character.game_data.prowess) : "")
		+ ("\nLoyalty: " + character.game_data.loyalty + "%")
		+ (character.game_data.wealth !== 0 ? ("\nWealth: " + number_string(character.game_data.wealth)) : "")
		+ (character.game_data.prestige !== 0 ? ("\nPrestige: " + number_string(character.game_data.prestige)) : "")
		+ (character.game_data.piety !== 0 ? ("\nPiety: " + number_string(character.game_data.piety)) : "")
	))) : ""
	
	property var character: null
	readonly property string country_modifier_tooltip: character ? character.game_data.get_country_modifier_string(0) : ""
}
