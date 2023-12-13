extends Node2D
onready var animated_sprite = $AnimatedSprite
onready var explosion_sound = $ExplosionSound

# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite.connect("animation_finished", self, "animation_finished")
	
func play() -> void:
	animated_sprite.play("explosion")
	explosion_sound.play()
	
	
func animation_finished() -> void:
	animated_sprite.set_frame(0)

