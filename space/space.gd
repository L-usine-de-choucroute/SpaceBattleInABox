extends Node

class_name Space

@onready var space_base: Ship = $SpaceBase
@onready var cruiser: Ship = $Cruiser
@onready var frigate0: Ship = $Frigate0
@onready var frigate1: Ship = $Frigate1
@onready var fighter: Ship = $Fighter

var selected_layer := 0
@onready var layers: Array[Space_Layer] = [
	$SpaceLayer0,
	$SpaceLayer1,
	$SpaceLayer2,
	$SpaceLayer3,
	$SpaceLayer4,
]
var selected_tile = null
var ships_location: Ships_Location = load("uid://bpaamibusrgmd").new()

func _ready():
	select_layer(selected_layer)
	add_ship(space_base, 0, Vector2i(0, 0))
	add_ship(cruiser, 0, Vector2i(1, 0))
	add_ship(frigate0, 0, Vector2i(0, 1))
	add_ship(frigate1, 0, Vector2i(2, 0))
	add_ship(fighter, 0, Vector2i(0, 2))

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("switch_layer_up"): switch_to_layer_up()
	if event.is_action_pressed("switch_layer_down"): switch_to_layer_down()

func switch_to_layer_up(): select_layer(selected_layer + 1)
func switch_to_layer_down(): select_layer(selected_layer - 1)

func select_layer(layer: int):
	if (layer >= layers.size()): return
	if (layer < 0): return
	unfocus_layer(selected_layer)
	focus_layer(layer)
	selected_layer = layer

func focus_layer(layer: int):
	layers[layer].showGrid()
	var focusShip := ships_location.all_ship_in_layer(layer)
	for ship in focusShip:
		ship.focus()

func unfocus_layer(layer: int):
	layers[layer].hideGrid()
	var unfocusShip := ships_location.all_ship_in_layer(layer)
	for ship in unfocusShip:
		ship.unfocus()

func _on_space_layer_cell_clicked(layer_level: int, cell: Vector2i):
	if (selected_tile == null):
		select_tile(layer_level, cell)
	else:
		move_ship_at_selected_tile(layer_level, cell)
		unselect_tile()

func select_tile(target_layer: int, target_cell: Vector2i):
	selected_tile = Vector3i(target_cell.x, target_cell.y, target_layer)
	layers[target_layer].select_cell(target_cell)

func unselect_tile():
	if (selected_tile == null): return
	layers[selected_tile.z].unselect_cell(Vector2i(selected_tile.x, selected_tile.y))
	selected_tile = null

func move_ship_at_selected_tile(target_layer: int, target_cell: Vector2i):
	var selected_ship = get_ship_at_selected_tile()
	if (selected_ship == null): return
	move_ship(selected_ship, selected_tile, target_layer, target_cell)

func get_ship_at_selected_tile():
	return ships_location.get_ship(selected_tile.x, selected_tile.y, selected_tile.z)

func add_ship(ship: Ship, target_layer: int, target_cell: Vector2i):
	move_ship(ship, null, target_layer, target_cell)

func move_ship(ship: Ship, from, target_layer: int, target_cell: Vector2i):
	var target_position = layers[target_layer].get_parent_position_for_cell(target_cell)
	ship.set_at_position(target_layer, target_position)
	var isFocused = selected_layer == target_layer
	ship.update_focus(isFocused)
	ships_location.move_ship(ship, from, Vector3i(target_cell.x, target_cell.y, target_layer))
