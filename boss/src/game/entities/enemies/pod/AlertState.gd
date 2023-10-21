extends AbstractEnemyState

var attack_distance_threshold:int = 100

func enter() -> void:
	character.velocity = Vector2.ZERO
	character._play_animation("alert")
	

func update(delta:float) -> void:
	if !abs(character.target.global_position.x - character.global_position.x) <= attack_distance_threshold:
		emit_signal("finished", "walk")
