extends Projectile

class_name PlayerMissileProjectile

onready var direction_timer = $DirectionTimer
onready var missile_tip = $MissileTip
onready var detection_area = $DetectionArea
export (int) var damage: int = 5

var target:Node2D
var update = false
var collision_mask

func initialize(container: Node, spawn_position: Vector2, target_direction: Vector2 ) -> void:
	.initialize(container, spawn_position, target_direction)
	rotation = spawn_position.angle_to(spawn_position + Vector2(0, -1))
	collision_mask = detection_area.collision_mask
	detection_area.collision_mask = 0
	direction_timer.wait_time = lifetime_timer.wait_time / 8 / VELOCITY
	direction_timer.connect("timeout", self, "_on_direction_timer_timeout")
	direction_timer.start()
	
func _on_DetectionArea_body_entered(body: Node2D):
	if (target == null):
		target = body

func _on_DetectionArea_body_exited(body: Node2D):
	if (body == target):
		target = null
		
func _physics_process(delta: float) -> void:
	if (target != null && update):
		direction = global_position.direction_to(target.global_position)
		rotation = 90 + direction.angle()
		#print("rotation: " + String(rad2deg( direction.angle())))
	position += direction * VELOCITY * delta	
		#rotation = deg2rad(120)

func _on_direction_timer_timeout():
	print ("DIRECTION TIMER TIMEOUT")
	update = true
	detection_area.collision_mask = collision_mask

func get_projectile_damage() -> int:
	return damage
