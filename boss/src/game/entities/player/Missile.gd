extends Node2D

class_name Missile

const TIME_BETWEEN_FIRE_IN_SECONDS = 3

onready var weapon_tip1: Node2D = $WeaponTip1
onready var weapon_tip2: Node2D = $WeaponTip2
onready var weapon_tip3: Node2D = $WeaponTip3
onready var weapon_tip_source: Node2D = $WeaponTipSource
onready var weapon_timer = $WeaponTimer

export (PackedScene) var projectile_scene: PackedScene

var projectile_container: Node
var can_shoot = true
var projectiles_count = 0

func _ready():
	weapon_timer.connect("timeout", self, "_on_weapon_timer_timeout")
	weapon_timer.wait_time = TIME_BETWEEN_FIRE_IN_SECONDS

## Acá solo me mantengo apuntando si tengo habilitada esa función.
## Esto es como corrección de apuntado para compensar por el delay
## aplicado por la animación de disparo.
func process_input() -> void:
	pass
	
func can_fire() -> bool:
	return can_shoot

func fire(targets:Array = []) -> void:
	if can_shoot && projectiles_count == 0:
		can_shoot = false
		weapon_timer.start()
		GameState.disable_mana()
		var projectiles = [
			[weapon_tip1, projectile_scene.instance()],
			[weapon_tip2, projectile_scene.instance()],
			[weapon_tip3, projectile_scene.instance()]
		]
		
		projectiles_count = projectiles.size()
		var last_target = null;
		for i in projectiles.size():
			last_target = (last_target if i + 1 > targets.size() else targets[i])
			projectiles[i][1].connect("removed", self, "_on_projectile_removed")
			projectiles[i][1].initialize(
				projectile_container,
				projectiles[i][0].global_position,
				global_position.direction_to(projectiles[i][0].global_position),
				last_target
			)
		
	
func _on_projectile_removed():
	projectiles_count-=1
	if projectiles_count == 0 && can_shoot:
		GameState.enable_mana()


func _on_weapon_timer_timeout():
	if projectiles_count == 0:
		can_shoot = true
		GameState.enable_mana()
