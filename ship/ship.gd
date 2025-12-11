extends Sprite2D

class_name Ship
	
func set_at_position(layer: int, pos: Vector2):
	position = pos
	z_index = 2 * layer + 1
