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

func _ready() -> void:
	move_ship(space_base, 0, Vector2i(0, 0))
	move_ship(cruiser, 0, Vector2i(1, 0))
	move_ship(frigate0, 0, Vector2i(0, 1))
	move_ship(frigate1, 0, Vector2i(2, 0))
	move_ship(fighter, 0, Vector2i(0, 2))

func _on_space_layer_cell_clicked(layer_level: int, cell: Vector2i) -> void:
	move_ship(fighter, layer_level, cell)

func move_ship(ship: Ship, layer_level: int, cell: Vector2i) -> void:
	var _position = layers[layer_level].get_parent_position_for_cell(cell)
	ship.set_at_position(layer_level, _position)
