extends Produto

var aumentoVelocidade : int = 50

func aplicarEfeito(player : Player):
	#print("s")
	player.velocidadeMovimento += aumentoVelocidade

func retirarEfeito(player : Player):
	player.velocidadeMovimento -= aumentoVelocidade
