@tool
extends StaticBody2D

@export var is_random: bool
# En estos dos exports, seteamos el valor para que se actualice dinamicamente en el 
# propio editor de Godot. Si no lo ves, despliega el código coño.
@export_range(0, 3, 1) var size: int:
	set(value):
		size = value
		$Sprite2D.frame_coords = Vector2i(size, style)
@export_enum("Bush", "Stone") var style: int:
	set(value):
		style = value
		$Sprite2D.frame_coords = Vector2i(size, style)

# Creamos un boton para este objeto, que aparece con el resto de exports. Primero le damos
# nombre e icono, y luego declaramos variable y seteamos el nombre de la funcion que llamará.
@export_tool_button("Randomize Texture", "RandomNumberGenerator") var randomizer = randomize

func _ready() -> void:
	if is_random:
		size = randi_range(0, $Sprite2D.hframes - 1)
		#style = [0,1].pick_random()
	$Sprite2D.frame_coords = Vector2i(size, style)

func randomize():
	size = randi_range(0, $Sprite2D.hframes - 1)
	style = [0,1].pick_random()
	$Sprite2D.frame_coords = Vector2i(size, style)
