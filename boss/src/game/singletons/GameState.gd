extends Node

## Objeto singleton que maneja estados generales del nivel,
## almacena información entre niveles y ayuda a interconectar
## estados entre nodos y escenas distantes.

## Este patrón tranquilamente podría reemplazarse por alternativas,
## como propagación de señales entre padres, o inyección de
## dependencias, pero pueden crear mucho código repetido o
## generar mucho acople.


## Señal genérica que avisa del cumplimiento de la condición
## de victoria a todos los interesados.
signal level_won()


## Señal y variable de ayuda que permite notificar la existencia
## del jugador actual a cualquiera interesado
signal current_player_changed(player)

var current_player: Player
var hud: Control

func set_current_player(player: Player) -> void:
	current_player = player
	emit_signal("current_player_changed", player)

func notify_level_won() -> void:
	emit_signal("level_won")
	
func set_hud(hud: Control) -> void:
	self.hud = hud

func update_score(amount: int) -> void:
	hud._on_score_changed(amount)
	
func hp_changed(amount, max_hp) -> void:
	hud._on_hp_changed(amount, max_hp)

func mana_changed(amount, max_mana) -> void:
	hud._on_mana_changed(amount, max_mana)
