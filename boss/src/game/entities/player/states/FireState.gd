extends AbstractState


func enter() -> void:
	character._play_animation("fire")
	
func _on_animation_finished(anim_name:String) -> void:
	if (anim_name == "fire"):
		character._handle_weapon_actions()
	emit_signal("finished", "idle")	
