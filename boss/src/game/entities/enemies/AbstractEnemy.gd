extends KinematicBody2D

class_name AbstractEnemy

## Flag de ayuda para saber identificar el estado de actividad
var dead: bool = false

signal hit(amount)
signal die()

func _remove() -> void:
	GameState.update_score(_get_points())
	hide()
	set_physics_process(false)
	get_parent().remove_child(self)
	queue_free()
	emit_signal("die")
	
func _get_points() -> int:
	return 1

func notify_hit(amount:int = 1) -> void:
	emit_signal("hit", amount)

func _on_collision_area_body_enter(body):
	if body.has_method('notify_enemy_collision'):
		body.notify_enemy_collision(_get_collision_damage())
		
func _get_collision_damage() -> int:
	return 1
