extends TileMapLayer

class_name Space_Layer_Grid

signal cell_clicked(layer_level: int, cell: Vector2i)

@export var layer_level = 0
var tile_set_id := tile_set.get_source_id(0)
const default_tile_id := Vector2i(1, 0)
const highlighted_tile_id := Vector2i(2, 0)
const layer_size := 5
var highlighted_cell = null
@onready var global_to_local_position_transform := get_global_transform_with_canvas()

func _unhandled_input(event: InputEvent):
	if (!visible): return
	if event is InputEventMouseMotion: on_mouse_motion(event)
	if event.is_action_pressed("select"): on_select_input(event)

func on_mouse_motion(event: InputEventMouseMotion):
	var target_cell = get_cell_for_global_position(event.position)
	if (!is_cell_in_layer_bounds(target_cell)): return
	update_highlight_cell(target_cell)

func on_select_input(event: InputEvent):
	var target_cell = get_cell_for_global_position(event.position)
	if (!is_cell_in_layer_bounds(target_cell)): return
	cell_clicked.emit(layer_level, target_cell)

func get_cell_for_global_position(_global_position: Vector2) -> Vector2i:
	var local_position = global_to_local_position(_global_position)
	return local_to_map(local_position)

func global_to_local_position(_global_position: Vector2) -> Vector2:
	return _global_position * global_to_local_position_transform

func update_highlight_cell(target_cell: Vector2i):
	if (target_cell != highlighted_cell):
		if (highlighted_cell != null):
			unhighlight_cell(highlighted_cell)
		highlight_cell(target_cell)
		highlighted_cell = target_cell

func reset_highlight_cell():
	if (highlighted_cell == null): return
	unhighlight_cell(highlighted_cell)
	highlighted_cell = null

func highlight_cell(cell: Vector2i):
	set_cell(cell, tile_set_id, highlighted_tile_id, 0)

func unhighlight_cell(cell: Vector2i):
	set_cell(cell, tile_set_id, default_tile_id, 0)

func is_cell_in_layer_bounds(cell: Vector2i) -> bool:
	return cell.x >= 0 and cell.x < layer_size and cell.y >= 0 and cell.y < layer_size

func get_parent_position_for_cell(cell: Vector2i) -> Vector2:
	return transform * map_to_local(cell)
