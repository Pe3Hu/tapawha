extends MarginContainer


#region vars
@onready var quadrants = $Quadrants

var space = null
var sectors = {}
var current = {}
var selection = {}
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	space = input_.space
	
	init_quadrants()
	current.layer = null
	#change_current_layer(0)
	#prepare_selection()
	#var cubicle = space.sketch.bureau.portfolios.get_child(0).blueprints.get_child(0).cubicles.get_child(1)
	#find_all_suitable_quadrants(cubicle)


func init_quadrants() -> void:
	var corners = {}
	corners.x = [0, Global.num.quadrant.col - 1]
	corners.y = [0, Global.num.quadrant.row - 1]
	
	quadrants.columns = Global.num.quadrant.col
	
	for _i in Global.num.quadrant.row:
		for _j in Global.num.quadrant.col:
			var input = {}
			input.planet = self
			input.grid = Vector2(_j, _i)
			input.sector = 0
			
			if _j != Global.num.quadrant.col / 2 and _i != Global.num.quadrant.row / 2:
				var x = sign(_j - Global.num.quadrant.col / 2 + 0.5) + 1
				var y = sign(_i - Global.num.quadrant.row / 2 + 0.5) + 1
				input.sector = x / 2 + y + 1
			
			if corners.y.has(_i) or corners.x.has(_j):
				if corners.y.has(_i) and corners.x.has(_j):
					input.type = "corner"
				else:
					input.type = "edge"
			else:
				input.type = "center"
	
			var quadrant = Global.scene.quadrant.instantiate()
			quadrants.add_child(quadrant)
			quadrant.set_attributes(input)
			
			if !sectors.has(input.sector):
				sectors[input.sector] = []
			
			sectors[input.sector].append(quadrant)
	
	init_quadrants_neighbor()
	init_quadrants_subtype()


func init_quadrants_neighbor() -> void:
	for quadrant in quadrants.get_children():
		for windrose in Global.dict.windrose:
			var grid = quadrant.grid + Global.dict.windrose[windrose]
			var neighbor = get_quadrant(grid)
			
			if neighbor != null:
				quadrant.neighbors[neighbor] = windrose
				quadrant.windroses[windrose] = neighbor


func init_quadrants_subtype() -> void:
	var grid = Vector2(ceil(Global.num.quadrant.row / 2), floor(Global.num.quadrant.col / 2))
	var core = get_quadrant(grid)
	core.subtype = "core"
	#core.recolor("subtype")
	
	var subtypes = ["axis", "diagonal"]
	
	for subtype in subtypes:
		var key = subtype
		
		if subtype == "axis":
			key = "linear2"
		
		for direction in Global.dict.neighbor[key]:
			grid = core.grid + direction
			var quadrant = get_quadrant(grid)
			
			while quadrant != null:
				quadrant.subtype = subtype
				#quadrant.recolor("subtype")
				grid += direction
				quadrant = get_quadrant(grid)


func check_grid(grid_: Vector2) -> bool:
	return grid_.x >= 0 and grid_.y >= 0 and Global.num.quadrant.row > grid_.y and Global.num.quadrant.col >  grid_.x


func get_quadrant(grid_: Vector2) -> Variant:
	if check_grid(grid_):
		var index = grid_.y * Global.num.quadrant.col + grid_.x
		return quadrants.get_child(index)
	
	return null
#endregion


func change_current_layer(shift_: int) -> void:
	if current.layer == null:
		current.layer = Global.arr.layer.front()
	
	var index = Global.arr.layer.find(current.layer)
	index = (index + shift_ + Global.arr.layer.size()) % Global.arr.layer.size()
	current.layer = Global.arr.layer[index]
	
	for quadrant in quadrants.get_children():
		quadrant.update_icon(current.layer)
		quadrant.recolor(current.layer)


func find_all_suitable_quadrants(cubicle_: MarginContainer) -> void:
	reset_quadrants()
	var conditions = cubicle_.get_conditions()
	var targets = []
	var suitables = {}
	suitables.intersection = []
	var windroses = {}
	windroses.origin = cubicle_.get_windroses()
	windroses.reflected = []
	
	for windrose in windroses.origin:
		var index = Global.dict.windrose.keys().find(windrose)
		index = (index + Global.dict.windrose.keys().size() / 2) % Global.dict.windrose.keys().size()
		var reflection = Global.dict.windrose.keys()[index]
		windroses.reflected.append(reflection)
		suitables[reflection] = []
	
	if conditions.keys().is_empty(): 
		suitables.append_array(quadrants.get_children())
	else:
		for quadrant in quadrants.get_children():
			if quadrant.check_condition(conditions):
				targets.append(quadrant)
				quadrant.paint("Red")
		
		for target in targets:
			for windrose in windroses.reflected:
				if target.windroses.has(windrose):
					var quadrant = target.windroses[windrose]
					suitables[windrose].append(quadrant)
					
					if !suitables.intersection.has(quadrant):
						suitables.intersection.append(quadrant)
	
		for _i in range(suitables.intersection.size()-1,-1,-1):
			var quadrant = suitables.intersection[_i]
			var flag = true
			
			for windrose in windroses.reflected:
				flag = flag and suitables[windrose].has(quadrant)
				
				if !flag:
					break
			
			if !flag:
				suitables.intersection.erase(quadrant)
		
		for suitable in suitables.intersection:
			if selection.has(suitable):
				suitable.paint("Green")


func reset_quadrants() -> void:
	for quadrant in quadrants.get_children():
		quadrant.reset()


func prepare_selection() -> void:
	selection = []
	
	for sector in sectors:
		var options = []
		
		for quadrant in sectors[sector]:
			if quadrant.free:
				options.append(quadrant)
		
		for _i in 2:
			var quadrant = options.pick_random()
			selection.append(quadrant)
			quadrant.paint("blue")
			options.erase(quadrant)
