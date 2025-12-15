extends TileMapLayer

class_name Selected_Tile

var tile_set_id := tile_set.get_source_id(0)
const empty_tile_id := Vector2i(-1, -1)
const selected_tile_id := Vector2i(0, 0)

func select_cell(cell: Vector2i):
	set_cell(cell, tile_set_id, selected_tile_id, 0)

func unselect_cell(cell: Vector2i):
	set_cell(cell, tile_set_id, empty_tile_id, 0)
