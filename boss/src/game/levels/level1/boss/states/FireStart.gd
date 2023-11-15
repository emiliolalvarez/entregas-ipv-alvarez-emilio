extends AbstractEnemyState
onready var bean_start_timer = $"../BeanStartTimer"
onready var bean_sound = $"../../BeanSound"

func enter() -> void:
	bean_start_timer.paused = true
	character.direction = character.directions.NONE
	character._play_animation("fire_start")
	bean_sound.play()
		
func update(delta:float) -> void:
	pass

func _on_animation_finished(anim_name: String) ->  void:
	emit_signal("finished", "fire")
