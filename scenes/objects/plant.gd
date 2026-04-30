extends StaticBody2D

var coord: Vector2i

# Se calcula la posición y se añade al nodo padre un hijo, que es la planta
func setup(grid_coord: Vector2i, parent: Node2D):
	position = grid_coord * Data.TILE_SIZE + Vector2i(8, 5)
	parent.add_child(self)
	coord = grid_coord
