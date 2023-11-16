extends AbstractEnemyState

func enter() -> void:
	#print("POD enter alert state")
	character.hud.hide()
	character.dead = true
	character.collision.disabled = true
	character.collision_layer = 0
	character.collision_mask = 0
	character._play_animation("die")

func exit() -> void:
	#print("POD exit alert state")
	pass
func _on_animation_finished(anim_name: String) ->  void:
	character._remove()
