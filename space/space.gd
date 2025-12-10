extends Node

class_name Space

const layer_size = 5
@onready var ship: Ship = $Ship
@onready var layers: Array[Space_Layer] = [
	$SpaceLayer0,
	$SpaceLayer1,
	$SpaceLayer2,
	$SpaceLayer3,
	$SpaceLayer4,
]

func _ready() -> void:
	var _position = layers[0].get_parent_position_for_cell(Vector2i(0, 0))
	ship.set_at_position(0, _position)
	pass

func _on_space_layer_cell_clicked(layer_level: int, cell: Vector2i) -> void:
	var _position = layers[layer_level].get_parent_position_for_cell(cell)
	ship.set_at_position(layer_level, _position)
