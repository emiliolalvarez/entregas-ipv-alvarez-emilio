extends Node2D

onready var weapon_tip: Node2D = $WeaponTip
onready var weapon_tip_source: Node2D = $WeaponTipSource
onready var fire_sound = $Fire

export (PackedScene) var projectile_scene: PackedScene

var projectile_container: Node


## Acá solo me mantengo apuntando si tengo habilitada esa función.
## Esto es como corrección de apuntado para compensar por el delay
## aplicado por la animación de disparo.
func process_input() -> void:
	pass
	

func fire() -> void:
	var direction: Vector2 = global_position.direction_to(weapon_tip.global_position)
	#if global_scale.y < 0:
	#	direction *= -1
	fire_sound.play()
	projectile_scene.instance().initialize(
		projectile_container,
		weapon_tip.global_position,
		direction
	)
