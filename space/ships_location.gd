class_name Ships_Location

@export var layer_count := 5
@export var layer_size := 5

var _ships: Dictionary[int, Ship]

func get_index(x: int, y: int, z: int) -> int:
	return x + y * layer_size + z * layer_size * layer_count

func get_ship(x: int, y: int, z: int):
	return _ships.get(get_index(x, y, z))
	
func set_ship(item: Ship, x: int, y: int, z: int):
	_ships[get_index(x, y, z)] = item

func move_ship(item: Ship, from, to: Vector3i):
	if (from != null):
		set_ship(null, from.x, from.y, from.z)
	set_ship(item, to.x, to.y, to.z)

func all_ship_in_layer(z: int) -> Array[Ship]:
	var array: Array[Ship] = []
	for x in range(layer_size):
		for y in range(layer_size):
			var ship = _ships.get(get_index(x, y, z))
			if (ship != null):
				array.append(ship)
	return array
