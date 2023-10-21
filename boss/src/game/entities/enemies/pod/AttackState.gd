extends AbstractEnemyState

func enter() -> void:
	print("pod attack")
	character._play_animation("attack")
	character.velocity = Vector2.ZERO
	character._look_at_target()
	
func fire() -> void:
	character._fire()
	
func update(delta:float) -> void:
	#fire()
	print("pod fire attack!")
