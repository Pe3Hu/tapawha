extends MarginContainer


#region vars
@onready var knights = $HBox/Knights
@onready var tactic = $HBox/Tactic

var cradle = null
var battleground = null
var sequences = {}
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	cradle = input_.cradle
	
	init_basic_setting()


func init_basic_setting() -> void:
	init_knights()
	
	var input = {}
	input.order = self
	tactic.set_attributes(input)


func init_knights() -> void:
	for sequence in Global.arr.sequence:
		var input = {}
		input.order = self
		input.sequence = sequence
	
		var knight = Global.scene.knight.instantiate()
		knights.add_child(knight)
		knight.set_attributes(input)
#endregion
