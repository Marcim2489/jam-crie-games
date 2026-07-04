extends Node
class_name GeradorDeSalas

const SALA_1_BAIXO : String = "uid://75jsx1obehin"
const SALA_1_CIMA : String = "uid://wg50eu5ylb3m"
const SALA_1_DIREITA : String = "uid://cswresj13x7l6"
const SALA_1_ESQUERDA : String = "uid://b3hg7sgcrsqra"
const SALA_2_BAIXO_DIREITA : String = "uid://bjxxg5i6phwyg"
const SALA_2_BAIXO_ESQUERDA : String = "uid://d4fa850shyu5c"
const SALA_2_CIMA_DIREITA : String = "uid://cgwepxik1k18y"
const SALA_2_CIMA_ESQUERDA : String = "uid://dmb8o6m5bjf6i"
const SALA_2_HORIZONTAL : String = "uid://ssjy6c74tsw4"
const SALA_2_VERTICAL : String = "uid://j3wxchbqg1kb"
const SALA_3_MBAIXO : String = "uid://ddilrtu71cbhc"
const SALA_3_MCIMA : String = "uid://cxy8r3afxo7dk"
const SALA_3_MDIREITA : String = "uid://cfbx6qoj0y75s"
const SALA_3_MESQUERDA : String = "uid://bpxbkclkntq63"
const SALA_4 : String = "uid://dq48h1wr1t0s6"

var salasExistentes : Array[Vector2i]
var salasDisponiveis : Array[Vector2i]
var salasUsadas : Array[Vector2i]

@export var colunas : int = 6
@export var linhas : int = 6

@export var totalDeSalas : int = 15
@export var player : Node2D
@export var minimap : Minimap

var primeiraSala : Vector2i

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("resetar"):
		get_tree().reload_current_scene()

func _ready() -> void:
	var x : int = 0
	var y : int = 0
	while(x < colunas):
		while(y<linhas):
			salasExistentes.append(Vector2i(x,y))
			y+=1
		y=0
		x+=1
	
	primeiraSala = [
	Vector2i(0,0), Vector2i(2,0), Vector2i(3,0), Vector2i(5,0),
	Vector2i(0,2), Vector2i(5,2),
	Vector2i(0,3), Vector2i(5,3),
	Vector2i(0,5), Vector2i(2,5), Vector2i(3,5), Vector2i(5,5)
	].pick_random()
	
	if salasExistentes.has(primeiraSala) == false:
		primeiraSala = salasExistentes.pick_random()
	
	salasDisponiveis.append(primeiraSala)
	
	while(salasUsadas.size() < totalDeSalas):
		adicionarSala(salasDisponiveis.pick_random())
	
	for sala : Vector2i in salasUsadas:
		var instanciaSala : Node2D = load(verificarAdjacencia(sala)).instantiate()
		add_child(instanciaSala)
		instanciaSala.global_position = Vector2i(
			sala.x*SalaManager.tamanhoTile*SalaManager.tilesHorizontal*SalaManager.separacaoEntreSalas,
			sala.y*SalaManager.tamanhoTile*SalaManager.tilesVertical*SalaManager.separacaoEntreSalas, 
		)
	SalaManager.setarSala(primeiraSala, player)
	#player.global_position = Vector2i(
			#primeiraSala.x*16*18*2,
			#primeiraSala.y*16*12*2, 
		#)

func verificarAdjacencia(sala : Vector2i) -> String:
	var adjacencias : int = 0
	var cima : bool = false
	var baixo : bool = false
	var direita : bool = false
	var esquerda : bool = false
	
	if salasUsadas.has(sala + Vector2i.RIGHT):
		adjacencias+=1
		direita = true
	if salasUsadas.has(sala + Vector2i.LEFT):
		adjacencias+=1
		esquerda = true
	if salasUsadas.has(sala + Vector2i.UP):
		adjacencias+=1
		cima = true
	if salasUsadas.has(sala + Vector2i.DOWN):
		adjacencias+=1
		baixo = true
	
	match adjacencias:
		1:
			if cima:
				minimap.colocarSala(sala, Vector2i(1,0))
				return SALA_1_CIMA
			if baixo:
				minimap.colocarSala(sala, Vector2i(0,0))
				return SALA_1_BAIXO
			if direita:
				minimap.colocarSala(sala, Vector2i(3,0))
				return SALA_1_DIREITA
			if esquerda:
				minimap.colocarSala(sala, Vector2i(2,0))
				return SALA_1_ESQUERDA
		2:
			if cima:
				if baixo:
					minimap.colocarSala(sala, Vector2i(0,1))
					return SALA_2_VERTICAL
				if direita:
					minimap.colocarSala(sala, Vector2i(0,2))
					return SALA_2_CIMA_DIREITA
				if esquerda:
					minimap.colocarSala(sala, Vector2i(4,1))
					return SALA_2_CIMA_ESQUERDA
			if baixo:
				if direita:
					minimap.colocarSala(sala, Vector2i(3,1))
					return SALA_2_BAIXO_DIREITA
				if esquerda:
					minimap.colocarSala(sala, Vector2i(2,1))
					return SALA_2_BAIXO_ESQUERDA
			if direita and esquerda:
				minimap.colocarSala(sala, Vector2i(1,1))
				return SALA_2_HORIZONTAL
				
		3:
			if cima == false:
				minimap.colocarSala(sala, Vector2i(3,2))
				return SALA_3_MCIMA
			if baixo == false:
				minimap.colocarSala(sala, Vector2i(1,2))
				return SALA_3_MBAIXO
			if direita == false:
				minimap.colocarSala(sala, Vector2i(4,2))
				return SALA_3_MDIREITA
			if esquerda == false:
				minimap.colocarSala(sala, Vector2i(2,2))
				return SALA_3_MESQUERDA
		4:
			minimap.colocarSala(sala, Vector2i(4,0))
			return SALA_4
		_:
			minimap.colocarSala(sala, Vector2i(4,0))
			return SALA_4
	minimap.colocarSala(sala, Vector2i(4,0))
	return SALA_4




func adicionarSala(sala : Vector2i):
	if (salasExistentes.has(sala)==false or salasDisponiveis.has(sala)==false
	or salasUsadas.has(sala)):
		return
	salasUsadas.append(sala)
	salasDisponiveis.erase(sala)
	
	var salaADireita : Vector2i = sala + Vector2i.RIGHT
	var salaAEsquerda : Vector2i = sala + Vector2i.LEFT
	var salaAcima : Vector2i = sala + Vector2i.UP
	var salaAbaixo : Vector2i = sala + Vector2i.DOWN
	
	if (salasExistentes.has(salaADireita) and 
	salasDisponiveis.has(salaADireita)==false):
		salasDisponiveis.append(salaADireita)
	
	if (salasExistentes.has(salaAEsquerda) and 
	salasDisponiveis.has(salaAEsquerda)==false):
		salasDisponiveis.append(salaAEsquerda)
	
	if (salasExistentes.has(salaAcima) and 
	salasDisponiveis.has(salaAcima)==false):
		salasDisponiveis.append(salaAcima)
	
	if (salasExistentes.has(salaAbaixo) and 
	salasDisponiveis.has(salaAbaixo)==false):
		salasDisponiveis.append(salaAbaixo)
