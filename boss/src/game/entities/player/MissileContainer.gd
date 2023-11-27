extends Node2D

onready var weapon: Node = $"%Weapon"

var targets: Array = []

func _weapon_fire():
	weapon.fire(targets.duplicate())
	targets = []

func _on_EnemyDetector_body_entered(body):
	if (!targets.has(body)):
		targets.append(body)
