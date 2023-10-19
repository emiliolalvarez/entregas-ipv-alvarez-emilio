extends AbstractStateMachine

## Flag de ayuda para saber identificar el estado de actividad
var dead: bool = false


func _on_DetectionArea_body_entered(body):
	current_state.handle_event("body_entered", body)


func _on_DetectionArea_body_exited(body):
	current_state.handle_event("body_exited", body)


func _on_Body_animation_finished():
	_on_animation_finished(character.get_current_animation()) # Replace with function body.

func notify_hit(amount) -> void:
	if current_state != $Die:
		_change_state("die")
