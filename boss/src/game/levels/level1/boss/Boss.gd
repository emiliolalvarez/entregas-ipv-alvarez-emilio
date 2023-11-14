extends GameLevel

onready var canvas_layer = $CanvasLayer
onready var player = $Player
onready var menu = $Menu
onready var soldier_spawner = $SoldierSpawner
onready var soldier_spawner_timer = $SoldierSpawnerTimer
var soldiers: int

# Called when the node enters the scene tree for the first time.
func _ready():
	player.force_plane_mode(true)
	soldier_spawner_timer.start()
	soldiers = soldier_spawner.amount
	

func _on_exit_requested() -> void:
	get_tree().quit()

func _on_restart_requested() -> void:
	._on_restart_requested()

func _on_boss_die():
	menu.set_title("Mission accomplished!")
	menu.show()
	get_tree().paused = true
	
func _on_soldier_die():
	soldiers-=1

func _on_SoldierSpawnerTimer_timeout():
	if soldiers == 0:
		soldiers = soldier_spawner.amount
		soldier_spawner._initialize()


func _on_Player_dead():
	soldier_spawner_timer.stop()
	menu.set_title("Game Over")
	menu.show()
	get_tree().paused = true
