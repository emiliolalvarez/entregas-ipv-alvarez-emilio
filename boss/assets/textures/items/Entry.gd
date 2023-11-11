extends Node2D


onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("idle")
	
#func _process(delta):
#	pass


func _on_body_entered(body):
	if body.has_method("notify_hit"):
		body.notify_hit(body.life)
