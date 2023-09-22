extends Area2D
onready var animated_sprite = $AnimatedSprite 
onready var label = $Label 

func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(_body: Node) -> void:
	animated_sprite.play("win")
	label.visible = true
	print("You win!")
	
