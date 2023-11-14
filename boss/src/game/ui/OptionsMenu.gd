extends Control

signal options_menu_return()

func _ready() -> void:
	hide()
	

func _on_commands_cancel_pressed():
	emit_signal("options_menu_return")
