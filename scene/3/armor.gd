extends MarginContainer


@onready var plates = $Plates

var knight = null
var grids = {}
var dimensions = null


func set_attributes(input_: Dictionary) -> void:
	knight = input_.knight
	
	init_basic_setting()


func init_basic_setting() -> void:
	grids.plate = {}
	dimensions = Vector2(2, 2)
	plates.columns = dimensions.x
	
	for _i in dimensions.y:
		for _j in dimensions.x:
			var input = {}
			input.armor = self
			input.grid = Vector2(_j, _i)
			
			var plate = Global.scene.plate.instantiate()
			plates.add_child(plate)
			plate.set_attributes(input)
