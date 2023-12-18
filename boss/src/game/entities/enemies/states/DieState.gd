extends AbstractEnemyState
onready var hud = $"../../Pivot/HUD"
onready var explosion_sound = $"../../Explosion"

func enter() -> void:
	hud.hide()
	character._play_animation("die")
	explosion_sound.play()
	character.dead = true
	character.collision_layer = 0
	character.collision_mask = 0
	
func _on_animation_finished(anim_name: String) ->  void:
	#print("removing soldier")
	character._remove()
