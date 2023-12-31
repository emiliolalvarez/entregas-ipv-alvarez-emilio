extends Node2D

onready var weapon_tip: Node2D = $WeaponTip
onready var wepon_animation: AnimatedSprite = $WeponAnimatedSprite
export (PackedScene) var projectile_scene: PackedScene

var projectile_container: Node


## Desacoplamos el manejo del arma para que maneje su propia lógica.
## Es útil si queremos controlar su implementación independientemente
## o si queremos introducir variedad (muchas armas, por ejemplo).
func process_input() -> void:
	var mouse_position: Vector2 = get_global_mouse_position()
	look_at(mouse_position)

func _ready():
	wepon_animation.connect("animation_finished", self, 'onCharge')

func fire():
	wepon_animation.play('charge')
	
func onCharge():
	wepon_animation.stop()
	projectile_scene.instance().initialize(projectile_container, weapon_tip.global_position, global_position.direction_to(weapon_tip.global_position))
	wepon_animation.set_frame(0)
