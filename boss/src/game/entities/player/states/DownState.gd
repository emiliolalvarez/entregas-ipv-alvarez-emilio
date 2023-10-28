extends AbstractState
onready var collision_shape = $"../../CollisionShape2D"


func enter() -> void:
	character._play_animation("down")

	
func handle_input(event: InputEvent) -> void:
	if event.is_action_released("move_down"):
		emit_signal("finished", "idle")

func update(delta: float) -> void:
	character._handle_weapon_actions()
	character._handle_move_input()


