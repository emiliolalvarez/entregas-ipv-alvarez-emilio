extends CanvasLayer

export (PackedScene) var level_manager_scene: PackedScene


func _on_restart_utton_pressed() -> void:
	get_tree().change_scene_to(level_manager_scene)


func _on_ExitButton_pressed() -> void:
	get_tree().quit()
