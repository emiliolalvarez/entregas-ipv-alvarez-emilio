extends Control

onready var texture_progress = $Control/TextureProgress

func _on_hp_changed(current_hp, max_hp):
	texture_progress.max_value = max_hp
	texture_progress.value = current_hp
