extends MarginContainer


#region vars
@onready var up = $Up
@onready var down = $Down
@onready var left = $Left
@onready var right = $Right
@onready var first = $First
@onready var second = $Second
@onready var third = $Third
@onready var fourth = $Fourth

var order = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	order = input_.order
	
	init_basic_setting()


func init_basic_setting() -> void:
	custom_minimum_size = Vector2(Global.vec.size.tactic)
	init_banners()
	init_indexs()


func init_banners() -> void:
	var input = {}
	input.tactic = self
	
	for direction in Global.arr.direction:
		input.direction = direction
		var banner = get(direction)
		banner.set_attributes(input)


func init_indexs() -> void:
	var input = {}
	input.type = "number"
	input.subtype = 0
	
	for sequence in Global.arr.sequence:
		var knight = order.sequences.get(sequence)
		knight.index = get(sequence)
		input.subtype = Global.arr.sequence.find(sequence)
		knight.index.set_attributes(input)
		knight.index.custom_minimum_size = Vector2(Global.vec.size.banner)


func disembark_on_quadrant(quadrant_: MarginContainer) -> void:
	for direction in Global.arr.direction:
		var banner = get(direction)
		var windrose = Global.dict.synonym[direction]
		var neighbor = quadrant_.windroses[windrose]
		banner.update_index(neighbor)
	
	update_knights_quadrants()


func update_knights_quadrants() -> void:
	for sequence in Global.arr.sequence:
		var knight = order.sequences.get(sequence)
		var grid = Vector2()
		
		for axis in Global.dict.sequence.map[sequence]:
			var direction = Global.dict.sequence.map[sequence][axis]
			var banner = get(direction)
			grid[axis] = banner.index.get_number()
		
		var quadrant = order.battleground.get_quadrant(grid)
		knight.set_quadrant(quadrant)
#endregion
