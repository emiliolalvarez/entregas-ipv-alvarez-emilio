extends Node2D

onready var mushroom_body: Sprite = $MushroomBody

export (int) var heal_amount: int = 3.0
export (int) var chance_frames: int = 36


func _ready() -> void:
	mushroom_body.frame = randi() % chance_frames


func _on_PickArea_body_entered(body: Node) -> void:
	if body.has_method("notify_heal"):
		body.notify_heal(heal_amount)
		call_deferred("_remove")


func _remove() -> void:
	get_parent().remove_child(self)
	queue_free()
