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
	#print("POD exited alert state")
	timer.stop()
		
func _should_fire() -> bool:
	var abs_position_diff = abs(character.target.global_position.x - character.global_position.x)
	return abs_position_diff <= character.ATTACK_DISTANCE_THRESHOLD

func _do_fire() -> void:
	character._fire()
		
func _on_timer_timeout() -> void:
	if _should_fire():
		_do_fire()
