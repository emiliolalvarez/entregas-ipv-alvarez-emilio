extends AbstractState


var direction: int;

const ROBOT_MOVE_SPEED = 50
const PLANE_MOVE_SPEED = 100

onready var collide_timer = $CollideTimer

# Al entrar se activa primero la animación "idle"
func enter() -> void:
	collide_timer.connect("timeout", self, "on_collide_timer_timeout")
	collide_timer.wait_time = 1
	direction = character.get_direction()
	collide_timer.start()
	if character._is_robot_mode():
		character._play_animation("collide")	
	else: 
		character._play_animation("collide_plane")
	
	
func exit() -> void:
	collide_timer.stop()

func handle_input(event:InputEvent) -> void:
	if event.is_action_pressed("fire_weapon"):
		character._handle_weapon_actions()
	if event.is_action_pressed("move_down") && character._is_robot_mode() && character.is_on_floor():
		emit_signal("finished", "down")
	if event.is_action_pressed("jump") && character.is_on_floor():
		emit_signal("finished", "jump")

# En esta función vamos a manejar las acciones apropiadas para este estado
func update(delta: float) -> void:
#	var move_speed = PLANE_MOVE_SPEED if character._is_plane_mode() else ROBOT_MOVE_SPEED
#	var backward_vector = Vector2(-1 if character.get_direction() == 1 else 1, 0)  # Adjust this vector for the backward movement
#	var movement = backward_vector * move_speed * delta
#	character.position += movement
	var move_speed = PLANE_MOVE_SPEED if character._is_plane_mode() else ROBOT_MOVE_SPEED
	var backward_vector = Vector2(-1 if character.get_direction() == 1 else 1, 0)  # Adjust this vector for the backward movement
	var movement = backward_vector * move_speed

	# Modify the character's velocity instead of directly changing position
	character.velocity = movement

	# Apply the velocity using move_and_slide()
	character.velocity = move_and_slide(character.velocity)

func on_collide_timer_timeout() -> void:
	if character._is_robot_mode():
		emit_signal("finished", "idle")	
	else: 
		emit_signal("finished", "plane")	
