extends AbstractEnemyState
onready var explossion = $"../../Explossion"


signal die_state_entered()

func enter() -> void:
	#print("POD enter alert state")
	character.hud.hide()
	character.dead = true
	character._play_animation("die")
	explossion.play()
	if character.target:
		var x_abs_position_diff = abs(character.target.global_position.x - character.global_position.x)
		var y_abs_position_diff = abs(character.target.global_position.y - character.global_position.y)
		if y_abs_position_diff <= character.EXPLODE_DISTANCE_THRESHOLD && x_abs_position_diff <= character.EXPLODE_DISTANCE_THRESHOLD && character.target:
			character._on_collision_area_body_enter(character.target)
	emit_signal("die_state_entered")
	
func exit() -> void:
	#print("POD exit alert state")
	pass

func _on_animation_finished(anim_name: String) ->  void:
	._on_animation_finished(anim_name)
	character._remove()

func _get_score() -> int:
	return 10	
