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
var selected_tile

var ships: Dictionary[int, Ship]
func getShip(x: int, y: int, z: int):
	return ships.get(x + y * 5 + z * 25)
func setShip(item: Ship, x: int, y: int, z: int):
	ships[x + y * 5 + z * 25] = item

func _ready():
	layers[selected_layer].showGrid()
	move_ship(space_base, 0, Vector2i(0, 0))
	move_ship(cruiser, 0, Vector2i(1, 0))
	move_ship(frigate0, 0, Vector2i(0, 1))
	move_ship(frigate1, 0, Vector2i(2, 0))
	move_ship(fighter, 0, Vector2i(0, 2))

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("switch_layer_up"): on_switch_layer_up_input()
	if event.is_action_pressed("switch_layer_down"): on_switch_layer_down_input()

func on_switch_layer_up_input():
	if (selected_layer >= layers.size()-1): return
	layers[selected_layer].hideGrid()
	layers[selected_layer+1].showGrid()
	selected_layer += 1

func on_switch_layer_down_input():
	if (selected_layer <= 0): return
	layers[selected_layer].hideGrid()
	layers[selected_layer-1].showGrid()
	selected_layer -= 1

func _on_space_layer_cell_clicked(layer_level: int, cell: Vector2i):
	if (selected_tile == null):
		selected_tile = Vector3i(cell.x, cell.y, layer_level)
		layers[layer_level].select_cell(cell)
	else:
		var selected_ship = getShip(selected_tile.x, selected_tile.y, selected_tile.z)
		if (selected_ship != null):
			move_ship(selected_ship, layer_level, cell)
		layers[selected_tile.z].unselect_cell(Vector2i(selected_tile.x, selected_tile.y))
		selected_tile = null

func move_ship(ship: Ship, layer_level: int, cell: Vector2i):
	var layer = layers[layer_level]
	var _position = layer.get_parent_position_for_cell(cell)
	ship.set_at_position(layer_level, _position)
	if (selected_tile != null):
		setShip(null, selected_tile.x, selected_tile.y, selected_tile.z)
	setShip(ship, cell.x, cell.y, layer_level)
