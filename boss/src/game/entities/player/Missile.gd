extends Node2D

class_name Missile

onready var weapon_tip1: Node2D = $WeaponTip1
onready var weapon_tip2: Node2D = $WeaponTip2
onready var weapon_tip3: Node2D = $WeaponTip3
onready var weapon_tip_source: Node2D = $WeaponTipSource

export (PackedScene) var projectile_scene: PackedScene

var projectile_container: Node
var can_shoot = true
var projectiles_count = 0


## Acá solo me mantengo apuntando si tengo habilitada esa función.
## Esto es como corrección de apuntado para compensar por el delay
## aplicado por la animación de disparo.
func process_input() -> void:
	pass
	
func can_fire() -> bool:
	return projectiles_count == 0

func fire(targets:Array = []) -> void:
	
	if projectiles_count == 0:
		var projectiles = [
			[weapon_tip1, projectile_scene.instance()],
			[weapon_tip2, projectile_scene.instance()],
			[weapon_tip3, projectile_scene.instance()]
		]
		
		projectiles_count = projectiles.size()
		
		for i in projectiles.size():
			projectiles[i][1].connect("removed", self, "_on_projectile_removed")
			projectiles[i][1].initialize(
				projectile_container,
				projectiles[i][0].global_position,
				global_position.direction_to(projectiles[i][0].global_position),
				(null if i + 1 >= targets.size() else targets[i])
			)
		
	
func _on_projectile_removed():
	projectiles_count-=1


