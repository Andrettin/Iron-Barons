import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
	id: infopanel
	width: infopanel_image.width - 112 * scale_factor
	
	Image {
		id: infopanel_image
		anchors.top: parent.top
		anchors.left: parent.left
		anchors.leftMargin: -112 * scale_factor
		source: "image://interface/" + interface_style + "/infopanel"
		fillMode: Image.PreserveAspectCrop
	}
	
	ListView {
		id: population_unit_list
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.top: parent.top
		anchors.topMargin: 96 * scale_factor
		anchors.bottom: back_button.top
		anchors.bottomMargin: 8 * scale_factor
		boundsBehavior: Flickable.StopAtBounds
		clip: true
		model: province_game_data.population_type_counts
		delegate: Item {
			width: population_unit_list.width
			height: 48 * scale_factor
			
			readonly property var population_type: model.modelData.key
			readonly property int population_count: model.modelData.value
			
			Image {
				id: population_type_icon
				anchors.top: parent.top
				anchors.horizontalCenter: parent.horizontalCenter
				source: "image://icon/" + population_type.small_icon.identifier
			}
			
			SmallText {
				text: population_count
				anchors.top: population_type_icon.bottom
				anchors.topMargin: 4 * scale_factor
				anchors.horizontalCenter: parent.horizontalCenter
			}
			
			MouseArea {
				anchors.fill: parent
				hoverEnabled: true
				
				onEntered: {
					status_text = population_type.name
				}
				
				onExited: {
					status_text = ""
				}
			}
		}
	}
	
	TextButton {
		id: back_button
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 8 * scale_factor
		text: qsTr("Back")
		width: 48 * scale_factor
		height: 24 * scale_factor
		
		onClicked: {
			menu_stack.pop()
		}
	}
}
