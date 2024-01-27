extends MarginContainer


#region vars
@onready var quality = $Quality
@onready var wound = $Wound
@onready var left = $Left
@onready var right = $Right
@onready var above = $Above
@onready var below = $Below
@onready var first = $First
@onready var second = $Second

var armor = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	armor = input_.armor
	
	init_basic_setting()


func init_basic_setting() -> void:
	init_icons()


func init_icons() -> void:
	custom_minimum_size = Global.vec.size.plate
	var input = {}
	input.type = "number"
	input.subtype = 0
	wound.set_attributes(input)
	
	input.type = "quality"
	input.subtype = "platinum"
	quality.set_attributes(input)
	quality.custom_minimum_size = Global.vec.size.plate * 2 / 4
	
	for orientation in Global.arr.orientation:
		var icon = get(orientation)
		input.type = "element"
		input.subtype = "aqua"
		icon.set_attributes(input)
		icon.custom_minimum_size = Global.vec.size.plate / 4.0
	
	input.type = "element"
	input.subtype = "earth"
	first.set_attributes(input)
	first.custom_minimum_size = Global.vec.size.plate / 4.0
	
	input.subtype = "wind"
	second.set_attributes(input)
	second.custom_minimum_size = Global.vec.size.plate / 4.0
#endregion
