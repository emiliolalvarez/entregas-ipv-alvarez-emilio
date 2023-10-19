extends AbstractState


func enter() -> void:
	character._play_animation("aim_up")
	
func handle_input(event: InputEvent) -> void:
	if event.is_action_released("move_up"):
		emit_signal("finished", "idle")
	if (event.is_action_pressed("move_left") || event.is_action_pressed("move_right")) && character.is_on_floor():
		print("changing to aim up walk")
		emit_signal("finished", "aim_up_walk")
	if event.is_action_pressed("jump") && character.is_on_floor():
		emit_signal("finished", "jump")
	if event.is_action_pressed("change_mode"):
		character._set_plane_mode()
		emit_signal("finished", "plane")

func update(delta: float) -> void:
	character._handle_weapon_actions()

func handle_event(event: String, value = null) -> void:
	match event:
		"hit":
			character._handle_hit(value)
			if character.dead:
				emit_signal("finished", "dead")

