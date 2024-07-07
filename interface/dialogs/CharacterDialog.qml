import QtQuick
import QtQuick.Controls
import ".."

ModifierDialog {
	id: character_dialog
	title: character ? (is_ruler ? country_game_data.ruler_title_name + " " : "") + character.full_name : ""
	date_string: character ? ("Lived: " + date_year_range_string(character.birth_date, character.death_date)) : ""
	description: character ? character.description : ""
	
	property var character: null
	readonly property bool is_ruler: character ? character === ruler : false
}
