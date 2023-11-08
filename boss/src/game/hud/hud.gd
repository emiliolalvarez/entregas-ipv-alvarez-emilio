extends Control

onready var health_progress = $Control/HelthProgress
onready var mana_progress = $Control/ManaProgress
onready var health_percentage = $Control/Circle/HealthPercentage

func _on_hp_changed(current_hp, max_hp):
	health_progress.max_value = max_hp
	health_progress.value = current_hp
	health_percentage.text = String(round(health_progress.value * 100 / max_hp)) + '%'

func _on_mana_changed(current_mana, max_mana):
	mana_progress.max_value = max_mana
	mana_progress.value = current_mana

