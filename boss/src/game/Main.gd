extends CanvasLayer

export (PackedScene) var level_manager_scene: PackedScene

export (Texture) var mouse_cursor: Texture

onready var player = $introMusic


func _ready() -> void:
	Input.set_custom_mouse_cursor(mouse_cursor)
	player.play()

func _on_start_requested():
	get_tree().change_scene_to(level_manager_scene)
	

