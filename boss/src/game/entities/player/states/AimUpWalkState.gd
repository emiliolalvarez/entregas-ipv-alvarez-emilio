extends AbstractState


func enter() -> void:
	character._play_animation("aim_up_walk")

func handle_input(event:InputEvent) -> void:
	if event.is_action_pressed("move_down") && character._is_robot_mode():
		emit_signal("finished", "down")
	if (event.is_action_released("move_up") && (Input.is_action_pressed("move_left") || Input.is_action_pressed("move_right"))):
		emit_signal("finished", "walk")
	if (event.is_action_pressed("move_up") && (Input.is_action_released("move_left") && Input.is_action_released("move_right"))):
		emit_signal("finished", "aim_up")	
	if event.is_action_pressed("jump") && character.is_on_floor():
		emit_signal("finished", "jump")
	if event.is_action_pressed("change_mode"):
		character._set_plane_mode()
		emit_signal("finished", "plane")
	
func update(delta: float) -> void:
	character._handle_weapon_actions()
	# Vamos a manejar los inputs de movimiento
	character._handle_move_input()
	# Aplicar ese movimiento, sin desacelerar
	character._apply_movement()
	# Y luego chequeamos si se quedó quieto el personaje
	if character.move_direction == 0:
		# Y cambiamos el estado a idle
		emit_signal("finished", "aim_up")
	else:
		# O aplicamos la animación que corresponde
		if character.is_on_floor():
			character._play_animation("aim_up_walk")
		else:
			if character.velocity.y > 0:
				character._play_animation("fall")
			else:
				character._play_animation("jump")


