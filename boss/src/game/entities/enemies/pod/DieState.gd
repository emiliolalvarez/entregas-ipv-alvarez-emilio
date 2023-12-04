extends AbstractEnemyState

onready var explossion_sound = $"../../Explossion"


func enter() -> void:
	#print("POD enter alert state")
	character.hud.hide()
	character.dead = true
	character.collision.disabled = true
	character.collision_layer = 0
	character.collision_mask = 0
	character._play_animation("die")
	explossion_sound.play()
	
func exit() -> void:
	#print("POD exit alert state")
	pass

func _on_animation_finished(anim_name: String) ->  void:
	print("Is a pod: " + String(character is EnemyPod))
	##character._remove_me()

func _get_score() -> int:
	return 10	
