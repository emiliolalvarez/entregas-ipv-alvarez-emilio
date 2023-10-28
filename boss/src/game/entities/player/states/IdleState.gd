extends AbstractState


# Al entrar se activa primero la animación "idle"
func enter() -> void:
	character._play_animation("idle")

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("move_up") && character._is_robot_mode() && character.is_on_floor():
		emit_signal("finished", "aim_up")
	if event.is_action_pressed("move_down") && character._is_robot_mode() && character.is_on_floor():
		emit_signal("finished", "down")
	if event.is_action_pressed("jump") && character.is_on_floor():
		emit_signal("finished", "jump")
	if event.is_action_pressed("fire_weapon") && character.is_on_floor():
		emit_signal("finished", "fire")
	if event.is_action_pressed("change_mode"):
		character._set_plane_mode()
		emit_signal("finished", "plane")

# En esta función vamos a manejar las acciones apropiadas para este estado
func update(delta: float) -> void:
	# Vamos a permitir detectar inputs de movimiento
	character._handle_move_input()
	# Para chequear si se realiza un movimiento
	if character.move_direction != 0:
		# Y cambiamos el estado a walk
		emit_signal("finished", "walk")
	else:
		# Si no se realiza movimiento, desaceleramos y manejamos movimiento
		character._handle_deacceleration()
		character._apply_movement()
		
		# Y aplicamos la animación apropiada, ya sea idle o saltar/caer
		if character.is_on_floor():
			character._play_animation("idle")
		else:
			if character.velocity.y > 0:
				character._play_animation("fall")
			else:
				character._play_animation("jump")


