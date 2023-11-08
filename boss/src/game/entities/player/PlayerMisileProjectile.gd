extends Projectile

class_name PlayerMissileProjectile
onready var direction_timer = $DirectionTimer
onready var missile_tip = $MissileTip

var target:Node2D
var update = false

func initialize(container: Node, spawn_position: Vector2, target_direction: Vector2 ) -> void:
	.initialize(container, spawn_position, target_direction)
	rotation = spawn_position.angle_to(spawn_position + Vector2(0, -1))
	
func _on_DetectionArea_body_entered(body: Node2D):
	if (target == null):
		target = body
		direction_timer.wait_time = lifetime_timer.wait_time / 8 / VELOCITY
		direction_timer.connect("timeout", self, "_on_direction_timer_timeout")
		direction_timer.start()

func _on_DetectionArea_body_exited(body: Node2D):
	if (body == target):
		target = null
		#update= false
		#direction = ($MissileTip.global_position - global_position).normalized()

func _physics_process(delta: float) -> void:
	if (target != null && update):
		direction = global_position.direction_to(target.global_position)
		rotation = 90 + direction.angle()
		#print("rotation: " + String(rad2deg( direction.angle())))
	position += direction * VELOCITY * delta	
		#rotation = deg2rad(120)

func _on_direction_timer_timeout():
	#print("direction timer timeout")
	update = true

func get_projectile_damage() -> int:
	return 5
