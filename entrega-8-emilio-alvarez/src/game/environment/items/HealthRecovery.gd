extends Node2D

onready var animation_player = $AnimationPlayer
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player: Player


# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("Idle")
	
func _on_body_entered(body):
	body.notify_healed(10)
	set_physics_process(false)
	if is_instance_valid(self): 
		queue_free()

