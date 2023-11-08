extends KinematicBody2D
class_name Player

## Señales que sirven para comunicar el estado del Player
## a los elementos conectados. Se puede utilizar tanto para
## comunicar estados a la State Machine (sin incluir código
## de la state machine directamente) como para comunicarse,
## por ejemplo, con el entorno del nivel.
signal hit(amount)
signal healed(amount)
signal mana(amount)
signal hp_changed(current_hp, max_hp)
signal dead()
signal mana_changed(amount)

const FLOOR_NORMAL: Vector2 = Vector2.UP  # Igual a Vector2(0, -1)
const SNAP_DIRECTION: Vector2 = Vector2.DOWN
const SNAP_LENGTH: float = 32.0
const SLOPE_THRESHOLD: float = deg2rad(46)

const MODE_PLANE = 0
const MODE_ROBOT = 1

#onready var weapon: Node = $"%Weapon"
onready var weapon: Node =$WeaponContainer.get_node("%Weapon")
onready var missile: Missile =$MissileContainer.get_node("%Weapon")

onready var body_animations: AnimationPlayer = $BodyAnimations
onready var body_pivot: Node2D = $BodyPivot
onready var weapondy_pivot: Node2D = $WeaponPivot
onready var weapon_container: Node2D = $WeaponContainer
onready var missile_container: Node2D = $MissileContainer
onready var floor_raycasts: Array = $FloorRaycasts.get_children()

## Estas variables de exportación podríamos abstraerlas a cada
## estado correspondiente de la state machine, pero como queremos
## poder modificar estos valores desde afuera de la escena del Player,
## los exponemos desde el script de Player.
export (float) var ACCELERATION: float = 25
export (float) var H_SPEED_LIMIT: float = 50
export (int) var jump_speed: int
export (float) var FRICTION_WEIGHT: float = 0.1
export (int) var gravity: int = 10
export (int) var life: int
export (int) var mana: int
export (int) var MAX_LIFE: int = 30
export (int) var MAX_MANA: int = 30

var projectile_container: Node
var force_plane = false

var velocity: Vector2 = Vector2.ZERO
var snap_vector: Vector2 = SNAP_DIRECTION * SNAP_LENGTH
var stop_on_slope: bool = true
var move_direction: int = 0
var move_vertical_direction: int = 0
var mode = MODE_ROBOT

## Flag de ayuda para saber identificar el estado de actividad
var dead: bool = false


func _ready() -> void:
	initialize()


func initialize(projectile_container: Node = get_parent()) -> void:
	life = MAX_LIFE
	mana = MAX_MANA
	emit_signal("hp_changed", life, MAX_LIFE)
	emit_signal("mana_changed", mana, MAX_MANA)
	self.projectile_container = projectile_container
	weapon.projectile_container = projectile_container
	missile.projectile_container =  projectile_container


## Se extrae el comportamiento de manejo del disparo del arma a
## una función para ser llamada apropiadamente desde la state machine
func _handle_weapon_actions() -> void:
	weapon.process_input()
	if Input.is_action_just_pressed("fire_weapon"):
		weapon.fire()
	if Input.is_action_just_pressed("mana"):
		missile.fire()
		emit_signal("mana", 2)
		

## Se extrae el comportamiento del manejo del movimiento horizontal
## a una función para ser llamada apropiadamente desde la state machine
func _handle_move_input() -> void:
	move_direction = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	move_vertical_direction = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	if move_direction != 0:
		velocity.x = clamp(velocity.x + (move_direction * ACCELERATION), -H_SPEED_LIMIT, H_SPEED_LIMIT)
		body_pivot.scale.x = 1 - 2 * float(move_direction < 0)
	if mode == MODE_PLANE && move_vertical_direction != 0:
		velocity.y = clamp(velocity.y + (move_vertical_direction * ACCELERATION), -H_SPEED_LIMIT, H_SPEED_LIMIT)
	

## Se extrae el comportamiento del manejo de la aplicación de fricción
## a una función para ser llamada apropiadamente desde la state machine
func _handle_deacceleration() -> void:
	velocity.x = lerp(velocity.x, 0, FRICTION_WEIGHT) if abs(velocity.x) > 1 else 0

## Se extrae el comportamiento del manejo de la aplicación de fricción
## a una función para ser llamada apropiadamente desde la state machine
func _handle_vertical_deacceleration() -> void:
	velocity.y = lerp(velocity.y, 0, FRICTION_WEIGHT) if abs(velocity.y) > 1 else 0


## Se extrae el comportamiento de la aplicación de gravedad y movimiento
## a una función para ser llamada apropiadamente desde la state machine
func _apply_movement() -> void:
	velocity.y += (gravity if mode == MODE_ROBOT else 0)
	velocity = move_and_slide_with_snap(velocity, snap_vector, FLOOR_NORMAL, stop_on_slope, 4, SLOPE_THRESHOLD)
	if mode == MODE_ROBOT && is_on_floor() && snap_vector == Vector2.ZERO:
		snap_vector = SNAP_DIRECTION * SNAP_LENGTH


## Función que pisa la función is_on_floor() ya existente
## y le agrega el chequeo de raycasts para expandir la ventana
## de chequeo de piso
func is_on_floor() -> bool:
	var is_colliding: bool = .is_on_floor()
	for raycast in floor_raycasts:
		## Al tener deshabilitados los raycasts por default
		## ya que queremos que solamente se procesen en esta
		## función, debemos forzar una actualización
		raycast.force_raycast_update()
		is_colliding = is_colliding || raycast.is_colliding()
	return is_colliding


## Esta función ya no llama directamente a remove, sino que deriva
## el handleo a la state machine emitiendo una señal. Esto es para
## los casos de estados en los cuales no se manejan hits
func notify_hit(amount: int = 1) -> void:
	emit_signal("hit", amount)
	if !$Tween.is_processing():
		$Tween.interpolate_property($BodyPivot/Body, "modulate:", Color(246, 126, 110, 0), Color(1, 1, 1, 1), 0.4)
		$Tween.start()

## Y acá se maneja el hit final. Como aun no tenemos una "cantidad" de HP,
## sino una flag, el hit nos mata instantaneamente y tiramos una notificación.
## Esta signal tranquilamente podría llamarse "dead", pero como esa la utilizamos
## para otras cosas, y como sabemos que incorporaremos una barra de salud después
## es apropiado manejarlo de esta manera.
func _handle_hit(amount: int = 1) -> void:
	life = max(0, life - amount)
	dead = true if life == 0 else false
	emit_signal("hp_changed", life, MAX_LIFE)
	
	
func _handle_mana(amount: int = 1) -> void:
	mana = max(0, mana - amount)
	emit_signal("mana_changed", mana, MAX_MANA)

# El llamado a remove final
func _remove() -> void:
	mode = MODE_ROBOT
	set_physics_process(false)
	collision_layer = 0


## Wrapper sobre el llamado a animación para tener un solo punto de entrada controlable
## (en el caso de que necesitemos expandir la lógica o debuggear, por ejemplo)
func _play_animation(animation: String) -> void:
	if body_animations.has_animation(animation):
		body_animations.play(animation)
	
func _stop_animation(reset:bool) -> void:
	if body_animations.is_playing():
		body_animations.stop(reset)

func _set_plane_mode():
	mode = MODE_PLANE

func _set_robot_mode():
	mode = MODE_ROBOT

func _is_plane_mode() -> bool:
	return mode == MODE_PLANE
	
func _is_robot_mode() -> bool:
	return mode == MODE_ROBOT
	
func force_plane_mode(force: bool) -> void:
	force_plane = force
