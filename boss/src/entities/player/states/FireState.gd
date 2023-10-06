extends AbstractState


func enter() -> void:
	character._play_animation("fire")
	
func handle_event(event: String, value = null) -> void:
	match event:
		"hit":
			character._handle_hit(value)
			if character.dead:
				emit_signal("finished", "dead")


func _on_animation_finished(anim_name:String) -> void:
	emit_signal("finished", "idle")	
