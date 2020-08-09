extends Control

var current_type = Constants.TileType.IRON

onready var left_button = $SelectionPanel/Panel/LeftButton
onready var right_button = $SelectionPanel/Panel/RightButton
onready var tile_sprite = $SelectionPanel/Panel/TileSprite
onready var visual_queue = $SelectionPanel/Panel/VisualQueue
onready var quantity_label = $SelectionPanel/Panel/QuantityLabel
onready var selection_panel = $SelectionPanel
onready var animation_player = $AnimationPlayer

var is_disabled = false

func _ready():
	refresh_ui()

func refresh_ui():
	tile_sprite.frame = current_type
	visual_queue.frame = current_type
	quantity_label.visible = true
	is_disabled = false
	match current_type:
		Constants.TileType.BELT, Constants.TileType.LBELT, Constants.TileType.TBELT:
			quantity_label.visible = false
		Constants.TileType.ASSEMBLY:
			quantity_label.text = "%d/%d" % [GameState.nb_assemblies, GameState.max_assemblies]
			is_disabled = GameState.nb_assemblies == GameState.max_assemblies
		Constants.TileType.CUTTER:
			quantity_label.text = "%d/%d" % [GameState.nb_cutters, GameState.max_cutters]
			is_disabled = GameState.nb_cutters == GameState.max_cutters
		Constants.TileType.FACTORY:
			quantity_label.text = "%d/%d" % [GameState.nb_factories, GameState.max_factories]
			is_disabled = GameState.nb_factories == GameState.max_factories
		Constants.TileType.FURNACE:
			quantity_label.text = "%d/%d" % [GameState.nb_burners, GameState.max_burners]
			is_disabled = GameState.nb_burners == GameState.max_burners
		Constants.TileType.GOLD, Constants.TileType.IRON, Constants.TileType.SILICON, Constants.TileType.SILVER:
			quantity_label.text = "%d/%d" % [GameState.nb_extractors, GameState.max_extractors]
			is_disabled = GameState.nb_extractors == GameState.max_extractors
		Constants.TileType.RESELLER:
			quantity_label.text = "%d/%d" % [GameState.nb_sellers, GameState.max_sellers]
			is_disabled = GameState.nb_sellers == GameState.max_sellers
	if is_disabled:
		animation_player.play("Disabled")
	else:
		animation_player.play("Enabled")
			
func _on_LeftButton_click(el):
	current_type -= 1
	if current_type < 0:
		current_type = 0
	refresh_ui() 

func _on_RightButton_click(el):
	current_type += 1
	if current_type > Constants.TileType.keys().size() - 1:
		current_type = Constants.TileType.keys().size() - 1
	refresh_ui()
