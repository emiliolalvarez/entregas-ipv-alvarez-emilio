extends Node2D

const HEAL_POINTS = 50
onready var hitbox: Area2D = $Container/HitBox
onready var player:AnimationPlayer = $AnimationPlayer

func _ready():
	player.play("idle")

func _on_HitBox_body_entered(body: Node) -> void:
	if body.has_method("notify_key_found"):
		body.notify_key_found()
	player.play("hit")


func remove() -> void:
	hitbox.collision_mask = 0
	set_physics_process(false)
	get_parent().remove_child(self)
	queue_free()
