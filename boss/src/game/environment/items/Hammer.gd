extends StaticBody2D

onready var animation_player = $AnimationPlayer
var original_position = position
var original_rotation = rotation
func _ready():
	animation_player.play("idle")

	
func _on_body_entered(body):
	print("hammer detected body")
	if body.has_method("notify_hit"):
		body.notify_hit(body.life)
		
func _physics_process(delta):
	pass
