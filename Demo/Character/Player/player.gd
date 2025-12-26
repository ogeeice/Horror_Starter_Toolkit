extends CharacterBody3D

@export_range(0, 10.0, 0.1) var speed := 5.0
@export_range(0, 10.0, 0.1) var jump_height := 5.0
@export_range(0, 100.0, 0.1) var fall_gravity := 50.0

@onready var new_veloity
@onready var input_dir
@onready var camera_pivot = $CameraPivot

func _process(_delta: float) -> void:
	$"Dynamic Footsteps".Activate($"Dynamic Footsteps".Track_list[0])
	## Footsteps should be activated here
	pass

func _physics_process(_delta: float) -> void:
	move()
	move_and_slide()

func move():
	new_veloity = Vector2.ZERO
	input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (camera_pivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		new_veloity = Vector2(direction.x,direction.z) * speed
	velocity = Vector3(new_veloity.x, velocity.y,new_veloity.y)
