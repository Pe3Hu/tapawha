extends MarginContainer


#region vars
@onready var orders = $Orders

var sketch = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	sketch = input_.sketch
	
	init_orders()


func init_orders() -> void:
	for _i in 1:
		var input = {}
		input.cradle = self
	
		var order = Global.scene.order.instantiate()
		orders.add_child(order)
		order.set_attributes(input)

#endregion
