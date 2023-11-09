extends Node2D

const HEAL_POINTS = 50
onready var hitbox: Area2D = $Container/HitBox
onready var player:AnimationPlayer = $AnimationPlayer

func _ready():
	player.play("idle")

func _on_HitBox_body_entered(body: Node) -> void:
	if body.has_method("notify_healed"):
		body.notify_healed(HEAL_POINTS)
	remove()


func remove() -> void:
	hitbox.collision_mask = 0
	set_physics_process(false)
	#projectile_animations.play("hit")
	get_parent().remove_child(self)
	queue_free()

