extends AbstractStateMachine

func _on_DetectionArea_body_entered(body):
	current_state.handle_event("body_entered", body)


func _on_DetectionArea_body_exited(body):
	current_state.handle_event("body_exited", body)


func _on_Body_animation_finished():
	_on_animation_finished(character.get_current_animation()) # Replace with function body.

func _on_damage_received(amount):
	current_state.handle_event("damage_received", amount)
