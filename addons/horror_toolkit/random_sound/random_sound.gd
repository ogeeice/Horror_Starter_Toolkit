extends Area3D

@export_group("Track Details", "Track")
@export var Active: bool = false ## Ensure to activate once track list not empty
@export var Track_randomizer: bool = false ## if True playback track is selected at random. If False playback track defaults to the first index in the array Track list
@export var Track_list: Array[AudioStream] ## Array holding the list of tracks to play upon collision with player body
@export_range(-80.0, 80.0, 0.1) var Volume := 0.0

@onready var Audio_streamer = AudioStreamPlayer3D.new()

func _ready() -> void:
	randomize()
	add_child(Audio_streamer)
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and Active == true:
		Audio_streamer.volume_db = Volume
		if Track_randomizer == true:
			Audio_streamer.stream = Track_list[randi_range(0,Track_list.size()-1)]
		else:
			Audio_streamer.stream = Track_list[0]
		Audio_streamer.play()
