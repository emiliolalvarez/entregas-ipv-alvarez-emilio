extends AbstractEnemyState
onready var hud = $"../../Pivot/HUD"
func enter() -> void:
	hud.hide()
	character._play_animation("die")
	character.dead = true
	character.collision_layer = 0
	character.collision_mask = 0
	
	if character.target != null:
		character._play_animation("die_alert")
	else:
		character._play_animation("die")
	
	
func _on_animation_finished(anim_name: String) ->  void:
	print("removing soldier")
	character._remove()
