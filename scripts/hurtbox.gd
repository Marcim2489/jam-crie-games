extends Area2D
class_name Hurtbox

@export var vidaMaxima : int = 100
var vidaAtual : int

signal morreu
signal mudouVida (atual : int, max : int)

func _enter_tree() -> void:
	vidaAtual = vidaMaxima
	body_entered.connect(tomarDano)

func tomarDano(body : Node2D):
	print("a")
	if body is Hitbox:
		print("tomoudano")
		body.emitirAtingiu()
		vidaAtual -= body.dano
		mudouVida.emit(vidaAtual, vidaMaxima)
		if(vidaAtual <= 0):
			vidaAtual = 0
			morreu.emit()
