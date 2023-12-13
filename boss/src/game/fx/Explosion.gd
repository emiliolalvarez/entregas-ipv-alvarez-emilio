extends Node2D
onready var animated_sprite = $AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite.connect("animation_finished", self, "animation_finished")
	pass # Replace with function body.

func play() -> void:
	animated_sprite.play("explosion")
	
func animation_finished() -> void:
	animated_sprite.set_frame(0)
