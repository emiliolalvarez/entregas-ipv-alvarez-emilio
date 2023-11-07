extends GameLevel

onready var canvas_layer = $CanvasLayer
onready var player = $Player
onready var menu = $Menu


# Called when the node enters the scene tree for the first time.
func _ready():
	player.force_plane_mode(true)

func _on_exit_requested() -> void:
	get_tree().quit()

func _on_restart_requested() -> void:
	._on_restart_requested()

func _on_boss_die():
	menu.show()
