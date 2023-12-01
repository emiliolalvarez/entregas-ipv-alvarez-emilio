extends StaticBody2D


onready var animation_player = $AnimationPlayer
onready var tip_message = $TipMessage

func _ready():
	animation_player.play("reset")

func _on_tip_message_ok_pressed():
	print("ok pressed")
	get_tree().paused = false
	tip_message.hide()
	

func _on_detection_area_body_entered(body):
	print(body)
	if body is Player:
		if GameState.has_access_key():
			GameState.remove_acces_key()
			animation_player.play("open")
		else:
			get_tree().paused = true
			tip_message.show()
