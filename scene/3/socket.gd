extends MarginContainer


#region vars
@onready var bg = $BG
@onready var left = $Left
@onready var right = $Right
@onready var above = $Above
@onready var below = $Below
@onready var first = $First
@onready var second = $Second
@onready var less = $Less
@onready var more = $More
@onready var slot = $Slot

var proprietor = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	proprietor = input_.proprietor
	
	init_basic_setting()


func init_basic_setting() -> void:
	custom_minimum_size = Global.vec.size.socket
	
	var style = StyleBoxFlat.new()
	style.bg_color = Color.DARK_SLATE_GRAY
	bg.set("theme_override_styles/panel", style)
	
	init_icons()


func init_icons() -> void:
	var input = {}
	input.type = "number"
	input.subtype = 0
	var keys = ["first", "second"]
	keys.append_array(Global.arr.orientation)
	keys.append_array(Global.arr.comparison)
	
	for key in keys:
		var icon = get(key)
		icon.set_attributes(input)
		icon.custom_minimum_size = Global.vec.size.socket / 3.0


func apply_conditions() -> void:
	bg.visible = true
	var keys = ["element", "value"]
	
	for key in keys:
		var condition = proprietor.description.condition[key]
		
		if condition != "any":
			match key:
				"element":
					var icon = get("first")
					icon.type = "element"
					icon.subtype = condition
					icon.update_image()
					icon.visible = true
				"value":
					var words = condition.split(" ")
					var icons = []
					
					match words[0]:
						"less":
							var icon = get("less")
							icons.append(icon)
						"more":
							var icon = get("more")
							icons.append(icon)
						"less":
							var icon = get("less")
							icons.append(icon)
							icon = get("more")
							icons.append(icon)
					
					var value = int(words[1])
					
					for icon in icons:
						icon.set_number(value)
						icon.visible = true
#endregion
