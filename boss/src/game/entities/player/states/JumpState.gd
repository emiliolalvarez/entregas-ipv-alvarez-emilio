extends AbstractState

export (int) var jumps_limit: int = 2
export (float) var time_to_jump_peak = .5
export (int) var jump_height = 128


var jumps = 0
var GRAVITY: float
var JUMPSPEED: float

func enter() -> void:
	character.snap_vector = Vector2.ZERO
	GRAVITY = (2 * jump_height)/pow(time_to_jump_peak, 2)
	JUMPSPEED = GRAVITY * time_to_jump_peak
	do_jump()
	
func exit() -> void:
	jumps = 0
	
func handle_input(event:InputEvent) -> void:
	if event.is_action_pressed("jump") && jumps < jumps_limit:
		jumps += 1
		do_jump()

func do_jump() -> void: 
	character.velocity.y -= (JUMPSPEED if jumps == 0 else JUMPSPEED/2)
	character._play_animation("jump")

func update(delta: float) -> void:
	character._handle_weapon_actions()
	character._handle_move_input()
	if character.move_direction == 0:
		character._handle_deacceleration()
	character._apply_movement()
	if character.is_on_floor():
		if character.move_direction == 0: 
			emit_signal("finished", "idle")
		else: 
			emit_signal("finished", "walk")
	elif character.velocity.y > 0:
		character._play_animation("fall")

