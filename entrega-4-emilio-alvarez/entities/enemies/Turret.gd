extends Sprite

export (PackedScene) var projectile_scene:PackedScene

var player

onready var fire_position:Position2D = $FirePosition

var projectile_container:Node

func set_values(player, proyectile_container):
	self.player = player
	self.projectile_container = proyectile_container
	$Timer.start()


func _on_Timer_timeout():
	fire() # Replace with function body.


func fire():
	var projectile:Projectile = projectile_scene.instance()
	projectile_container.add_child(projectile)
	projectile.set_starting_values(fire_position.global_position, (player.global_position - fire_position.global_position).normalized())
	projectile.connect("delete_requested", self, "_on_projectile_delete_requestd")	


func _on_projectile_delete_requestd(projectile:Node):
	projectile_container.remove_child(projectile)
	projectile.queue_free()
	
