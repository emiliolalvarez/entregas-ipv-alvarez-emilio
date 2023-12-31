extends AbstractStateMachine

class_name BattlePodStateMachine

## Flag de ayuda para saber identificar el estado de actividad
var dead: bool = false


func _on_DetectionArea_body_entered(body):
	current_state.handle_event("body_entered", body)

func _on_DetectionArea_body_exited(body):
	current_state.handle_event("body_exited", body)

func _on_damage_received(amount):
	current_state.handle_event("damage_received", amount)
