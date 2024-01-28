extends MarginContainer


#region vars
@onready var vbox = $VBox
@onready var hbox = $HBox
@onready var up = $VBox/Up
@onready var down = $VBox/Down
@onready var left = $HBox/Left
@onready var right = $HBox/Right

var tactic = null
var direction = null
var alignment = null
var index = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	tactic = input_.tactic
	direction = input_.direction
	
	init_basic_setting()


func init_basic_setting() -> void:
	custom_minimum_size = Vector2(Global.vec.size.banner)
	alignment = Global.dict.alignment[direction]
	init_icons()


func init_icons() -> void:
	var sides = {}
	sides[false] = "internal"
	sides[true] = "external"
	var input = {}
	input.type = "banner"
	
	for _direction in Global.arr.direction:
		var icon = get(_direction)
		
		if Global.dict.alignment[_direction] == alignment:
			var flag = _direction == direction
			#print([_direction, direction])
			input.subtype = sides[flag] + " " + _direction
			icon.set_attributes(input)
		else:
			var parent = icon.get_parent()
			parent.remove_child(icon)
			icon.queue_free()
	
	input.type = "number"
	input.subtype = 0
	var boxs = ["hbox", "vbox"]
	
	for _box in boxs:
		var box = get(_box)
		
		if box.get_child_count() == 3:
			index = box.get_child(1)
			index.set_attributes(input)
		else:
			remove_child(box)
			box.queue_free()


func update_index(quadrant_: MarginContainer) -> void:
	match alignment:
		"horizontal":
			index.set_number(quadrant_.grid.y)
		"vertical":
			index.set_number(quadrant_.grid.x)
#endregion
