extends MarginContainer


@onready var firstCol = $GridContainer/Cols/First
@onready var secondCol = $GridContainer/Cols/Second
@onready var firstRow = $GridContainer/Rows/First
@onready var secondRow = $GridContainer/Rows/Second
@onready var knights = $GridContainer/Knights

var order = null


func set_attributes(input_: Dictionary) -> void:
	order = input_.order
	
	init_basic_setting()


func init_basic_setting() -> void:
	init_icons()


func init_icons() -> void:
	var types = ["first", "second"]
	var subtypes = ["col", "row"]
	var vector = Global.vec.size.plate * 2
	vector.y += Global.vec.size.facet.y
	
	var input = {}
	input.type = "number"
	input.subtype = 0
	
	for type in types:
		for subtype in subtypes:
			var icon = get(type+subtype.capitalize())
			icon.set_attributes(input)
			
			match subtype:
				"col":
					icon.custom_minimum_size.x = vector.x
				"row":
					icon.custom_minimum_size.y = vector.y
