extends MarginContainer


#region vars
@onready var bg = $BG
@onready var icon = $HBox/Icon

var dice = null
var value = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	dice = input_.dice
	value = input_.value
	
	init_basic_setting()


func init_basic_setting() -> void:
	var input = {}
	input.type = "number"
	input.subtype = value
	icon.set_attributes(input)
	custom_minimum_size = Vector2(Global.vec.size.facet)
	
	var style = StyleBoxFlat.new()
	bg.set("theme_override_styles/panel", style)
	style.bg_color = Global.color.quality[Global.dict.number.quality[value]]
#endregion
