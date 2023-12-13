extends AbstractEnemyState

func enter() -> void:
	character.hud.hide()
	character.die()
