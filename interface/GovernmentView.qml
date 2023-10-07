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
					min_limit: country_game_data.government_type ? country_game_data.get_min_policy_value(policy) : min_value
					max_limit: country_game_data.government_type ? country_game_data.get_max_policy_value(policy) : max_value
					fill_slider: false
					show_handle: true
					tooltip: format_text(small_text(policy.get_modifier_string(country, policy_slider.value)))
					decrement_button_tooltip: (policy_slider.value - 1) >= min_value ? format_text(small_text(
						"Gain " + 1 + " " + highlight(policy.left_name)
						+ "\n" + costs_to_string(policy.change_commodity_costs, country_game_data.get_policy_value_change_cost_modifier())
						+ "\n" + policy.get_modifier_string(country, policy_slider.value - 1)
					)) : ""
					increment_button_tooltip: (policy_slider.value + 1) <= max_value ? format_text(small_text(
						"Gain " + 1 + " " + highlight(policy.right_name)
						+ "\n" + costs_to_string(policy.change_commodity_costs, country_game_data.get_policy_value_change_cost_modifier())
						+ "\n" + policy.get_modifier_string(country, policy_slider.value + 1)
					)) : ""
					
					onDecremented: {
						if (country_game_data.can_change_policy_value(policy, -1)) {
							country_game_data.do_policy_value_change(policy, -1)
						}
					}
					
					onIncremented: {
						if (country_game_data.can_change_policy_value(policy, 1)) {
							country_game_data.do_policy_value_change(policy, 1)
						}
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
