extends AbstractEnemyState

var can_fire = true
onready var fire_timer = $FireTimer
onready var fire_sound = $"../../Fire"

func enter() -> void:
	character.velocity = Vector2.ZERO
	fire_timer.wait_time = 2
	fire_timer.connect("timeout", self, "on_fire_timer_timeout")
	fire_timer.start()
	fire()
	
func exit() -> void:
	fire_timer.stop()
	
func fire() -> void:
	if (can_fire):
		can_fire = false
		character._fire()
		fire_sound.play()
		
	character._play_animation("attack")
		

func update(delta:float) -> void:
	character._look_at_target()


func _on_animation_finished(anim_name: String) ->  void:
	if character.target == null:
		emit_signal("finished", "idle")
	else:
		match anim_name:
			"attack":
				character._play_animation("alert")
			"alert":
				if character._can_see_target():
					fire()
				else:
					emit_signal("finished", "idle")

func _handle_body_exited(node: Node) -> void:
	._handle_body_exited(node)
	if character.target == null:
		if character.get_current_animation() != "attack":
			emit_signal("finished", "idle")

func on_fire_timer_timeout() -> void:
	can_fire = true
