extends AbstractEnemy

class_name EnemySoldier

onready var fire_position: Node2D = $FirePosition
onready var raycast: RayCast2D = $RayCast2D
onready var body_anim: AnimatedSprite = $Body
onready var life_progress_bar:ProgressBar = $Pivot/HUD/Control/LifeProgressBar
onready var hud:Node2D = $Pivot/HUD
onready var pivot:Node2D = $Pivot
export (float) var pathfinding_step_threshold:float = 5.0

export (Vector2) var wander_radius: Vector2 = Vector2(10.0, 10.0)
export (float) var speed:float  = 10.0
export (float) var max_speed:float = 100.0
export (float) var max_life:int = 20
export (int) var POINTS:int = 30

export (PackedScene) var projectile_scene: PackedScene

export (NodePath) var pathfinding_path: NodePath
onready var pathfinding: PathfindAstar = get_node_or_null(pathfinding_path)

var target: Node2D
var projectile_container: Node
var life:int = 0

var velocity: Vector2 = Vector2.ZERO

func _ready():
	life = max_life
	life_progress_bar.max_value = max_life
	life_progress_bar.value = life

func initialize(container, turret_pos, projectile_container) -> void:
	container.add_child(self)
	global_position = turret_pos
	self.projectile_container = projectile_container
	

func _fire() -> void:
	if target != null:
		var proj_instance: Node = projectile_scene.instance()
		if projectile_container == null:
			projectile_container = get_parent()
		proj_instance.initialize(
			projectile_container,
			fire_position.global_position,
			fire_position.global_position.direction_to(target.global_position)
		)
	
func _look_at_target() -> void:
	body_anim.flip_h = raycast.cast_to.x > 0

func _can_see_target() -> bool:
	if target == null:
		return false
	raycast.set_cast_to(raycast.to_local(target.global_position))
	raycast.force_raycast_update()
	return raycast.is_colliding() && raycast.get_collider() == target
	
	
func _apply_movement() -> void: 	
	velocity = move_and_slide(velocity, Vector2.UP)
	
func _get_points() -> int:
	return POINTS

## Wrapper sobre el llamado a animación para tener un solo punto de entrada controlable
## (en el caso de que necesitemos expandir la lógica o debuggear, por ejemplo)
func _play_animation(animation: String) -> void:
	if body_anim.frames.has_animation(animation): 
		body_anim.play(animation)

func get_current_animation() -> String:
	return body_anim.animation
