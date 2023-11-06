extends AbstractEnemyState

func enter() -> void:
	character.hud.hide()
	character._play_animation("die")
	
func _on_animation_finished(anim_name: String) ->  void:
	print("removing boss battle ship")
	character._remove()
