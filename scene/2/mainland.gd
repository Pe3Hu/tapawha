extends MarginContainer


#region vars
@onready var battlegrounds = $Battlegrounds

var sketch = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	sketch = input_.sketch
	
	init_battlegrounds()


func init_battlegrounds() -> void:
	for _i in 1:
		var input = {}
		input.space = self
	
		var battleground = Global.scene.battleground.instantiate()
		battlegrounds.add_child(battleground)
		battleground.set_attributes(input)
#endregion
