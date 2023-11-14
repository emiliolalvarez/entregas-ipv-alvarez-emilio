extends Node2D

signal start_button_pressed()
onready var start_button = $Main/Buttons/StartButton

export (String) var start_button_title: String = "Start"

func _ready():
	start_button.text = start_button_title

func _on_ExitButton_pressed() -> void:
	get_tree().quit()
	hide()


func _on_show_commands_button_pressed():
	$Main.hide()
	$OptionsMenu.show()


func _on_commands_cancel_pressed():
	print("cancel options")
	$OptionsMenu.hide()
	$Main.show()


func _on_start_button_pressed():
	$OptionsMenu.hide()
	emit_signal("start_button_pressed")

