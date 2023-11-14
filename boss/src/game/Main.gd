extends CanvasLayer

export (PackedScene) var level_manager_scene: PackedScene

export (Texture) var mouse_cursor: Texture


func _ready() -> void:
	Input.set_custom_mouse_cursor(mouse_cursor)
	

func _on_start_requested():
	get_tree().change_scene_to(level_manager_scene)
	
