extends AbstractEnemyState
onready var bean_start_timer = $"../BeanStartTimer"
onready var bean = $"../../Bean"
onready var bean_sound = $"../../BeanSound"

func enter() -> void:
	character.direction = character.directions.NONE
	character._play_animation("fire")
		
func _on_animation_finished(anim_name: String) ->  void:
	bean_start_timer.paused = false
	emit_signal("finished", "up")
	bean_sound.stop()
