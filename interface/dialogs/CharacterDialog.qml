import QtQuick
import QtQuick.Controls
import ".."

ModifierDialog {
	id: character_dialog
	title: character ? (character_title_name.length > 0 ? character_title_name + " " : "") + character.full_name : ""
	date_string: character ? ("Lived: " + date_year_range_string(character.birth_date, character.death_date)) : ""
	description: character ? character.description : ""
	
	property var character: null
	readonly property bool is_ruler: character ? character.game_data.ruler : false
	readonly property bool is_governor: character ? character.game_data.governor : false
	readonly property bool is_landholder: character ? character.game_data.landholder : false
	readonly property string character_title_name: is_ruler ? country_game_data.ruler_title_name : (is_governor ? character.governable_province.game_data.governor_title_name : (is_landholder ? character.holdable_site.game_data.landholder_title_name : ""))
}
