extends AbstractEnemyState

export (float) var speed:float
export (float) var max_speed:float

var path: Array = []


func enter() -> void:
	character._play_animation("walk")


func exited() -> void:
	path = []
	
func update(delta:float) -> void:
	
	if character._can_see_target():
		print("I see you!")
#		emit_signal("finished", "alert")
	
	if character.navigation_agent != null:
		var direction:Vector2 = character.global_position.direction_to(
			character.navigation_agent.get_next_location()
		)
		var desired_velocity = direction * character.H_SPEED_LIMIT
		var steering = (desired_velocity - character.velocity) * delta * character.ACCELERATION
		character.velocity += steering 
		character._apply_movement()
	
	
func _handle_body_entered(body: Node) -> void:
	._handle_body_entered(body)
	#character._play_animation("alert")
	
func _handle_body_exited(body: Node) -> void:
	._handle_body_exited(body)
	#haracter._play_animation("walk")
	
func _on_amimation_finished(anim_name: String) -> void:
	match anim_name:
		"alert":
			character._play_animation("walk")
		"go_normal":
			character._play_animation("walk")
