extends Abstract	Enemy

onready var animation_player = $AnimationPlayer
onready var raycast = $Pivot/RayCast2D
onready var pivot = $Pivot
onready var life_progress_bar = $Pivot/HUD/Control/LifeProgressBar
onready var detection_area = $Pivot/DetectionArea
onready var collision_area = $Pivot/CollisionArea
onready var hud = $Pivot/HUD
onready var fire_position: Position2D = $Pivot/FirePosition
onready var body: Sprite = $Pivot/Body
onready var navigation_agent = $NavigationAgent2D

export (int) var gravity: int = 10
export (int) var MAX_LIFE:int = 5
export (float) var ACCELERATION: float = 10.0
export (float) var H_SPEED_LIMIT: float = 30.0
export (float) var ATTACK_DISTANCE_THRESHOLD:float = 50
export (float) var EXPLODE_DISTANCE_THRESHOLD:float = 15
export (int) var COLLISION_DAMAGE:int = 3
export (int) var POINTS:int = 10
export (float) var speed:float  = 10.0
export (float) var max_speed:float = 100.0
export (PackedScene) var projectile_scene: PackedScene

var target: Node2D
var projectile_container: Node
var velocity: Vector2 = Vector2.ZERO
var life: int = MAX_LIFE

func _ready():
	life_progress_bar.max_value = MAX_LIFE
	life_progress_bar.value = life
	
func _fire() -> void:
	animation_player.play('fire_start')
		
func _do_fire() -> void:
	if target != null:
		var proj_instance: Node = projectile_scene.instance()
		if projectile_container == null:
			projectile_container = get_parent()
		proj_instance.initialize(
			projectile_container,
			fire_position.global_position,
			#fire_position.global_position.direction_to(target.global_position)
			fire_position.global_position.direction_to(Vector2(target.global_position.x, fire_position.global_position.y))
		)
	
func _remove() -> void:
	_disable_collision()
	._remove()
	
func notify_hit(amount:int = 1) -> void:
	.notify_hit(amount)
	
func _look_at_target() -> void:
	if target != null:
		pivot.scale.x = -1 if target.global_position.x > global_position.x else 1
	else:
		pivot.scale.x = -1 if velocity.x > 0 else 1

func _can_see_target() -> bool:
	if target == null:
		return false
	raycast.set_cast_to(raycast.to_local(target.global_position))
	raycast.force_raycast_update()
	return raycast.is_colliding() && raycast.get_collider() == target

func _play_animation(animation: String) -> void:
	if animation_player.has_animation(animation):
		animation_player.play(animation)


func _disable_collision():
	print("Disabling collision!")
	collision_mask = 0
	detection_area.collision_mask = 0
	collision_area.collision_mask = 0
			
func _apply_movement() -> void:
	_look_at_target()
	if navigation_agent != null:
		if (target!=null):
			navigation_agent.set_target_location(target.global_position)
	else:
		print("no navigation agent")	
	velocity.y += gravity
	velocity = move_and_slide(velocity)
	
	
func _get_points() -> int:
	return POINTS

func get_current_animation() -> String:
	return animation_player.get_current_animation()
		
func _get_collision_damage() -> int:
	return self.COLLISION_DAMAGE

func flash() -> void:
	pass
