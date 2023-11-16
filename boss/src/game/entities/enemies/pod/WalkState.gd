extends AbstractEnemyState

export (float) var speed:float
export (float) var max_speed:float




func enter() -> void:
	#print("POD enter walk state")
	character._play_animation("walk")


func exited() -> void:
	#print("POD exited walk state")
	pass
	
func update(delta:float) -> void:
	
	if character.target && abs(character.target.global_position.x - character.global_position.x) <= character.ATTACK_DISTANCE_THRESHOLD:
		emit_signal("finished", "alert")
	
	if character.navigation_agent != null:
		if character.navigation_agent.is_navigation_finished():
			emit_signal("finished", "alert")
		else:
			var direction:Vector2 = character.global_position.direction_to(
				character.navigation_agent.get_next_location()
			)
			var desired_velocity = direction * character.H_SPEED_LIMIT
			var steering = (desired_velocity - character.velocity) * delta * character.ACCELERATION
			character.velocity += steering 
			character._apply_movement()
