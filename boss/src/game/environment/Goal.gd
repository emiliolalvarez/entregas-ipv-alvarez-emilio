extends Area2D


var won: bool = false
signal goal_reached


func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")


func _on_body_entered(body: Node) -> void:
	if !won:
		print("You win!")
		won = true

func _on_Goal_body_entered(body):
	emit_signal("goal_reached")
