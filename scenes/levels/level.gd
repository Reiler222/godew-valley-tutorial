extends Node2D

var plant_scene = preload("res://scenes/objects/plant.tscn")

# Cuando el personaje usa una herramienta, se calcula la coordenada donde se usa (util solo para X herramientas)
# el resto es un switch case para evaluar la herramienta usada y actuar en consecuencia.
func _on_player_tool_use(tool: int, pos: Vector2) -> void:
	var grid_coord: Vector2i = Vector2i(pos.x / Data.TILE_SIZE, pos.y / Data.TILE_SIZE)
	var has_soil = grid_coord in $Layers/SoilLayer.get_used_cells()
	match tool:
		Enum.Tool.HOE:
			var cell = $Layers/GrassLayer.get_cell_tile_data(grid_coord) as TileData
			if cell and cell.get_custom_data("farmable"):
				$Layers/SoilLayer.set_cells_terrain_connect([grid_coord], 0, 0)
		Enum.Tool.WATER:
			if grid_coord in $Layers/SoilLayer.get_used_cells():
				$Layers/SoilWaterLayer.set_cell(grid_coord,0 , Vector2i(randi_range(0,2), 0))
		Enum.Tool.FISH:
			if not has_soil:
				print("fishing")
			else:
				print("not fishing")
		Enum.Tool.SEED:
			if has_soil:
				var plant = plant_scene.instantiate()
				plant.setup(grid_coord, $Objects)
			pass
		Enum.Tool.AXE, Enum.Tool.SWORD:
			for object in get_tree().get_nodes_in_group("Objects"):
				if object.position.distance_to(pos) < 20:
					object.hit(tool)
