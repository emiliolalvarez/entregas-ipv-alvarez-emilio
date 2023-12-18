extends AbstractEnemyState

func enter() -> void:
	#print("POD enter Idle state")
	#print(character)
	character._play_animation("idle")

func exit() -> void: 
	#print("POD exited Idle state")	
	pass
	
func update(delta:float) -> void:
	if (character.target):
		character.look_at(character.target)
	if character._can_see_target():
		print("can see target, changing to walk")
		emit_signal("finished", "walk")
