extends MarginContainer


#region vars
@onready var quality = $Quality
@onready var socket = $Socket

var armor = null
var grid = null
var thickness = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	armor = input_.armor
	grid = input_.grid
	
	init_basic_setting()


func init_basic_setting() -> void:
	#custom_minimum_size = Global.vec.size.plate
	init_icons()


func init_icons() -> void:
	thickness = Global.num.thickness.min
	var input = {}
	input.type = "quality"
	input.subtype = "bronze"
	quality.set_attributes(input)
	quality.custom_minimum_size = Global.vec.size.socket * 2.0 / 3.0
	
	input.proprietor = self
	socket.set_attributes(input)


func change_thickness(value_: int) -> void:
	thickness += value_
	
	quality.subtype = Global.dict.number.quality[thickness]
	quality.update_image()
#endregion
