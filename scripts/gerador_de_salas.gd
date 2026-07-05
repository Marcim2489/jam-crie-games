extends Node
class_name GeradorDeSalas

const SALA_1_BAIXO : Array[String] = ["uid://bfxk6qasmyayj",
"uid://buoqq45ctd776"
]
const SALA_1_CIMA : Array[String] = ["uid://bwk55a47vu1rq",
"uid://bgff4rspbpqit"
]
const SALA_1_DIREITA : Array[String] = ["uid://ceijyrtv0psio",
"uid://b3jpmhgkv3wpu"
]
const SALA_1_ESQUERDA : Array[String] = ["uid://qrp3vbhcmy46",
"uid://dnefyld7ueslw"
]
const SALA_2_BAIXO_DIREITA : Array[String] = ["uid://bcxwp0og7w1kv",
"uid://bpjyys3bov5iy"
]
const SALA_2_BAIXO_ESQUERDA :Array[String] = ["uid://de74dkg2cjjw",
"uid://citkgwaegrgw8"
]
const SALA_2_CIMA_DIREITA : Array[String] = ["uid://8meerot418wx",
"uid://bisa845dc4c4c"
]
const SALA_2_CIMA_ESQUERDA : Array[String] = ["uid://yjpwekfop4mq",
"uid://que0iptyp40u"
]
const SALA_2_HORIZONTAL : Array[String] = ["uid://c8xmouhp83xvj",
"uid://d2klxd1uxco72"
]
const SALA_2_VERTICAL : Array[String] = ["uid://bbvw243qnk43y",
"uid://bt00xbc23slwk"
]
const SALA_3_MBAIXO : Array[String] = ["uid://bwuur3rcaj0ca",
"uid://cxarbbiudv05f"
]
const SALA_3_MCIMA : Array[String] = ["uid://dv44tqk16iyfb",
"uid://dlfaaf07f465n"
]
const SALA_3_MDIREITA : Array[String] = ["uid://cqn34viuplhrg",
"uid://bwiegda1randk"
]
const SALA_3_MESQUERDA : Array[String] = ["uid://c6s5safqrmvo7",
"uid://b0cn2dg1ebpsv"
]
const SALA_4 : Array[String] = ["uid://dal8p0elo5sae",
"uid://dttinvn32n506"
]

const CASA_1_BAIXO : String = "uid://lh2ciohauknr"
const CASA_1_CIMA : String = "uid://ca68mm587nn3r"
const CASA_1_DIREITA : String = "uid://bfn26rd06mxe5"
const CASA_1_ESQUERDA : String = "uid://karwqs64d48e"
const CASA_2_BAIXO_DIREITA : String = "uid://2l87rvuxd51i"
const CASA_2_BAIXO_ESQUERDA : String = "uid://ckqrwcgr7la1u"
const CASA_2_CIMA_DIREITA : String = "uid://bdtcpbfwf1x2u"
const CASA_2_CIMA_ESQUERDA : String = "uid://cdarkfktfeqxm"
const CASA_2_HORIZONTAL : String = "uid://b6vuoce1lltbu"
const CASA_2_VERTICAL : String = "uid://d01opfw23cbhv"
const CASA_3_MBAIXO : String = "uid://bmeq0aehenofv"
const CASA_3_MCIMA : String = "uid://w0a418sukbx1"
const CASA_3_MDIREITA : String = "uid://62l3y753pdo6"
const CASA_3_MESQUERDA : String = "uid://cye1flnvqvpw"
const CASA_4 : String = "uid://cpxil6t2y6ea3"

const RARA_1_BAIXO : String = "uid://c2e4tpammnbit"
const RARA_1_CIMA : String = "uid://bi2d8q6k3dur7"
const RARA_1_DIREITA : String = "uid://dpvjl38xuy6jo"
const RARA_1_ESQUERDA : String = "uid://dxmluxemxte5i"
const RARA_2_BAIXO_DIREITA : String = "uid://dw0js3p5wpidq"
const RARA_2_BAIXO_ESQUERDA : String = "uid://brlpp6fytarqp"
const RARA_2_CIMA_DIREITA : String = "uid://v7owi46a5ukg"
const RARA_2_CIMA_ESQUERDA : String = "uid://dlhtu0xstfbo4"
const RARA_2_HORIZONTAL : String = "uid://bb7cavu22jmrh"
const RARA_2_VERTICAL : String = "uid://c7vi052txrbrw"
const RARA_3_MBAIXO : String = "uid://c681i517gt74l"
const RARA_3_MCIMA : String = "uid://ct4l00kcybfwk"
const RARA_3_MDIREITA : String = "uid://bogqry3hhjtqq"
const RARA_3_MESQUERDA : String = "uid://cdu44woon31kf"
const RARA_4 : String = "uid://wg50eu5ylb3m"

var salasExistentes : Array[Vector2i]
var salasDisponiveis : Array[Vector2i]
var salasUsadas : Array[Vector2i]
var salasRaras : Array[Vector2i]
var ultimaSala : Vector2i

@export var colunas : int = 6
@export var linhas : int = 6

@export var totalDeSalas : int = 15
@export var player : Node2D
@export var minimap : Minimap

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("resetar"):
		#get_tree().reload_current_scene()

func _ready() -> void:
	MusicPlayer.playMusic(MusicPlayer.JORNADA_DO_CARTEIRO)
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
		
	ultimaSala = salasUsadas[salasUsadas.size()-1]
	var maiorDistanciaAtual : float = 0
	var i : int = 0 
	for sala : Vector2i in salasUsadas:
		if i == 4 or i == 8 or i == 12:
			salasRaras.append(sala)
		i+=1
	for sala : Vector2i in salasUsadas:
		var distanciaSala : float = sala.distance_to(primeiraSala)
		if distanciaSala > maiorDistanciaAtual and salasRaras.has(sala)==false:
			maiorDistanciaAtual = distanciaSala
			ultimaSala = sala
	
	for sala : Vector2i in salasUsadas:
		var instanciaSala : Sala = load(verificarAdjacencia(sala)).instantiate()
		add_child(instanciaSala)
		instanciaSala.global_position = Vector2i(
			sala.x*SalaManager.tamanhoTile*SalaManager.tilesHorizontal*SalaManager.separacaoEntreSalas,
			sala.y*SalaManager.tamanhoTile*SalaManager.tilesVertical*SalaManager.separacaoEntreSalas, 
		)
		instanciaSala.coordenada = sala

	SalaManager.salaFinal = ultimaSala
	SalaManager.setarSala(primeiraSala, player)
	minimap.posicionarIconeBoss(ultimaSala)
	minimap.posicionarIconeInicial(primeiraSala)
	minimap.posicionarIconesRaridade(salasRaras)

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
				if salasRaras.has(sala):
					return RARA_1_CIMA
				if sala == ultimaSala:
					return CASA_1_CIMA
				return SALA_1_CIMA.pick_random()
			if baixo:
				minimap.colocarSala(sala, Vector2i(0,0))
				if salasRaras.has(sala):
					return RARA_1_BAIXO
				if sala == ultimaSala:
					return CASA_1_BAIXO
				return SALA_1_BAIXO.pick_random()
			if direita:
				minimap.colocarSala(sala, Vector2i(3,0))
				if salasRaras.has(sala):
					return RARA_1_DIREITA
				if sala == ultimaSala:
					return CASA_1_DIREITA
				return SALA_1_DIREITA.pick_random()
			if esquerda:
				minimap.colocarSala(sala, Vector2i(2,0))
				if salasRaras.has(sala):
					return RARA_1_ESQUERDA
				if sala == ultimaSala:
					return CASA_1_ESQUERDA
				return SALA_1_ESQUERDA.pick_random()
		2:
			if cima:
				if baixo:
					minimap.colocarSala(sala, Vector2i(0,1))
					if salasRaras.has(sala):
						return RARA_2_VERTICAL
					if sala == ultimaSala:
						return CASA_2_VERTICAL
					return SALA_2_VERTICAL.pick_random()
				if direita:
					minimap.colocarSala(sala, Vector2i(0,2))
					if salasRaras.has(sala):
						return RARA_2_CIMA_DIREITA
					if sala == ultimaSala:
						return CASA_2_CIMA_DIREITA
					return SALA_2_CIMA_DIREITA.pick_random()
				if esquerda:
					minimap.colocarSala(sala, Vector2i(4,1))
					if salasRaras.has(sala):
						return RARA_2_CIMA_ESQUERDA
					if sala == ultimaSala:
						return CASA_2_CIMA_ESQUERDA
					return SALA_2_CIMA_ESQUERDA.pick_random()
			if baixo:
				if direita:
					minimap.colocarSala(sala, Vector2i(3,1))
					if salasRaras.has(sala):
						return RARA_2_BAIXO_DIREITA
					if sala == ultimaSala:
						return CASA_2_BAIXO_DIREITA
					return SALA_2_BAIXO_DIREITA.pick_random()
				if esquerda:
					minimap.colocarSala(sala, Vector2i(2,1))
					if salasRaras.has(sala):
						return RARA_2_BAIXO_ESQUERDA
					if sala == ultimaSala:
						return CASA_2_BAIXO_ESQUERDA
					return SALA_2_BAIXO_ESQUERDA.pick_random()
			if direita and esquerda:
				minimap.colocarSala(sala, Vector2i(1,1))
				if salasRaras.has(sala):
					return RARA_2_HORIZONTAL
				if sala == ultimaSala:
						return CASA_2_HORIZONTAL
				return SALA_2_HORIZONTAL.pick_random()
		3:
			if cima == false:
				minimap.colocarSala(sala, Vector2i(3,2))
				if salasRaras.has(sala):
					return RARA_3_MCIMA
				if sala == ultimaSala:
					return CASA_3_MCIMA
				return SALA_3_MCIMA.pick_random()
			if baixo == false:
				minimap.colocarSala(sala, Vector2i(1,2))
				if salasRaras.has(sala):
					return RARA_3_MBAIXO
				if sala == ultimaSala:
					return CASA_3_MBAIXO
				return SALA_3_MBAIXO.pick_random()
			if direita == false:
				minimap.colocarSala(sala, Vector2i(4,2))
				if salasRaras.has(sala):
					return RARA_3_MDIREITA
				if sala == ultimaSala:
					return CASA_3_MDIREITA
				return SALA_3_MDIREITA.pick_random()
			if esquerda == false:
				minimap.colocarSala(sala, Vector2i(2,2))
				if salasRaras.has(sala):
					return RARA_3_MESQUERDA
				if sala == ultimaSala:
					return CASA_3_MESQUERDA
				return SALA_3_MESQUERDA.pick_random()
		4:
			minimap.colocarSala(sala, Vector2i(4,0))
			if salasRaras.has(sala):
				return RARA_4
			if sala == ultimaSala:
				return CASA_4
			return SALA_4.pick_random()
		_:
			minimap.colocarSala(sala, Vector2i(4,0))
			if salasRaras.has(sala):
				return RARA_4
			if sala == ultimaSala:
				return CASA_4
			return SALA_4.pick_random()
	minimap.colocarSala(sala, Vector2i(4,0))
	if salasRaras.has(sala):
		return RARA_4
	if sala == ultimaSala:
		return CASA_4
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
