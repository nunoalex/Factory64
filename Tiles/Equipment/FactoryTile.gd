extends "res://Tiles/OreProcessing/BaseOreTransformerTile.gd"

var active_recipe = Constants.FactoryOutputs[0]

func _ready():
	._ready()
	destroy_invalid_inputs = false

func get_list_valid_outputs():
	return [active_recipe]

func get_tile_upgrade():
	return GameState.factory_power_upgrade
