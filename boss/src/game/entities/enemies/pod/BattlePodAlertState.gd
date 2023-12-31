extends AbstractEnemyState
onready var timer:Timer = $Timer

func enter() -> void:
	#print("POD enter alert state")
	character.velocity = Vector2.ZERO
	character._play_animation("alert")
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.start()
	_do_fire()
	
func update(delta:float) -> void:
	character._look_at_target()
	
func exit() -> void:
	timer.stop()
		
func _should_fire() -> bool:
	var abs_position_diff = abs(character.target.global_position.x - character.global_position.x)
	return abs_position_diff <= character.ATTACK_DISTANCE_THRESHOLD

func _should_explode() -> bool:
	var abs_x_position_diff = abs(character.target.global_position.x - character.global_position.x)
	var abs_y_position_diff = abs(character.target.global_position.y - character.global_position.y)
	return character.target \
		&& character.target.is_on_floor() \
		&& abs_y_position_diff <= character.EXPLODE_DISTANCE_THRESHOLD \
		&& abs_x_position_diff <= character.EXPLODE_DISTANCE_THRESHOLD 

func _do_fire() -> void:
	character._fire()
		
func _on_timer_timeout() -> void:
	if _should_explode():
		emit_signal("finished", "explode")
	elif _should_fire():
		_do_fire()
	else:
		emit_signal("finished", "walk")
