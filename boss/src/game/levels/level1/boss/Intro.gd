extends CanvasLayer
onready var tween = $Tween
onready var info = $Container/Info
onready var container = $Container
onready var countdown = $Countdown
onready var timer = $Timer
onready var label = $Countdown/Label
onready var go_button = $Container/VBoxContainer/GoButton
onready var get_ready = $Countdown/GetReady

var count = 0

signal on_intro_accept()

func _ready():
	tween.interpolate_property(info, "percent_visible", 0.0, 1.0, 7.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.connect("tween_completed", self, "on_description_finished")
	tween.start()

func on_description_finished(object: Object, key: NodePath) -> void:
	go_button.show()
	
func _on_go_button_pressed() -> void:
	container.hide()
	countdown.show()
	get_ready.text = "Get ready!"
	timer.wait_time = 1
	timer.connect("timeout", self, "on_timer_timeout")
	timer.start()

func on_timer_timeout() -> void:
	get_ready.text = ""
	count = count + 1
	if count > 4: 
		timer.stop()
		emit_signal("on_intro_accept")
	elif count == 4:
		label.text = "Go!"
	else:
		label.text = String(count)
