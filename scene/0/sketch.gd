extends MarginContainer


@onready var cradle = $HBox/Cradle
@onready var mainland = $HBox/Mainland


func _ready() -> void:
	var input = {}
	input.sketch = self
	cradle.set_attributes(input)
	mainland.set_attributes(input)
	
	var battleground = mainland.battlegrounds.get_child(0)
	var order = cradle.orders.get_child(0)
	battleground.order_disembark(order)
