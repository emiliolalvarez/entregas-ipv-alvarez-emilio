extends Node

## Escena manager de niveles que administra y carga el nivel actual,
## y se encarga de reiniciar el nivel, regresar al menu principal o
## cargar el siguiente nivel.

export (Array, PackedScene) var levels: Array
onready var animation_player = $AnimationPlayer
onready var main_menu = $CanvasLayer/MainMenu
onready var game_over_menu = $CanvasLayer/GameOverMenu
onready var hud = $HudCanvasLayer/HUD
onready var current_level_container: Node = $CurrentLevelContainer
var current: GameLevel

var level: int = 0

export (Texture) var mouse_cursor: Texture


func _ready() -> void:
	call_deferred("_setup_level", level)
	


func _setup_level(id: int) -> void:
	# Chequea que exista un nivel, y el número de nivel dado es correcto
	if id >= 0 && id < levels.size():
		# Remueve el nivel activo, si existiese
		if current_level_container.get_child_count() > 0:
			for child in current_level_container.get_children():
				current_level_container.remove_child(child)
				child.queue_free()
		
		# Inicializa el nivel nuevo y lo agrega al árbol
		current = levels[id].instance()
		animation_player.play("fade_in")
		GameState.set_hud(hud)
		_reset()
		

func _add_scene() -> void:
	current_level_container.add_child(current)
	current.connect("return_requested", self, "_return_called")
	current.connect("restart_requested", self, "_restart_called")
	current.connect("prev_level_requested", self, "_prev_called")
	current.connect("next_level_requested", self, "_next_called")
	current.connect("menu_requested", self, "_menu_requested_called")
	current.connect("game_over_menu_requested", self, "game_over_menu_requested_called")
	current.connect("hp_changed", hud, "_on_hp_changed")
	current.connect("mana_changed", hud, "_on_mana_changed")
	current.connect("score_changed", hud, "_on_score_changed")
	animation_player.play("fade_out")
	
# Callback de regreso al MainMenu.
func _return_called() -> void:
	pass


# Callback de reinicio del nivel.
func _restart_called() -> void:
	_reset()
	_setup_level(level)
	get_tree().paused = false

func _prev_called() -> void:
	_reset()
	_setup_level(level - 1 if level > 0 else level )
	get_tree().paused = false

	
# Callback para mostrar main menu.
func _menu_requested_called() -> void:
	main_menu.show()
	game_over_menu.hide()
	_pause()
	
func game_over_menu_requested_called() -> void:
	main_menu.hide()
	game_over_menu.show()
	_pause()
	
	
# Callback de nivel siguiente.
func _next_called() -> void:
	level = min(level + 1, levels.size() - 1)
	_setup_level(level)
	
func _pause() -> void:
	get_tree().paused = true

func _resume() -> void:
	get_tree().paused = false

func _on_MainMenu_start_button_pressed():
	main_menu.hide()
	_resume()

func _reset() -> void:
	hud.reset()
	GameState.clear_access_keys()
