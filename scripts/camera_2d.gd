extends Camera2D

var velocidade : int = 1000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SalaManager.entrouNaSala.connect(posicionar)

func posicionar(sala : Vector2i):
	global_position = Vector2i(
		sala.x*16*18*2,
		sala.y*16*12*2, 
	)
