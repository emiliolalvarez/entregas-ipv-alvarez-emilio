extends AbstractEnemyState

func enter() -> void:
	character.direction = character.directions.UP
		
func update(delta:float) -> void:
	if character.up_ray_cast.is_colliding():
		emit_signal("finished", "down")
	character._handle_move()
	
