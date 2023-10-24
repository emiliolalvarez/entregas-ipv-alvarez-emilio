extends AbstractState


func enter() -> void:
	character._play_animation("fire")
	
func handle_input(event:InputEvent) -> void:
	if event.is_action_pressed("move_down") && character._is_robot_mode():
		emit_signal("finished", "down")
	
func _on_animation_finished(anim_name:String) -> void:
	if (anim_name == "fire"):
		character._handle_weapon_actions()
	emit_signal("finished", "idle")	
