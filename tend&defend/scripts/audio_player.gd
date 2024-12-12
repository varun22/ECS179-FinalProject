class_name AudioPlayer
extends AudioStreamPlayer2D
#Script for controlling speed of background music and pitch - Wasnt happy with how it was sounding so disabled it for now

@export var audio_player: AudioStreamPlayer2D 
@export var base_speed: float = 1.0 
@export var speed_increment: float = 0.05  # How fast to speed up audio
@export var target_bus: String = "Master" 

const stage1_music = preload("res://assets/music/background.ogg")
const main_menu_music = preload("res://assets/music/main menu.ogg")

var current_wave: int = 1  
var is_playing: bool = false 

func _ready() -> void:
	pass
	#audio_player.pitch_scale = base_speed
	#audio_player.play() 
	#is_playing = true

# Helper function to play music
func play_music(music: AudioStream):
	if stream == music:
		return

	stream = music
	play()

func play_stage1():
	play_music(stage1_music)
	
func play_main_menu():
	play_music(main_menu_music)

# Called by wave manager
func on_wave_update(wave: int) -> void:
	current_wave = wave
	#if(current_wave < 11):
		#update_music_speed()
	

func update_music_speed() -> void:
	#Increase music playback speed
	var new_pitch_scale = base_speed + (current_wave - 1) * speed_increment
	audio_player.pitch_scale = new_pitch_scale
	
	# 
	#var pitch_shift = 1.0 / new_pitch_scale
	#var semitone_shift = 12 * log(new_pitch_scale) / log(2)
	#set_pitch_shift(-semitone_shift)
	print("Wave: ", current_wave, " | Playback speed (pitch scale): ", new_pitch_scale)


# Ensures the pitch shift effect is applied to the audio bus
func set_pitch_shift(pitch: float) -> void:
	var bus_index = AudioServer.get_bus_index(target_bus)
	
	for i in range(AudioServer.get_bus_effect_count(bus_index)):
		var effect = AudioServer.get_bus_effect(bus_index, i)

		if effect is AudioEffectPitchShift:
			effect.pitch_scale = pitch
			break

# Stop the background music
func stop_music() -> void:
	audio_player.stop()
	is_playing = false
	print("Background music stopped.")
