extends MarginContainer


#region vars
@onready var armor = $VBox/Armor
@onready var pool = $VBox/Pool

var pantheon = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	pantheon = input_.pantheon
	
	init_basic_setting()


func init_basic_setting() -> void:
	var input = {}
	input.knight = self
	armor.set_attributes(input)
	pool.set_attributes(input)
	
	for _i in 3:
		pool.add_dice(6)
	
	pool.roll_dices()
#endregion

