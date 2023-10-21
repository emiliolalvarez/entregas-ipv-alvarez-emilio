extends AbstractEnemyState

func enter() -> void:
	character.velocity = Vector2.ZERO
	fire()
	
func fire() -> void:
	character._fire()
	character._play_animation("alert")

func update(delta:float) -> void:
	character._look_at_target()
