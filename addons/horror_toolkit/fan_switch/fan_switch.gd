extends Area3D

@export var fan_source : Node3D ## variable to hold fan node path
@export var enabled : bool = true ## Determines if the player can interact with fan
@export var active : bool  = false ## Determines if the fan is active on or not.
@export_range(0, 1.0, 0.1) var rotation_speed : float ## The lower the value the faster the fan speed and the higher the amount the slower the fan speed
@onready var fan_tween

func _ready() -> void:
	self.add_to_group("interactive")
	
	if enabled == true:
		activate()

func interact(start:= false)-> void:
	if start == false:
		active = !active
		if enabled == true:
			activate()

func activate()-> void:
	fan_tween = get_tree().create_tween().set_loops()
	if active == true:
		fan_tween.tween_property(fan_source,"rotation:y",TAU,rotation_speed).as_relative()
	else:
		fan_tween.tween_property(fan_source,"rotation:y",0, 1).as_relative()

func _exit_tree() -> void:
	fan_tween.kill()
