extends AbstractEnemyState

func enter() -> void:
	print("POD enter Idle state")
	character.velocity = Vector2.ZERO
	character._play_animation("idle")

func exit() -> void: 
	print("POD exited Idle state")	
	
func update(delta:float) -> void:
	character._apply_movement()
	if character._can_see_target():
		emit_signal("finished", "walk")
