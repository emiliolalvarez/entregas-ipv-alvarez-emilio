extends Node2D


onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("idle")

func _on_body_entered(body):
	if body is Player && GameState.has_access_key():
		GameState.remove_acces_key()
		animation_player.play("open")
