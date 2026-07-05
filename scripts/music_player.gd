extends AudioStreamPlayer

const VIOLA_MINHA_VIOLA : AudioStream = preload("uid://bh3t8oyj7emer")
const PIANO_MEU_PIANO = preload("uid://clhxukgc4emob")
const JORNADA_DO_CARTEIRO = preload("uid://u86ixtrm0hjr")

func playMusic(music : AudioStream, volume : float = 1):
	volume_linear = volume
	if music == stream:
		return
	stream = music
	play()
