extends AbstractEnemyState

func enter() -> void:
	print("POD enter alert state")
	character.hud.hide()
	character._play_animation("die")

func exit() -> void:
	print("POD exit alert state")
	
func _on_animation_finished(anim_name: String) ->  void:
	character._remove()
