import QtQuick 2.12
import QtQuick.Controls 2.12
import ".."

DialogBase {
	id: event_dialog
	panel: 5
	title: event_instance ? event_instance.name : ""
	
	property var event_instance: null
	property var options: ["OK"]
	property var option_tooltips: [""]
	
	property bool option_picked: false
	
	SmallText {
		id: description
		anchors.top: title_item.bottom
		anchors.topMargin: 16 * metternich.scale_factor
		anchors.left: parent.left
		anchors.leftMargin: 8 * metternich.scale_factor
		anchors.right: parent.right
		anchors.rightMargin: 8 * metternich.scale_factor
		anchors.bottom: option_grid.top
		anchors.bottomMargin: 8 * metternich.scale_factor
		text: event_instance.description
		wrapMode: Text.WordWrap
	}
	
	Grid {
		id: option_grid
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 8 * metternich.scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		columns: 1
		columnSpacing: 0
		rowSpacing: 8 * metternich.scale_factor
		
		Repeater {
			model: options
			
			TextButton {
				id: option_button
				text: model.modelData
				tooltip: format_text(option_tooltips[index])
				
				onClicked: {
					if (option_picked) {
						//an option was already picked
						return
					}
					
					option_picked = true
					event_instance.choose_option(index)
				}
			}
		}
	}
	
	Connections {
		target: metternich
		
		function onEvent_closed(event_instance) {
			if (event_instance === event_dialog.event_instance) {
				event_dialog.close()
				event_dialog.destroy()
			}
		}
	}
}
