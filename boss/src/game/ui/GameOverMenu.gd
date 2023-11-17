extends Node2D

signal start_button_pressed()
signal exit_button_pressed()
onready var start_button = $Main/Buttons/StartButton

export (String) var start_button_title: String = "Restart"

func _ready():
	start_button.text = start_button_title

func _on_exit_button_pressed() -> void:
	get_tree().quit()
	hide()

func _on_start_button_pressed():
	hide()
	emit_signal("start_button_pressed")
