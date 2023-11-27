extends Node2D

onready var weapon: Node = $"%Weapon"

var targets: Array = []

func _weapon_fire():
	weapon.fire(targets.duplicate())
	targets = []

func _on_EnemyDetector_body_entered(body):
	if body is KinematicBody2D && !body is Player:
		if (!targets.has(body) && targets.size() < 3):
			targets.append(body)
	print(targets)

func _on_EnemyDetector_body_exited(body):
	if (targets.has(body)):
		targets.remove(targets.find(body))
	print(targets)
