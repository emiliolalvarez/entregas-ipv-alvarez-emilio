extends Node

## Escena manager de niveles que administra y carga el nivel actual,
## y se encarga de reiniciar el nivel, regresar al menu principal o
## cargar el siguiente nivel.

export (Array, PackedScene) var levels: Array
onready var animation_player = $AnimationPlayer
onready var main_menu = $CanvasLayer/MainMenu

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
		

func _add_scene() -> void:
	current_level_container.add_child(current)
	current.connect("return_requested", self, "_return_called")
	current.connect("restart_requested", self, "_restart_called")
	current.connect("next_level_requested", self, "_next_called")
	current.connect("menu_requested", self, "_menu_requested_called")
	animation_player.play("fade_out")
	
# Callback de regreso al MainMenu.
func _return_called() -> void:
	pass


# Callback de reinicio del nivel.
func _restart_called() -> void:
	_setup_level(level)
	get_tree().paused = false
	
# Callback para mostrar main menu.
func _menu_requested_called() -> void:
	main_menu.show()
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
