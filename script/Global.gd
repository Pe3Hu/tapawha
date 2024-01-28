extends Node


var rng = RandomNumberGenerator.new()
var arr = {}
var num = {}
var vec = {}
var color = {}
var dict = {}
var flag = {}
var node = {}
var scene = {}


func _ready() -> void:
	init_arr()
	init_num()
	init_vec()
	init_color()
	init_dict()
	init_node()
	init_scene()


func init_arr() -> void:
	arr.edge = [1, 2, 3, 4, 5, 6]
	arr.direction = ["up", "right", "down", "left"]
	arr.orientation = ["above", "right", "below", "left"]
	arr.windrose = ["N", "E", "S", "W"]
	arr.sector = [0, 1, 2, 3, 4]
	arr.type = ["corner", "edge", "center"]
	arr.sequence = ["first", "second", "third", "fourth"]


func init_num() -> void:
	num.index = {}
	
	num.quadrant = {}
	num.quadrant.n = 3
	num.quadrant.col = num.quadrant.n * 2 + 1
	num.quadrant.row = num.quadrant.col


func init_dict() -> void:
	init_neighbor()
	init_quality()
	init_windrose()


func init_quality() -> void:
	dict.number = {}
	dict.number.quality = {}
	dict.number.quality[1] = "bronze"
	dict.number.quality[2] = "silver"
	dict.number.quality[3] = "silver"
	dict.number.quality[4] = "gold"
	dict.number.quality[5] = "gold"
	dict.number.quality[6] = "platinum"
	
	dict.alignment = {}
	dict.alignment.horizontal = ["up", "down"]
	dict.alignment.vertical = ["left", "right"]
	dict.alignment.up = "horizontal"
	dict.alignment.down = "horizontal"
	dict.alignment.left = "vertical"
	dict.alignment.right = "vertical"
	
	dict.synonym = {}
	dict.synonym["N"] = "up"
	dict.synonym["NE"] = "up right"
	dict.synonym["E"] = "right"
	dict.synonym["SE"] = "down right"
	dict.synonym["S"] = "down"
	dict.synonym["SW"] = "down left"
	dict.synonym["W"] = "left"
	dict.synonym["NW"] = "up left"
	dict.synonym["up"] = "N"
	dict.synonym["right"] = "E"
	dict.synonym["down"] = "S"
	dict.synonym["left"] = "W"
	dict.synonym[""] = ""
	
	dict.sequence = {}
	dict.sequence.map = {}
	dict.sequence.map["first"] = {}
	dict.sequence.map["first"]["x"] = "left"
	dict.sequence.map["first"]["y"] = "up"
	dict.sequence.map["second"] = {}
	dict.sequence.map["second"]["x"] = "right"
	dict.sequence.map["second"]["y"] = "up"
	dict.sequence.map["third"] = {}
	dict.sequence.map["third"]["x"] = "left"
	dict.sequence.map["third"]["y"] = "down"
	dict.sequence.map["fourth"] = {}
	dict.sequence.map["fourth"]["x"] = "right"
	dict.sequence.map["fourth"]["y"] = "down"


func init_neighbor() -> void:
	dict.neighbor = {}
	dict.neighbor.linear3 = [
		Vector3( 0, 0, -1),
		Vector3( 1, 0,  0),
		Vector3( 0, 0,  1),
		Vector3(-1, 0,  0)
	]
	dict.neighbor.linear2 = [
		Vector2( 0,-1),
		Vector2( 1, 0),
		Vector2( 0, 1),
		Vector2(-1, 0)
	]
	dict.neighbor.diagonal = [
		Vector2( 1,-1),
		Vector2( 1, 1),
		Vector2(-1, 1),
		Vector2(-1,-1)
	]
	dict.neighbor.zero = [
		Vector2( 0, 0),
		Vector2( 1, 0),
		Vector2( 1, 1),
		Vector2( 0, 1)
	]
	dict.neighbor.hex = [
		[
			Vector2( 1,-1), 
			Vector2( 1, 0), 
			Vector2( 0, 1), 
			Vector2(-1, 0), 
			Vector2(-1,-1),
			Vector2( 0,-1)
		],
		[
			Vector2( 1, 0),
			Vector2( 1, 1),
			Vector2( 0, 1),
			Vector2(-1, 1),
			Vector2(-1, 0),
			Vector2( 0,-1)
		]
	]


func init_windrose() -> void:
	dict.windrose = {}
	
	for _i in arr.windrose.size():
		for _j in 2:
			var windrose = arr.windrose[_i]
			var direction = dict.neighbor.linear2[_i]
			
			if _j == 1:
				var index = (_i + 1) % arr.windrose.size()
				windrose += arr.windrose[index]
				direction = dict.neighbor.diagonal[_i]
			
			if windrose == "ES":
				windrose = "SE"
			
			if windrose == "WN":
				windrose = "NW"
			
			dict.windrose[windrose] = direction


func init_blank() -> void:
	dict.blank = {}
	dict.blank.title = {}
	
	var path = "res://asset/json/poupou_blank.json"
	var array = load_data(path)
	
	for blank in array:
		var data = {}
		
		for key in blank:
			if key != "title":
				data[key] = blank[key]
		
		dict.blank.title[blank.title] = data


func init_node() -> void:
	node.game = get_node("/root/Game")


func init_scene() -> void:
	scene.order = load("res://scene/1/order.tscn")
	scene.knight = load("res://scene/1/knight.tscn")
	
	scene.battleground = load("res://scene/2/battleground.tscn")
	scene.quadrant = load("res://scene/2/quadrant.tscn")
	
	scene.dice = load("res://scene/3/dice.tscn")
	scene.facet = load("res://scene/3/facet.tscn")
	scene.plate = load("res://scene/3/plate.tscn")


func init_vec():
	vec.size = {}
	vec.size.number = Vector2(32, 32)
	vec.size.sixteen = Vector2(16, 16)
	
	vec.size.quadrant = Vector2(vec.size.sixteen * 2)#Vector2(96, 96)
	vec.size.plate = Vector2(vec.size.sixteen * 6)
	vec.size.facet = Vector2(vec.size.sixteen * 2)
	vec.size.emblem = Vector2(vec.size.sixteen * 2)
	vec.size.banner = Vector2(vec.size.emblem * 2)
	vec.size.tactic = Vector2(vec.size.banner * 2)
	
	init_window_size()


func init_window_size():
	vec.size.window = {}
	vec.size.window.width = ProjectSettings.get_setting("display/window/size/viewport_width")
	vec.size.window.height = ProjectSettings.get_setting("display/window/size/viewport_height")
	vec.size.window.center = Vector2(vec.size.window.width/2, vec.size.window.height/2)


func init_color():
	var h = 360.0
	
	color.defender = {}
	color.defender.active = Color.from_hsv(120 / h, 0.6, 0.7)
	
	color.quality = {}
	color.quality.bronze = Color.from_hsv(210 / h, 0.95, 0.95)
	color.quality.silver = Color.from_hsv(158 / h, 0.98, 0.9)
	color.quality.gold = Color.from_hsv(275 / h, 0.6, 1.0)
	color.quality.platinum = Color.from_hsv(37 / h, 0.9, 1.0)


func save(path_: String, data_: String):
	var path = path_ + ".json"
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(data_)


func load_data(path_: String):
	var file = FileAccess.open(path_, FileAccess.READ)
	var text = file.get_as_text()
	var json_object = JSON.new()
	var parse_err = json_object.parse(text)
	return json_object.get_data()


func get_random_key(dict_: Dictionary):
	if dict_.keys().size() == 0:
		print("!bug! empty array in get_random_key func")
		return null
	
	var total = 0
	
	for key in dict_.keys():
		total += dict_[key]
	
	rng.randomize()
	var index_r = rng.randf_range(0, 1)
	var index = 0
	
	for key in dict_.keys():
		var weight = float(dict_[key])
		index += weight/total
		
		if index > index_r:
			return key
	
	print("!bug! index_r error in get_random_key func")
	return null
