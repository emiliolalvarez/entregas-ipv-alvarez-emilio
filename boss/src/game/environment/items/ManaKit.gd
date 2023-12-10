extends Node2D

const HEAL_POINTS = 50
onready var hitbox: Area2D = $Container/HitBox
onready var player:AnimationPlayer = $AnimationPlayer
onready var pick_up = $pickUp

func _ready():
	player.play("idle")

func _on_HitBox_body_entered(body: Node) -> void:
	if body.has_method("notify_mana_recover"):
		body.notify_mana_recover(HEAL_POINTS)
	player.play("hit")
	pick_up.play()


func remove() -> void:
	hitbox.collision_mask = 0
	set_physics_process(false)
	get_parent().remove_child(self)
	queue_free()

