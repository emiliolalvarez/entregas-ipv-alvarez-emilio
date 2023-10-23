extends AbstractState


func enter() -> void:
	character._play_animation("aim_up")
	
func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("move_down"):
		emit_signal("finished", "down")
	if event.is_action_released("move_up"):
		emit_signal("finished", "idle")
	if (Input.is_action_pressed("move_up") && (event.is_action_pressed("move_left") || event.is_action_pressed("move_right"))):
		emit_signal("finished", "aim_up_walk")
	if (!Input.is_action_pressed("move_up") && (event.is_action_pressed("move_left") || event.is_action_pressed("move_right")) && character.is_on_floor()):
		emit_signal("finished", "walk")
	if event.is_action_pressed("change_mode"):
		character._set_plane_mode()
		emit_signal("finished", "plane")

func update(delta: float) -> void:
	character._handle_weapon_actions()
	character._handle_move_input()


