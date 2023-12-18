extends AbstractEnemyState

const EXPLODE_TIMER_MAX_TICS = 8

onready var explossion = $"../../Explossion"
onready var body = $"../../Pivot/Body"
onready var timer = $Timer
onready var animation_player = $"../../AnimationPlayer"
onready var collision_area = $"../../Pivot/CollisionArea"
onready var tween = $"../../Tween"

var counter = 0

signal die_state_entered()


func enter() -> void:
	#print("POD enter alert state")
	play_explode_alert_animation()
	emit_signal("die_state_entered")
	
func exit() -> void:
	#print("POD exit alert state")
	pass

func update(delta:float) -> void:
	if character.navigation_agent != null:
		if !character.navigation_agent.is_navigation_finished():
			animation_player.play("walk")
			var direction:Vector2 = character.global_position.direction_to(
				character.navigation_agent.get_next_location()
			)
			var desired_velocity = direction * character.H_SPEED_LIMIT * 2
			var steering = (desired_velocity - character.velocity) * delta * character.ACCELERATION * 2
			character.velocity += steering 
			character._apply_movement()

	
func play_explode_alert_animation() -> void:
	counter = 0
	body.material.set_shader_param("flash_modifier", 0.6)
	timer.wait_time=0.3
	timer.connect("timeout", self, "_on_explode_alert_finished")
	timer.start()
	

func _on_animation_finished(anim_name: String) ->  void:
	._on_animation_finished(anim_name)
	character._remove()

func _get_score() -> int:
	return 10	

func _on_explode_alert_finished() -> void:
	#print("_on_explode_alert_finished => notify hit")
	counter+=1
	body.material.set_shader_param("flash_modifier", 0 if counter %2 == 0 else 0.6)
	if (counter == EXPLODE_TIMER_MAX_TICS):
		character.notify_hit(character.life)
