extends MarginContainer


#region vars
@onready var current = $HBox/Current
@onready var limit = $HBox/Limit
@onready var slash = $HBox/Slash

var veil = null
var plate = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	veil = input_.veil
	plate = input_.plate
	
	init_basic_setting()


func init_basic_setting() -> void:
	custom_minimum_size = Global.vec.size.gem
	init_icons()


func init_icons() -> void:
	var input = {}
	input.type = "number"
	input.subtype = 0
	var keys = ["current", "limit"]
	
	for key in keys:
		var icon = get(key)
		icon.set_attributes(input)
		icon.custom_minimum_size = Vector2()
	
	limit.set_number(plate.thickness)
	
	input.type = "string"
	input.subtype = "/"
	slash.set_attributes(input)
	slash.custom_minimum_size = Vector2()
