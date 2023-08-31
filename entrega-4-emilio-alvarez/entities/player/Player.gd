extends Sprite

onready var cannon:Sprite = $Cannon

export (float) var ACELERATION:float = 20.0
export (float) var H_SPEED_LIMIT:float = 600.0
export (float) var FRICTION_WEIGHT:float = 0.1

var speed = 200 #Pixeles
var projectile_container:Node
var velocity:Vector2 = Vector2.ZERO


func set_projectile_container(container:Node):
	cannon.projectile_container = container
	projectile_container = container

func _physics_process(delta):
	
	# Manera optimizada
	var direction_optimized:int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	
	if direction_optimized !=0:
		velocity.x = clamp(velocity.x + (direction_optimized * ACELERATION), -H_SPEED_LIMIT, H_SPEED_LIMIT)
	else:
		velocity.x = lerp(velocity.x, 0, FRICTION_WEIGHT) if abs(velocity.x) > 1 else 0
	
	var mouse_position:Vector2 = get_global_mouse_position()
	
	var origin:Vector2 = global_position
	var direction_vector = (mouse_position - origin).normalized()
	
	#var mouse_cannon_orientation:Vector2 = mouse_position - cannon.global_position
	#cannon.rotation = mouse_cannon_orientation.angle()
	cannon.look_at(mouse_position)
	
	if Input.is_action_just_pressed("fire"):
		cannon.fire()	
	
	#position.x += direction_optimized * speed * delta
	position += velocity * delta 
