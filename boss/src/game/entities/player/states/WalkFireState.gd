extends AbstractState

var can_fire = false

func enter() -> void:
	character._play_animation("walk_fire")
	$WalkFireTimer.wait_time = 0.2
	$WalkFireTimer.connect("timeout", self, "on_walkfire_timer_timeout")
	$WalkFireTimer.start()
	
func exit() -> void:
	can_fire = false

func handle_input(event:InputEvent) -> void:
	if (event.is_action_released("move_left") && event.is_action_released("move_right")) &&  event.is_action_pressed("move_up") && character._is_robot_mode():
		emit_signal("finished", "aim_up")
	if (event.is_action_pressed("move_left") || event.is_action_pressed("move_right")) &&  event.is_action_pressed("move_up") && character._is_robot_mode():
		emit_signal("finished", "aim_up_walk")
	if event.is_action_pressed("move_down") && character._is_robot_mode():
		emit_signal("finished", "down")
	if event.is_action_pressed("jump") && character.is_on_floor():
		emit_signal("finished", "jump")
	if event.is_action_pressed("change_mode"):
		character._set_plane_mode()
		emit_signal("finished", "plane")
	

func update(delta: float) -> void:
	if (can_fire):
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

func on_walkfire_timer_timeout() -> void:
	character.weapon.fire()
	can_fire = true
	
