extends Area3D

@export_enum("None", "Custom", "Normal") var Door_type : int 
@export var enabled : bool = true ## Determines if the player can interact with door
@export var active : bool  = false ## Determines if the door is active or not.
@export var Door : AnimatableBody3D ## Variable pointing to the Animatable node housing the Door mesh

@export_group("Custom Door Details", "Custom")
@export var Custom_Door_Open_Direction : Vector3 ## Direction which door opens with
@export_range(0, 1.0, 0.1) var Custom_Door_speed : float ## Speed at which door opening animation plays

@export_group("Normal Door Details", "Door")
@export var Door_Open_Direction : Vector3  ## Direction which door opens with
@export_range(0, 1.0, 0.1) var Door_speed : float  ## Speed at which door opening animation plays
@onready var Door_tween

func _ready() -> void:
	self.add_to_group("interactive")

	if enabled == true:
		activate()

func interact(start:= false)-> void:
	if start == false:
		if enabled == true:
			active = !active
			activate()

func activate()-> void:
	Door_tween = get_tree().create_tween()
	## Script below details motion for a custom door opening sequence
	if Door_type == 1:
		if active == true:
			Door_tween.tween_property(Door, "position", Custom_Door_Open_Direction, Custom_Door_speed)
		else:
			Door_tween.tween_property(Door, "position", Vector3(0.0, 0.0, 0.0), Custom_Door_speed)
	
	## Script below details motion for a regular door opening sequence
	if Door_type == 2:
		if active == true:
			Door_tween.tween_property(Door, "rotation_degrees", Door_Open_Direction, Door_speed)
		else:
			Door_tween.tween_property(Door, "rotation_degrees", Vector3(0.0, 0.0, 0.0), Door_speed)

func _exit_tree() -> void:
	if Door_tween != null:
		Door_tween.kill()
