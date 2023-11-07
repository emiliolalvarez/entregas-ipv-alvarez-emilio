extends CanvasLayer

export (PackedScene) var level_manager: PackedScene

func _on_RestartButton_pressed():
	level_manager._restart_called()


func _on_ExitButton_pressed():
	pass # Replace with function body.
