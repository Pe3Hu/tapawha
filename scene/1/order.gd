extends MarginContainer


#region vars
@onready var formation = $HBox/Formation

var cradle = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	cradle = input_.cradle
	
	init_basic_setting()


func init_basic_setting() -> void:
	init_knights()
	var input = {}
	input.order = self
	formation.set_attributes(input)


func init_knights() -> void:
	for _i in 4:
		var input = {}
		input.pantheon = self
	
		var knight = Global.scene.knight.instantiate()
		formation.knights.add_child(knight)
		knight.set_attributes(input)
#endregion
