extends CanvasLayer

export (PackedScene) var level_manager_scene: PackedScene

export (Texture) var mouse_cursor: Texture


func _ready() -> void:
	Input.set_custom_mouse_cursor(mouse_cursor)

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().paused = false
		$Main.show()

func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to(level_manager_scene)


func _on_ExitButton_pressed() -> void:
	hide()


func _on_show_commands_button_pressed():
	hide()
	$Commands.show()
