extends MarginContainer


@onready var cradle = $HBox/Cradle
@onready var mainland = $HBox/Mainland


func _ready() -> void:
	var input = {}
	input.sketch = self
	cradle.set_attributes(input)
	mainland.set_attributes(input)
