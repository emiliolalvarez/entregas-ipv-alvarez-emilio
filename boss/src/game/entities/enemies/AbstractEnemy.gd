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

## Esta función ya no llama directamente a remove, sino que inhabilita las
## colisiones con el mundo, pausa todo lo demás y ejecuta una animación de muerte
## dependiendo de si el enemigo esta o no alerta
func notify_hit(amount:int = 1) -> void:
	emit_signal("hit", amount)
