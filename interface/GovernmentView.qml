import QtQuick
import QtQuick.Controls
import "./dialogs"

Item {
	id: government_view
	
	SmallText {
		id: government_type_label
		text: "Government Type"
		anchors.top: parent.top
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
	}
	
	CustomIconImage {
		id: government_type_icon
		anchors.top: government_type_label.bottom
		anchors.topMargin: 8 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		icon_identifier: country_game_data.government_type.icon.identifier
		name: country_game_data.government_type.name
	}
	
	SmallText {
		id: country_tier_label
		text: "Tier"
		anchors.top: government_type_icon.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
	}
	
	CustomIconImage {
		id: country_tier_icon
		anchors.top: country_tier_label.bottom
		anchors.topMargin: 8 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		icon_identifier: country_tier_data.icon.identifier
		name: country_tier_data.name
		tooltip: country_tier_data.name + (modifier_string.length > 0 ? format_text(small_text("\n"
			+ "\n" + modifier_string)) : "")
			
		readonly property var country_tier_data: metternich.get_country_tier_data(country_game_data.tier)
		readonly property string modifier_string: country_tier_data.get_modifier_string(country)
	}
	
	Column {
		id: law_groups_column
		anchors.top: country_tier_icon.bottom
		anchors.topMargin: 16 * scale_factor
		anchors.horizontalCenter: parent.horizontalCenter
		spacing: 8 * scale_factor
		
		Repeater {
			model: country_game_data.laws
			
			Item {
				id: law_group_item
				anchors.horizontalCenter: parent.horizontalCenter
				width: Math.max(law_group_label.width, laws_column.width)
				height: laws_column.y + laws_column.height
				
				readonly property var law_group: model.modelData.key
				readonly property var current_law: model.modelData.value
				
				SmallText {
					id: law_group_label
					text: law_group.name
					anchors.top: parent.top
					anchors.horizontalCenter: parent.horizontalCenter
				}
				
				Column {
					id: laws_column
					anchors.top: law_group_label.bottom
					anchors.topMargin: 4 * scale_factor
					anchors.horizontalCenter: parent.horizontalCenter
					
					Repeater {
						model: law_group.laws
						
						CustomCheckBox {
							text: colored_text(law.name, "white")
							checked: law === current_law
							checkable: !checked && country_game_data.laws.length > 0 && country_game_data.can_enact_law(law)
							tooltip: tooltip_string.length > 0 ? format_text(small_text(tooltip_string)) : ""
							visible: country_game_data.laws.length > 0 && country_game_data.can_have_law(law)
							onCheckedChanged: {
								if (law === current_law) {
									return
								}
								
								country_game_data.enact_law(law)
							}
							
							readonly property var law: model.modelData
							readonly property string costs_string: law !== current_law ? costs_to_string(law.commodity_costs, country_game_data.get_total_law_cost_modifier()) : ""
							readonly property string modifier_string: law.get_modifier_string(country)
							readonly property string tooltip_string: costs_string + (costs_string.length > 0 && modifier_string.length > 0 ? "\n" : "") + modifier_string
						}
					}
				}
			}
		}
	}
	
	Column {
		id: policies_column
		anchors.top: law_groups_column.bottom
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
