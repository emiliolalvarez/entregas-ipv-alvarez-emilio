extends AbstractState

onready var collision_shape = $"../../CollisionShape2D"
var original_h_speed: float
var original_collision_shape_scale_y: float


func enter() -> void:
	print("Enter plane mode => is robot mode: " + String(character._is_robot_mode()))
	original_h_speed = character.H_SPEED_LIMIT
	original_collision_shape_scale_y = collision_shape.scale.y
	character.snap_vector = Vector2.ZERO
	character.H_SPEED_LIMIT += original_h_speed * 1.25
	if (character._is_robot_mode()):	
		character._set_plane_mode()
		character._play_animation("plane")
		do_move_up()
	
func exit() -> void:
	collision_shape.scale.y = original_collision_shape_scale_y
	character.H_SPEED_LIMIT = original_h_speed
	
	
func do_move_up() -> void:
	character.velocity.y -= character.jump_speed
	
func do_move_down() -> void:
	character.velocity.y += character.jump_speed
	
func handle_input(event:InputEvent) -> void:
	if event.is_action_pressed("fire_weapon") && character.is_on_floor():
		character._handle_weapon_actions()
	if event.is_action_pressed("change_mode") && !character.force_plane:
		character._set_robot_mode()
		character._play_animation("robot")
	
func update(delta: float) -> void:
	character._handle_weapon_actions()
	character._handle_move_input()
	if character.move_vertical_direction == 0:
		character._handle_vertical_deacceleration()
	character._apply_movement()

				
func _on_animation_finished(anim_name:String) -> void:
	if (anim_name == 'robot'):
		emit_signal("finished", "idle")

