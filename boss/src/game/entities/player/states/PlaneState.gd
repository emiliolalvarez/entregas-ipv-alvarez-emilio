extends AbstractState


func enter() -> void:
	character.snap_vector = Vector2.ZERO
	character._set_plane_mode()
	character._play_animation("plane")
	do_move_up()
	
func exit() -> void:
	character._set_robot_mode()
	
func do_move_up() -> void:
	character.velocity.y -= character.jump_speed
	
func do_move_down() -> void:
	character.velocity.y += character.jump_speed
	
func handle_input(event:InputEvent) -> void:
	if event.is_action_pressed("fire_weapon") && character.is_on_floor():
		character._handle_weapon_actions()
	if event.is_action_pressed("change_mode"):
		character._set_robot_mode()
		character._play_animation("robot")
	
func update(delta: float) -> void:
	character._handle_weapon_actions()
	character._handle_move_input()
	if character.move_vertical_direction == 0:
		character._handle_vertical_deacceleration()
	character._apply_movement()


func handle_event(event: String, value = null) -> void:
	match event:
		"hit":
			character._handle_hit(value)
			if character.dead:
				emit_signal("finished", "dead")
				
func _on_animation_finished(anim_name:String) -> void:
	if (anim_name == 'robot'):
		emit_signal("finished", "idle")

