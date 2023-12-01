extends StaticBody2D

onready var tween = $Tween
onready var animation_player = $AnimationPlayer
onready var tip_message = $TipMessage
var is_open = false

func _ready():
	animation_player.play("reset")
	tip_message.modulate.a = 0

func _on_tip_message_ok_pressed():
	tip_message.hide()

func _on_detection_area_body_entered(body):
	if body is Player && !is_open:
		if GameState.has_access_key():
			GameState.remove_acces_key()
			animation_player.play("open")
			is_open = true
		else:
			show_tip_message()

func _on_detection_area_body_exited(body):
	hide_tip_message()

func hide_tip_message() -> void:
	if !tween.is_processing():
		tween.interpolate_property(
			tip_message,
			"modulate:a",
			tip_message.modulate.a,
			0,
			1,
			Tween.TRANS_SINE,
			Tween.EASE_OUT
		)
		tween.start()
		
func show_tip_message() -> void:
	if !tween.is_processing():
		tip_message.modulate.a = 0
		tween.interpolate_property(
			tip_message,
			"modulate:a",
			tip_message.modulate.a,
			1,
			1,
			Tween.TRANS_SINE,
			Tween.EASE_OUT
		)
		tween.start()
		
