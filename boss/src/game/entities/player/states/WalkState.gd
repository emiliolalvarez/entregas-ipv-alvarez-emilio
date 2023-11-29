extends AbstractState


# Al entrar se activa primero la animación "walk"
func enter() -> void:
	character._play_animation("walk")

func handle_input(event:InputEvent) -> void:
	if event.is_action_pressed("move_down") && character._is_robot_mode() && character.is_on_floor():
		emit_signal("finished", "down")
	if event.is_action_pressed("jump") && character.is_on_floor():
		emit_signal("finished", "jump")
	if event.is_action_pressed("move_up") && character.is_on_floor():
		emit_signal("finished", "aim_up_walk")
	if event.is_action_pressed("change_mode"):
		emit_signal("finished", "plane")
	if event.is_action_pressed("fire_weapon"):
		character._handle_weapon_actions()	

# En esta función vamos a manejar las acciones apropiadas para este estado
func update(delta: float) -> void:
	# Vamos a manejar los inputs de movimiento
	character._handle_move_input()
	# Aplicar ese movimiento, sin desacelerar
	character._apply_movement()
	# Y luego chequeamos si se quedó quieto el personaje
	if character.move_direction == 0:
		# Y cambiamos el estado a idle
		emit_signal("finished", "idle")
	else:
		# O aplicamos la animación que corresponde
		if character.is_on_floor():
			character._play_animation("walk")
		else:
			if character.velocity.y > 0:
				character._play_animation("fall")
			else:
				character._play_animation("jump")


