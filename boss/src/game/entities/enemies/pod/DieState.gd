extends AbstractEnemyState

func enter() -> void:
	character._play_animation("die")
	character.dead = true
	character.collision_layer = 0
	character.collision_mask = 0
	
func _on_animation_finished(anim_name: String) ->  void:
	if anim_name in ["die_alert", "die"]:
		character._remove()
