extends MarginContainer


#region vars
@onready var gems = $VBox/Gems
@onready var enchantments = $VBox/Enchantments

var knight = null
var armor = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	knight = input_.knight
	
	init_basic_setting()


func init_basic_setting() -> void:
	armor = knight.armor
	init_gems()
	roll_offense_enchantments()


func init_gems() -> void:
	gems.columns = armor.plates.columns
	
	for plate in armor.plates.get_children():
		var input = {}
		input.veil = self
		input.plate = plate
		
		var gem = Global.scene.gem.instantiate()
		gems.add_child(gem)
		gem.set_attributes(input)


func roll_offense_enchantments() -> void:
	var cols = [0, gems.columns - 1]
	var n = gems.get_child_count() / gems.columns
	
	for _i in cols.size():
		var col = cols[_i]
		var rank = Global.num.thickness.max
		var input = {}
		input.veil = self
		input.gems = []
		
		for _j in n:
			var index = _j * gems.columns + col
			var gem = gems.get_child(index)
			rank = min(rank, gem.limit.get_number())
			input.gems.append(gem)
		
		var options = Global.dict.enchantment.origin[knight.origin][_i + 1]
		input.index = options.pick_random()
		
		var enchantment = Global.scene.enchantment.instantiate()
		enchantments.add_child(enchantment)
		enchantment.set_attributes(input)
#endregion
