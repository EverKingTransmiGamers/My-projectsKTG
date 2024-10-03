extends CharacterBody2D
class_name player

var speed : int = 67500
var jump_height : int = 850
var dashing_speed : int = 95000

var gravity : float = 98.1
var masa : int = 28

var intMove : int = 0
var lindsmove : int = 2
var lintScale : int = 0

var can_dash : bool = false

"""
Nota: lintScale es la variable que decidira si el raycast apunta a la
izquierda o a la derecha.

"""

func _physics_process(delta: float) -> void:
	Gravity1K(delta)
	Player_Ctrl(delta)
	dashing(delta)
	_raycast1k()
	move_and_slide()
	
"""
Esta parte del codigo es para darle gravedad
al jugador
"""
func Gravity1K(delta: float) -> void:
	velocity.y += gravity * masa * delta
	if is_on_floor():
		velocity.y = 0
	
	
"""
Esto de aqui son los controladores del jugador,
vamos, los tipicos de moverse a izquierda y derecha y saltar
"""
func Player_Ctrl(delta):
	
	if Input.is_action_just_pressed("key_sp") and is_on_floor():
		velocity.y -= jump_height
	elif Input.is_action_just_released("key_sp"):
		velocity.y *= 0.5
	
	#si can_dash es falso, el jugador se puede mover, de lo contrario no podra
	if not can_dash:
		if Input.is_action_pressed("ui_left"):
			intMove = -2
			lintScale = -1
			lindsmove = -2
		elif Input.is_action_pressed("ui_right"):
			intMove = 2
			lintScale = 1
			lindsmove = 2
			
		else:
			intMove = 0
			lintScale = 0
			lindsmove = lindsmove
	
	
	if intMove != 0:
		velocity.x = (speed * intMove) * delta
	elif intMove == 0:
		velocity.x = 0
	
func _raycast1k():
	if lintScale == -1:
		$RayCast2D.target_position.x = -50
		
	if lintScale == 1:
		$RayCast2D.target_position.x = 50
	

#Recreacion de la mecanica del dashing

func dashing(delta):
	if Input.is_action_just_pressed("key_d"):
		can_dash = true
		$dashing_timer.start()
	
	if can_dash:
		velocity.x = (dashing_speed * lindsmove) * delta
		velocity.y = 0
		lindsmove = lindsmove

func _on_dashing_timer_timeout():
	can_dash = false
	
	if not can_dash:
		velocity.x = 0

#deteccion de la colision del pincho
func _on_death_col_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		get_tree().change_scene_to_file("res://Scenes/death_screen.tscn")
