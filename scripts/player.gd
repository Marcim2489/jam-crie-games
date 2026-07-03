extends CharacterBody2D
class_name Player

@export var velocidade : int = 130
var direcao : Vector2 = Vector2.ZERO

func _process(_delta: float) -> void:
	direcao = Vector2.ZERO
	if(Input.is_action_pressed("ui_right")):
		direcao.x +=1
	if(Input.is_action_pressed("ui_left")):
		direcao.x -=1
	if(Input.is_action_pressed("ui_down")):
		direcao.y +=1
	if(Input.is_action_pressed("ui_up")):
		direcao.y -=1
	direcao = direcao.normalized()
	velocity = velocidade * direcao
	move_and_slide()
	
