extends MarginContainer


#region vars
@onready var sockets = $HBox/Sockets
@onready var duplication = $HBox/Modifiers/Duplication
@onready var advancement = $HBox/Modifiers/Advancement
@onready var charge = $HBox/Charge
@onready var interaction = $HBox/Interaction

var veil = null
var pool = null
var index = null
var gems = null
var description = null
var kits = []
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	veil = input_.veil
	index = input_.index
	gems = input_.gems
	
	init_basic_setting()


func init_basic_setting() -> void:
	pool = veil.knight.pool
	#custom_minimum_size = Global.vec.size.plate
	description = Global.dict.enchantment.index[index]
	
	for gem in gems:
		gem.current.change_number(description.rank)
	
	init_icons()
	init_sockets()


func init_icons() -> void:
	var input = {}
	input.type = "number"
	input.subtype = 0
	var keys = ["duplication", "advancement", "charge"]
	
	for key in keys:
		var icon = get(key)
		icon.set_attributes(input)
		icon.custom_minimum_size = Global.vec.size.socket / 2.0
	
	if description.modifier.advancement > 0:
		advancement.set_number(description.modifier.advancement)
		#advancement.visible = true
	else:
		advancement.number.visible = false
	
	if description.modifier.duplication > 0:
		duplication.set_number(description.modifier.duplication)
		#duplication.visible = true
	else:
		duplication.number.visible = false
	
	charge.set_number(description.charge)
	
	input.type = "interaction"
	input.subtype = description.interaction
	interaction.set_attributes(input)
	interaction.custom_minimum_size = Global.vec.size.socket


func init_sockets() -> void:
	for _i in description.sockets:
		var input = {}
		input.proprietor = self
		
		var socket = Global.scene.socket.instantiate()
		sockets.add_child(socket)
		socket.set_attributes(input)
		socket.apply_conditions()
#endregion


func set_kits() -> void:
	#print([veil.knight.sequence, description.interaction])
	var kits = []
	var dices = []
	var socket = sockets.get_child(0)
	
	for dice in pool.dices.get_children():
		if socket.condition_check(dice):
			dices.append(dice)
	
	var constituents = Global.get_all_constituents(dices)
	constituents = constituents[sockets.get_child_count()]
	
	for constituent in constituents:
		#print("___")
		for dice in constituent:
		#	print(dice.get_current_facet_value())
		pass


func apply() -> void:
	pass
