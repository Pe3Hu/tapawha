extends MarginContainer


#region vars
@onready var veil = $HBox/Veil
@onready var armor = $HBox/VBox/Armor
@onready var pool = $HBox/VBox/Pool

var order = null
var sequence = null
var index = null
var quadrant = null
var origin = null
var stage = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	order = input_.order
	sequence = input_.sequence
	
	init_basic_setting()


func init_basic_setting() -> void:
	var index = Global.arr.sequence.find(sequence)
	origin = Global.arr.element[index]
	order.sequences[sequence] = self
	var input = {}
	input.knight = self
	armor.set_attributes(input)
	veil.set_attributes(input)
	pool.set_attributes(input)
	
	for _i in 3:
		pool.add_dice(6)
	
	pool.roll_dices()
	take_advantage_of_enchantments()


func set_quadrant(quadrant_: MarginContainer) -> void:
	if quadrant != null:
		quadrant.knights.erase(self)
	
	quadrant = quadrant_
	index.set_number(quadrant.index.get_number())
	quadrant.knights.append(self)
#endregion


func take_advantage_of_enchantments() -> void:
	next_stage()
	trawl_through_all_enchantments()


func next_stage() -> void:
	stage = Global.dict.chain.stage[stage]


func trawl_through_all_enchantments() -> void:
	var options = {}
	
	for enchantment in veil.enchantments.get_children():
		if enchantment.charge.get_number() > 0 and enchantment.description.role == stage:
			options[enchantment] = enchantment.set_kits()
