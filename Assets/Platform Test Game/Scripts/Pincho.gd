extends Area2D

# intentar hacer que el pincho siga al jugador en el eje x
# y hacer que mate al jugador y recargue la escena
@onready var player = get_tree().get_nodes_in_group("Jugador1K")[0]

func _process(delta):
	global_position.x = player.global_position.x
