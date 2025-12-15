extends Node2D

class_name Space_Layer

signal cell_clicked(layer_level: int, cell: Vector2i)

@export var layer_level = 0
@onready var selection_layer: Selected_Tile = $SelectedTile
@onready var grid: Space_Layer_Grid = $SpaceLayerGrid

func _unhandled_input(event: InputEvent):
	if (!grid.visible): return
	if event.is_action_pressed("select"): on_select_input(event)

func on_select_input(event: InputEvent):
	var target_cell = grid.get_cell_for_global_position(event.position)
	if (!grid.is_cell_in_layer_bounds(target_cell)): return
	cell_clicked.emit(layer_level, target_cell)

func get_parent_position_for_cell(cell: Vector2i) -> Vector2:
	return transform * grid.map_to_local(cell)

func hideGrid():
	grid.visible = false

func showGrid():
	grid.reset_highlight_cell()
	grid.visible = true

func select_cell(cell: Vector2i):
	selection_layer.select_cell(cell)

func unselect_cell(cell: Vector2i):
	selection_layer.unselect_cell(cell)
