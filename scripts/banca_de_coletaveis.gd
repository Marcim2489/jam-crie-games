extends Node2D
const COLETAVEIS : Array[String] = ["uid://c37lbiu5707ns", 
"uid://dewkpjli33wxh",
"uid://cuis7toyfxbwf"
]
const MARMITEX : String = "uid://b1mjuqegu6h44"

func _ready() -> void:
	var coletavel1 = load(COLETAVEIS.pick_random()).instantiate()
	add_child(coletavel1)
	coletavel1.global_position = global_position + Vector2.RIGHT*24
	var coletavel2 = load(COLETAVEIS.pick_random()).instantiate()
	add_child(coletavel2)
	coletavel2.global_position = global_position + Vector2.LEFT*24
	var marmitex = load(MARMITEX).instantiate()
	add_child(marmitex)
	marmitex.global_position = global_position + Vector2.DOWN* 32
