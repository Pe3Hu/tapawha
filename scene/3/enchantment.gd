extends MarginContainer


#region vars
@onready var sockets = $HBox/Sockets
@onready var count = $HBox/Modifiers/Count
@onready var value = $HBox/Modifiers/Value
@onready var charge = $HBox/Charge
@onready var interaction = $HBox/Interaction

var veil = null
var index = null
var gems = null
var description = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	veil = input_.veil
	index = input_.index
	gems = input_.gems
	
	init_basic_setting()


func init_basic_setting() -> void:
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
	var keys = ["count", "value", "charge"]
	
	for key in keys:
		var icon = get(key)
		icon.set_attributes(input)
		#icon.custom_minimum_size = Global.vec.size.socket / 4.0
	
	if description.modifier.value > 0:
		value.set_number(description.modifier.value)
		value.visible = true
	
	if description.modifier.count > 0:
		count.set_number(description.modifier.count)
		count.visible = true
		
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
