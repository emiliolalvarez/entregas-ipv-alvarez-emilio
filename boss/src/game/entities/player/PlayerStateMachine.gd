## Esta State Machine en particular del player solo extiende la
## funcionalidad de la State Machine abstracta para ajustarse
## a las necesidades del personaje a usar. Para estructuras de juego
## más complejas, generalmente se abstraen estos métodos para crear
## un controller genérico que se pueda asignar a cualquier entidad.
extends AbstractStateMachine


func notify_die() -> void:
	current_state.handle_event("die")
