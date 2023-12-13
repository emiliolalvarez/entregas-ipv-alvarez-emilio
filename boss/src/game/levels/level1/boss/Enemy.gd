extends KinematicBody2D

const directions = {
	UP="up", 
	DOWN="down", 
	LEFT="left", 
	RIGHT="right",
	NONE="none"
}

const MAX_LIFE = 50
const POINTS = 1000

export (float) var ACCELERATION: float = 25
export (float) var H_SPEED_LIMIT: float = 50
export (float) var FRICTION_WEIGHT: float = 0.1

var velocity: Vector2 = Vector2.ZERO
var direction: String = directions.DOWN
var explosion_timer_seconds = 0

onready var down_ray_cast: RayCast2D = $DownRayCast
onready var up_ray_cast: RayCast2D = $UpRayCast
onready var body_animations: AnimationPlayer = $BodyAnimations
onready var life_progress_bar = $HUD/Control/LifeProgressBar
onready var hud = $HUD
onready var bean_damage_timer = $BeanDamageTimer
onready var explosions = [$Explosions/Explosion, $Explosions/Explosion2, $Explosions/Explosion3, $Explosions/Explosion4]
onready var explosion_timer = $Explosions/ExplosionTimer
onready var bean_start_timer = $ShipStateMachine/BeanStartTimer
onready var bean_sound = $BeanSound

export (int) var life: int = MAX_LIFE
export (int) var bean_hit_damage: int = 5

var target: Node2D

signal hit()
signal die()

func _ready():
	life_progress_bar.max_value = MAX_LIFE
	life_progress_bar.value = life
	explosion_timer.wait_time = 3

func _handle_move() -> void:
	var move_horizontal_direction = 1 if direction == directions.RIGHT else (-1 if direction == directions.RIGHT else 0)
	var move_vertical_direction = 1 if direction == directions.DOWN else (-1 if direction == directions.UP else 0)
	if move_horizontal_direction != 0:
		velocity.x = clamp(velocity.x + (move_horizontal_direction * ACCELERATION), -H_SPEED_LIMIT, H_SPEED_LIMIT)
		$Body.scale.x = 1 - 2 * float(move_horizontal_direction < 0)
	if move_vertical_direction != 0:
		if (direction == directions.DOWN && !down_ray_cast.is_colliding()) || (direction == directions.UP && !up_ray_cast.is_colliding()):
			velocity.y = clamp(velocity.y + (move_vertical_direction * ACCELERATION), -H_SPEED_LIMIT, H_SPEED_LIMIT)
	velocity = move_and_slide(velocity)
	
	

## Se extrae el comportamiento del manejo de la aplicación de fricción
## a una función para ser llamada apropiadamente desde la state machine
func _handle_deacceleration() -> void:
	velocity.x = lerp(velocity.x, 0, FRICTION_WEIGHT) if abs(velocity.x) > 1 else 0

## Se extrae el comportamiento del manejo de la aplicación de fricción
## a una función para ser llamada apropiadamente desde la state machine
func _handle_vertical_deacceleration() -> void:
	velocity.y = lerp(velocity.y, 0, FRICTION_WEIGHT) if abs(velocity.y) > 1 else 0


func _remove() -> void:
	body_animations.stop()
	$BeanSource.hide()
	$Bean.hide()
	set_physics_process(false)
	$CollisionPolygon2D.get_parent().remove_child($CollisionPolygon2D)
	for n in get_children():
		remove_child(n)
		n.queue_free()
	get_parent().remove_child(self)
	queue_free()
	GameState.update_score(_get_points())
	emit_signal("die")

## Wrapper sobre el llamado a animación para tener un solo punto de entrada controlable
## (en el caso de que necesitemos expandir la lógica o debuggear, por ejemplo)
func _play_animation(animation: String) -> void:
	if body_animations.has_animation(animation):
		body_animations.play(animation)
	
func _stop_animation(reset:bool) -> void:
	if body_animations.is_playing():
		body_animations.stop(reset)

func notify_hit(amount:int = 1) -> void:
	emit_signal("hit", amount)
	if !$Tween.is_processing():
		$Tween.interpolate_property($Body, "modulate:", Color(246, 126, 110, 0), Color(1, 1, 1, 1), 0.1)
		$Tween.start()

func is_attacking() -> bool:
	return body_animations.current_animation == "fire"
	
func _on_body_entered(body):
	target = body
	bean_damage_timer.start()
	bean_damage_timer.connect("timeout", self, "_on_damage_timer_timeout")
	_on_damage_timer_timeout()

func _on_body_exited(body):
	target = null
	bean_damage_timer.stop()

func _on_damage_timer_timeout() -> void:
	if is_attacking() && target != null && target.has_method("notify_hit"):
		target.notify_hit(bean_hit_damage)
	
func die() -> void:
	collision_layer = 0
	collision_mask = 0
	bean_damage_timer.stop()
	bean_start_timer.stop()
	bean_sound.stop()
	explosion_timer.wait_time = 1
	explosion_timer.connect("timeout", self, "on_explosion_timer_timeout")
	explosion_timer.start()
	
func on_explosion_timer_timeout() -> void:
	explosion_timer_seconds = explosion_timer_seconds + 1
	if explosion_timer_seconds >= explosions.size():
		_play_animation("die")
		_remove()
	else:
		explosions[randi() % explosions.size()].play()

func _get_points() -> int:
	return POINTS
