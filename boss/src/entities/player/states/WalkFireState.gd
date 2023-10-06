extends AbstractState


func enter() -> void:
	character._play_animation("walk_fire")
	character._handle_weapon_actions()


func handle_input(event:InputEvent) -> void:
	if event.is_action_pressed("move_up") && character.is_on_floor():
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
		emit_signal("finished", "idle")
	else:
		# O aplicamos la animación que corresponde
		if character.is_on_floor():
			character._play_animation("walk_fire")
		else:
			if character.velocity.y > 0:
				character._play_animation("fall")
			else:
				character._play_animation("jump")

func handle_event(event: String, value = null) -> void:
	match event:
		"hit":
			character._handle_hit(value)
			if character.dead:
				emit_signal("finished", "dead")

