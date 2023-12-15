extends GameLevel

onready var canvas_layer = $CanvasLayer
onready var player = $Player
onready var menu = $Menu
onready var soldier_spawner = $SoldierSpawner
onready var soldier_spawner_timer = $SoldierSpawnerTimer
onready var background_music = $BackgroundMusic
onready var level_accomplished_music = $LevelAccomplishedMusic
onready var defeated_music = $DefeatedMusic
onready var intro = $Intro

var soldiers: int

# Called when the node enters the scene tree for the first time.
func _ready():
	player.force_plane_mode(true)
	soldier_spawner_timer.start()
	soldiers = 0
	intro.show()
	get_tree().paused = true

func _on_exit_requested() -> void:
	get_tree().quit()

func _on_boss_die():
	level_accomplished_music.play()
	$Player._disable_collision()
	soldier_spawner_timer.stop()
	menu.set_title("Mission accomplished!")
	menu.show()
	get_tree().paused = true
	
func _on_soldier_die():
	soldiers-=1

func _on_SoldierSpawnerTimer_timeout():
	if soldiers < soldier_spawner.amount:
		var original_amount = soldier_spawner.amount
		var diff = original_amount - soldiers
		soldiers = soldier_spawner.amount
		soldier_spawner.amount = diff
		soldier_spawner._initialize()
		soldier_spawner.amount = original_amount

func _on_Player_dead():
	defeated_music.play()
	soldier_spawner_timer.stop()
	menu.set_title("Game Over")
	menu.show()
	get_tree().paused = true

func _on_intro_accept():
	background_music.play()
	print("On intro accept")
	intro.hide()
	get_tree().paused = false

