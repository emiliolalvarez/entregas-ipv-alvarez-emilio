extends Control

onready var health_progress = $Control/HelthProgress

func _on_hp_changed(current_hp, max_hp):
	health_progress.max_value = max_hp
	health_progress.value = current_hp
