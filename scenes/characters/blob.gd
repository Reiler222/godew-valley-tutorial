extends CharacterBody2D

# Script para el enemigo

var direction: Vector2
var speed := 20
var push_distance := 200
var push_direction: Vector2
var health := 3:
	set(value):
		health = value
		if health <= 0:
			death()

## Obtenemos el arbol de la escena y cogemos al primer nodo del grupo Player
@onready var player = get_tree().get_first_node_in_group("Player")

## Persecucion del personaje y empuje con push_direciton
func _physics_process(delta: float) -> void:
	direction = (player.position - position).normalized()
	velocity = direction * speed + push_direction
	move_and_slide()
	

## Se crea tween para empujar al enemigo
func push():
	var tween = get_tree().create_tween()
	var target = (player.position - position).normalized() * -1 * push_distance
	tween.tween_property(self, "push_direction", target, 0.1)
	tween.tween_property(self, "push_direction", Vector2.ZERO, 0.2)
	
func death():
	speed = 0
	$AnimationPlayer.current_animation = "explode"

func hit(tool: Enum.Tool):
	if tool == Enum.Tool.SWORD:
		$FlashSprite.flash()
		push()
		health -= 1
	
