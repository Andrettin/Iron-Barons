import QtQuick
import QtQuick.Controls
import ".."

ModifierDialog {
	id: tradition_dialog
	title: tradition ? tradition.name : ""
	modifier_string: tradition ? tradition.get_modifier_string(metternich.game.player_country) : ""
	
	property var tradition: null
}
