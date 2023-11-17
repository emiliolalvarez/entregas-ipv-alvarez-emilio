extends CanvasLayer

signal on_intro_accept()
	
func _on_go_button_pressed():
	emit_signal("on_intro_accept")
