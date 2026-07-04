extends Camera2D

func _ready() -> void:
	SalaManager.entrouNaSala.connect(posicionar)

func posicionar(sala : Vector2i):
	global_position = Vector2i(
		sala.x*SalaManager.tamanhoTile*SalaManager.tilesHorizontal*SalaManager.separacaoEntreSalas,
		sala.y*SalaManager.tamanhoTile*SalaManager.tilesVertical*SalaManager.separacaoEntreSalas, 
	)
