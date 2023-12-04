extends AbstractEnemyState
onready var explossion = $"../../Explossion"
onready var body = $"../../Pivot/Body"
onready var timer = $Timer


signal die_state_entered()
onready var tween = $"../../Tween"

func enter() -> void:
	#print("POD enter alert state")
	play_explode_alert_animation()
	emit_signal("die_state_entered")
	
func exit() -> void:
	#print("POD exit alert state")
	pass
	
func play_explode_alert_animation() -> void:
	timer.wait_time=1
	body.material.set_shader_param("flash_modifier", 0.6)
	timer.connect("timeout", self, "_on_explode_alert_finished")
	timer.start()
	

func _on_animation_finished(anim_name: String) ->  void:
	._on_animation_finished(anim_name)
	character._remove()

func _get_score() -> int:
	return 10	

func _on_explode_alert_finished() -> void:
	print("_on_explode_alert_finished => notify hit")
	body.material.set_shader_param("flash_modifier", 0)
	character.notify_hit(character.life)
