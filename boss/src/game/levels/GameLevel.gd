extends Node

class_name GameLevel


## Esta escena no debería cargarse de manera directa en runtime,
## solo para testeo mediante "Reproducir Escena" (F6.
## solo para testeo mediante "Reproducir Escena" (F6.
## En versión final, el LevelManager debería encargarse de ello.

## Este script y su clase deberían ser el mismo para todos los niveles.


## Tenemos la interfaz básica de señales de control de estado
## del nivel

# Regresa al menu principal
signal return_requested()
# Reinicia el nivel
signal restart_requested()
# Inicia el siguiente nivel
signal next_level_requested()
# Muestra el main menu
signal menu_requested()
# Muestra game over menu
signal game_over_menu_requested()
# Cambia hp 
signal hp_changed(amount, max_value)
# Cambia mana
signal mana_changed(amount, max_value)


func _ready() -> void:
	randomize()
	
func _input(event: InputEvent) -> void:
	if event.is_action("reset"):
		get_tree().reload_current_scene()
	if event.is_action("ui_cancel"):
		emit_signal("menu_requested")
		

# Funciones que hacen de interfaz para las señales
func _on_level_won() -> void:
	emit_signal("next_level_requested")

func _on_return_requested() -> void:
	emit_signal("return_requested")

func _on_restart_requested() -> void:
	emit_signal("restart_requested")
	
func _on_game_over() -> void:
	emit_signal("game_over_menu_requested")
	
func _on_hp_changed(value, max_hp):
	emit_signal("hp_changed", value, max_hp)

func _on_mana_changed(value, max_hp):
	emit_signal("mana_changed", value, max_hp)

