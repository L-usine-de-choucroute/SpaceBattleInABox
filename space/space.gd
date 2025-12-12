extends Node

class_name Space

const layer_size = 5
@onready var space_base: Ship = $SpaceBase
@onready var cruiser: Ship = $Cruiser
@onready var frigate0: Ship = $Frigate0
@onready var frigate1: Ship = $Frigate1
@onready var fighter: Ship = $Fighter
@onready var layers: Array[Space_Layer] = [
	$SpaceLayer0,
	$SpaceLayer1,
	$SpaceLayer2,
	$SpaceLayer3,
	$SpaceLayer4,
]
var selected_layer := 0

func _ready():
	layers[selected_layer].visible = true
	move_ship(space_base, 0, Vector2i(0, 0))
	move_ship(cruiser, 0, Vector2i(1, 0))
	move_ship(frigate0, 0, Vector2i(0, 1))
	move_ship(frigate1, 0, Vector2i(2, 0))
	move_ship(fighter, 0, Vector2i(0, 2))

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("switch_layer_up"): on_switch_layer_up_input()
	if event.is_action_pressed("switch_layer_down"): on_switch_layer_down_input()

func on_switch_layer_up_input():
	if (selected_layer == layer_size-1): return
	layers[selected_layer].visible = false
	layers[selected_layer+1].visible = true
	selected_layer += 1

func on_switch_layer_down_input():
	if (selected_layer == 0): return
	layers[selected_layer].visible = false
	layers[selected_layer-1].visible = true
	selected_layer -= 1

func _on_space_layer_cell_clicked(layer_level: int, cell: Vector2i):
	move_ship(fighter, layer_level, cell)

func move_ship(ship: Ship, layer_level: int, cell: Vector2i):
	var _position = layers[layer_level].get_parent_position_for_cell(cell)
	ship.set_at_position(layer_level, _position)
