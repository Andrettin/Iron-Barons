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
	))) : ""
	
	property var character: null
	readonly property string country_modifier_tooltip: character ? character.game_data.get_country_modifier_string(0) : ""
}
