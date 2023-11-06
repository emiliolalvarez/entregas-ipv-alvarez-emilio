extends AbstractEnemyState

func enter() -> void:
	character.direction = character.directions.DOWN
		
func update(delta:float) -> void:
	if character.down_ray_cast.is_colliding():
		emit_signal("finished", "up")
	character._handle_move()
	
