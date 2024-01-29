extends MarginContainer


#region vars
@onready var plates = $Plates

var knight = null
var grids = {}
var dimensions = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	knight = input_.knight
	
	init_basic_setting()


func init_basic_setting() -> void:
	init_plates()
	roll_plates_thickness()
	sort_plates_thickness()


func init_plates() -> void:
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


func roll_plates_thickness() -> void:
	var limit = 10
	var options = {}
	
	for plate in plates.get_children():
		options[plate] = Global.num.thickness.max - plate.thickness
	
	while limit > 0:
		var plate = Global.get_random_key(options)
		Global.rng.randomize()
		var maximum = min(limit, Global.num.thickness.max - plate.thickness)
		var value = Global.rng.randi_range(1, maximum)
		plate.change_thickness(value)
		limit -= value
		options[plate] -= value
		
		if options[plate] == 0:
			options.erase(plate)


func sort_plates_thickness() -> void:
	var array = []
	
	while plates.get_child_count() > 0:
		var plate = plates.get_child(0)
		plates.remove_child(plate)
		array.append(plate)
	
	array.sort_custom(func(a, b): return a.thickness < b.thickness)
	
	for plate in array:
		plates.add_child(plate)
#endregion
	
