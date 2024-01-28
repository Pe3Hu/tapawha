extends MarginContainer


#region vars
@onready var armor = $VBox/Armor
@onready var pool = $VBox/Pool

var order = null
var sequence = null
var index = null
var quadrant = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	order = input_.order
	sequence = input_.sequence
	
	init_basic_setting()


func init_basic_setting() -> void:
	order.sequences[sequence] = self
	var input = {}
	input.knight = self
	armor.set_attributes(input)
	pool.set_attributes(input)
	
	for _i in 3:
		pool.add_dice(6)
	
	pool.roll_dices()


func set_quadrant(quadrant_: MarginContainer) -> void:
	quadrant = quadrant_
	index.set_number(quadrant.index.get_number())
#endregion

