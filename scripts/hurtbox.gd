extends Area2D
class_name Hurtbox

@export var vidaMaxima : int = 100
@export var imunidadeTimer : Timer
var vidaAtual : int
var defesa : int = 0
signal morreu
signal mudouVida (atual : int, max : int)
signal recebeuDano

var colisoes : Array[CollisionShape2D]
var colisoesP : Array[CollisionPolygon2D]

func _enter_tree() -> void:
	vidaAtual = vidaMaxima
	body_entered.connect(tomarDano)

func _ready() -> void:
	if imunidadeTimer != null:
		imunidadeTimer.timeout.connect(terminarImunidade)
	for c in get_children():
		if c is CollisionShape2D:
			colisoes.append(c)
			continue
		if c is CollisionPolygon2D:
			colisoesP.append(c)

func terminarImunidade():
	for c in colisoes:
		c.set_deferred("disabled", false)
	for p in colisoesP:
		p.set_deferred("disabled", false)

func tomarDano(body : Node2D):
	if imunidadeTimer != null:
		if imunidadeTimer.is_stopped() == false:
				return
	if body is Hitbox:
		if imunidadeTimer != null:
			imunidadeTimer.start()
			for c in colisoes:
				c.set_deferred("disabled", true)
			for p in colisoesP:
				p.set_deferred("disabled", true)
		body.emitirAtingiu()
		var d : int = body.dano - defesa
		if d < 1:
			d = 1 
		vidaAtual -= d
		recebeuDano.emit()
		mudouVida.emit(vidaAtual, vidaMaxima)
		if(vidaAtual <= 0):
			vidaAtual = 0
			morreu.emit()
