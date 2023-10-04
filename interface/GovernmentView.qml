import QtQuick
import QtQuick.Controls
import "./dialogs"

Item {
	id: government_view
	
	Column {
		id: policies_column
		anchors.top: parent.top
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		spacing: 8 * scale_factor
		
		Repeater {
			model: metternich.get_policies()
			
			Item {
				anchors.horizontalCenter: parent.horizontalCenter
				width: policy_slider.width
				height: policy_slider.height
				
				readonly property var policy: model.modelData
				
				SmallText {
					text: policy.left_name
					anchors.verticalCenter: policy_slider.verticalCenter
					anchors.right: policy_slider.left
					anchors.rightMargin: 4 * scale_factor
				}
				
				CustomSlider {
					id: policy_slider
					anchors.horizontalCenter: parent.horizontalCenter
					value: country_game_data.policy_values.length > 0 ? country_game_data.get_policy_value(policy) : 0
					min_value: -5
					max_value: 5
					fill_slider: false
					show_handle: true
					
					onDecremented: {
					}
					
					onIncremented: {
					}
				}
				
				SmallText {
					text: policy.right_name
					anchors.verticalCenter: policy_slider.verticalCenter
					anchors.left: policy_slider.right
					anchors.leftMargin: 4 * scale_factor
				}
			}
		}
	}
}
