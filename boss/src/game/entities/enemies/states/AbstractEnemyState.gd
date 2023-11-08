extends AbstractState
class_name  AbstractEnemyState

func handle_event(event: String, value = null) -> void:
	match event:
		"body_entered":
			_handle_body_entered(value)
		"body_exited":
			_handle_body_exited(value)
		"damage_received":
			_handle_damage_recieved(value)
		"fire_start":
			_handle_fire_start()

func _handle_body_entered(body: Node) -> void:
	if character.target == null:
		character.target = body
	emit_signal("finished", "walk")
	
func _handle_body_exited(body: Node) -> void:
	if body == character.target:
		character.target = null
	emit_signal("finished", "idle")

func _handle_damage_recieved(amount) -> void:
	character.life = max(0, character.life - 1)
	character.life_progress_bar.value = character.life
	if character.life == 0:
		emit_signal("finished", "die")

func _handle_fire_start() -> void:
	print("emit fire_start")
	emit_signal("finished", "fire_start")
