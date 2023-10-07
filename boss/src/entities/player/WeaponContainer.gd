extends Node2D

onready var weapon: Node = $"%Weapon"

func _weapon_fire():
	weapon._fire()

