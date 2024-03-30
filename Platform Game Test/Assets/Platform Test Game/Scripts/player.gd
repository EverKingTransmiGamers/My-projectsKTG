extends CharacterBody2D

#Variables del jugador
@export var run_speed : int = 550
var jump_speed : int = -800
var gravity : int = 98.1
var masa : int = 28
var dashing_speed : int = 1200

var can_dash : bool = false

@onready var dash_time = $Dashing_Timer

"""
Esta parte sirve para mover al jugador 
en x usando las teclas asignadas
"""
func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_pressed('ui_select')

	if is_on_floor() and jump:
		velocity.y = jump_speed
	
	if right:
		velocity.x += run_speed
		$Sprite2D.flip_h = false
	
	if left:
		velocity.x -= run_speed
		$Sprite2D.flip_h = true

"""
intento de recreacion de la mecanica
del dashing en el aire
"""
func dashing():
	var dash_key = Input.is_action_pressed("ui_d")
	
	if not is_on_floor() and dash_key:
		velocity.x = dashing_speed
		velocity.y = 0
		can_dash = true
	


	
	
"""
esta parte del codigo sirve para darle 
gravedad al jugador y que caiga
"""
func Gravity1kY(delta):
	velocity.y += gravity * masa * delta
	

"""
en esta parte del codigo se llaman a las funciones publicas
a traves de la funcion privada "_physics_process"
"""
func _physics_process(delta):
	get_input()
	Gravity1kY(delta)
	dashing()
	move_and_slide()



"""
esta parte del codigo sirve para detectar que
el pincho toco al jugador y que el jugador muera
y el nivel se reinicie
"""
func _on_pincho_body_entered(body):
	if body.is_in_group("Jugador1K"):
		get_tree().reload_current_scene()

