extends Node
class_name GeradorDeSalas

const SALA_1_BAIXO : Array[String] = ["uid://75jsx1obehin"]
const SALA_1_CIMA : Array[String] = ["uid://wg50eu5ylb3m"]
const SALA_1_DIREITA : Array[String] = ["uid://cswresj13x7l6"]
const SALA_1_ESQUERDA : Array[String] = ["uid://b3hg7sgcrsqra"]
const SALA_2_BAIXO_DIREITA : Array[String] = ["uid://bjxxg5i6phwyg"]
const SALA_2_BAIXO_ESQUERDA :Array[String] = ["uid://d4fa850shyu5c"]
const SALA_2_CIMA_DIREITA : Array[String] = ["uid://cgwepxik1k18y"]
const SALA_2_CIMA_ESQUERDA : Array[String] = ["uid://dmb8o6m5bjf6i"]
const SALA_2_HORIZONTAL : Array[String] = ["uid://ssjy6c74tsw4"]
const SALA_2_VERTICAL : Array[String] = ["uid://j3wxchbqg1kb"]
const SALA_3_MBAIXO : Array[String] = ["uid://ddilrtu71cbhc"]
const SALA_3_MCIMA : Array[String] = ["uid://cxy8r3afxo7dk"]
const SALA_3_MDIREITA : Array[String] = ["uid://cfbx6qoj0y75s"]
const SALA_3_MESQUERDA : Array[String] = ["uid://bpxbkclkntq63"]
const SALA_4 : Array[String] = ["uid://dq48h1wr1t0s6"]

var salasExistentes : Array[Vector2i]
var salasDisponiveis : Array[Vector2i]
var salasUsadas : Array[Vector2i]
var salasRaras : Array[Vector2i]

@export var colunas : int = 6
@export var linhas : int = 6

@export var totalDeSalas : int = 15
@export var player : Node2D
@export var minimap : Minimap

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("resetar"):
		#get_tree().reload_current_scene()

func _ready() -> void:
	MusicPlayer.playMusic(MusicPlayer.VIOLA_MINHA_VIOLA)
	var x : int = 0
	var y : int = 0
	while(x < colunas):
		while(y<linhas):
			salasExistentes.append(Vector2i(x,y))
			y+=1
		y=0
		x+=1
	
	var primeiraSala : Vector2i = [
	Vector2i(0,0), Vector2i(2,0), Vector2i(3,0), Vector2i(5,0),
	Vector2i(0,2), Vector2i(5,2),
	Vector2i(0,3), Vector2i(5,3),
	Vector2i(0,5), Vector2i(2,5), Vector2i(3,5), Vector2i(5,5)
	].pick_random()
	
	if salasExistentes.has(primeiraSala) == false:
		primeiraSala = salasExistentes.pick_random()
	
	SalaManager.salaInicial = primeiraSala
	salasDisponiveis.append(primeiraSala)
	
	while(salasUsadas.size() < totalDeSalas):
		adicionarSala(salasDisponiveis.pick_random())
		
	var ultimaSala : Vector2i = salasUsadas[salasUsadas.size()-1]
	var maiorDistanciaAtual : float = 0
	
	var i : int = 0 
	for sala : Vector2i in salasUsadas:
		var distanciaSala : float = sala.distance_to(primeiraSala)
		if distanciaSala > maiorDistanciaAtual:
			maiorDistanciaAtual = distanciaSala
			ultimaSala = sala
		var rara : bool = false
		if i == 4 or i == 8 or i == 12:
			salasRaras.append(sala)
			rara = true
		var instanciaSala : Sala = load(verificarAdjacencia(sala, rara)).instantiate()
		add_child(instanciaSala)
		instanciaSala.global_position = Vector2i(
			sala.x*SalaManager.tamanhoTile*SalaManager.tilesHorizontal*SalaManager.separacaoEntreSalas,
			sala.y*SalaManager.tamanhoTile*SalaManager.tilesVertical*SalaManager.separacaoEntreSalas, 
		)
		instanciaSala.coordenada = sala
		i+=1
	SalaManager.salaFinal = ultimaSala
	SalaManager.setarSala(primeiraSala, player)
	minimap.posicionarIconeBoss(ultimaSala)
	minimap.posicionarIconeInicial(primeiraSala)
	minimap.posicionarIconesRaridade(salasRaras)

func verificarAdjacencia(sala : Vector2i, rara : bool) -> String:
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
				return SALA_1_CIMA.pick_random()
			if baixo:
				minimap.colocarSala(sala, Vector2i(0,0))
				return SALA_1_BAIXO.pick_random()
			if direita:
				minimap.colocarSala(sala, Vector2i(3,0))
				return SALA_1_DIREITA.pick_random()
			if esquerda:
				minimap.colocarSala(sala, Vector2i(2,0))
				return SALA_1_ESQUERDA.pick_random()
		2:
			if cima:
				if baixo:
					minimap.colocarSala(sala, Vector2i(0,1))
					return SALA_2_VERTICAL.pick_random()
				if direita:
					minimap.colocarSala(sala, Vector2i(0,2))
					return SALA_2_CIMA_DIREITA.pick_random()
				if esquerda:
					minimap.colocarSala(sala, Vector2i(4,1))
					return SALA_2_CIMA_ESQUERDA.pick_random()
			if baixo:
				if direita:
					minimap.colocarSala(sala, Vector2i(3,1))
					return SALA_2_BAIXO_DIREITA.pick_random()
				if esquerda:
					minimap.colocarSala(sala, Vector2i(2,1))
					return SALA_2_BAIXO_ESQUERDA.pick_random()
			if direita and esquerda:
				minimap.colocarSala(sala, Vector2i(1,1))
				return SALA_2_HORIZONTAL.pick_random()
				
		3:
			if cima == false:
				minimap.colocarSala(sala, Vector2i(3,2))
				return SALA_3_MCIMA.pick_random()
			if baixo == false:
				minimap.colocarSala(sala, Vector2i(1,2))
				return SALA_3_MBAIXO.pick_random()
			if direita == false:
				minimap.colocarSala(sala, Vector2i(4,2))
				return SALA_3_MDIREITA.pick_random()
			if esquerda == false:
				minimap.colocarSala(sala, Vector2i(2,2))
				return SALA_3_MESQUERDA.pick_random()
		4:
			minimap.colocarSala(sala, Vector2i(4,0))
			return SALA_4.pick_random()
		_:
			minimap.colocarSala(sala, Vector2i(4,0))
			return SALA_4.pick_random()
	minimap.colocarSala(sala, Vector2i(4,0))
	return SALA_4.pick_random()

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
