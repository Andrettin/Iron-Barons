import QtQuick
import QtQuick.Controls
import ".."

ModifierDialog {
	id: character_dialog
	title: character ? character.game_data.titled_name : ""
	date_string: character ? ("Lived: " + date_year_range_string(character.birth_date, character.death_date)) : ""
	description: character ? character.description : ""
	
	property var character: null
}
