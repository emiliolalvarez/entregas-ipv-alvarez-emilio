extends Projectile

class_name PlayerMissileProjectile
onready var direction_timer = $DirectionTimer
onready var missile_tip = $MissileTip

var target:Node2D
var update = false

func initialize(container: Node, spawn_position: Vector2, target_direction: Vector2 ) -> void:
	.initialize(container, spawn_position, target_direction)
	rotation = spawn_position.angle_to(spawn_position + Vector2(0, -1))
	print(rad2deg(rotation))
	
func _on_DetectionArea_body_entered(body: Node2D):
	if (target == null):
		target = body
		direction_timer.wait_time = lifetime_timer.wait_time / 4
		direction_timer.connect("timeout", self, "_on_direction_timer_timeout")
		direction_timer.start()

func _on_DetectionArea_body_exited(body: Node2D):
	if (body == target):
		target = null
		#update= false
		#direction = ($MissileTip.global_position - global_position).normalized()

func _physics_process(delta: float) -> void:
	_update_roation()
	if (target != null && update):
		direction = global_position.direction_to(target.global_position)
	position += direction * VELOCITY * delta	
	
func _update_roation():
	if (target != null && update):
		print("update rotation 2")
		
		#direction = ($MissileTip.global_position - global_position).normalized()
		rotation = $MissileTip.global_position.normalized().angle_to(target.global_position.normalized())
		#rotation = (missile_tip.global_position.angle_to(target.global_position))
		#rotation = deg2rad(120)

func _on_direction_timer_timeout():
	print("direction timer timeout")
	update = true
	#direction = (target.global_position - global_position).normalized()
	#direction = global_position.direction_to(target.global_position)
	
