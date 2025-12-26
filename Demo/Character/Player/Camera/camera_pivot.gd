extends Node3D

var mousetstate = true

@onready var cam = $CameraHolder/Camera
@onready var cam_holder  = $CameraHolder

@export_range(0, 1.0, 0.1) var sensitivity := 0.5
@export var Anchor: Marker3D ## Attach to a Marker3D child node of character

@export_group("Camer Bob","head_bob")
@export_range(0, 5.0, 0.1) var head_bob_frequency := 2.0
@export_range(0, 0.1, 0.01) var head_bob_amplitude := 0.06
var head_bob_time = 0.0

func _ready() -> void:
	pointer_state()

## camera rotation logic
func _input(event):
	if event is InputEventMouseMotion:
		#Anchor.rotation.y = lerp(Anchor.rotation.y,deg_to_rad(-event.relative.x * sensitivity),0.5)
		Anchor.rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		
		#Anchor.rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		cam_holder.rotate_x(deg_to_rad(-event.relative.y * sensitivity))
		cam_holder.rotation.x = clamp(cam_holder.rotation.x, deg_to_rad(-90), deg_to_rad(90))
	
	if Input.is_action_just_pressed("ui_cancel"):
		pointer_state()
	
	if Input.is_action_just_pressed("zoom"):
		camera_zoom(50,0.5)
	elif Input.is_action_just_released("zoom"):
		camera_zoom(70,0.5)

func _process(_delta: float) -> void:
	interactivity()

func _physics_process(delta: float) -> void: 
	global_transform = lerp(global_transform,Anchor.get_global_transform_interpolated(),0.25)
	#global_transform = Anchor.get_global_transform_interpolated()
	head_bob_time += delta * get_parent().velocity.length() * float(get_parent().is_on_floor())
	cam_holder.transform.origin = _headbob(head_bob_time)

## camera shae function ( camera shake force, camera shake loop amount, camera shake loop duration)
func shake(shake_force: float, shake_loop: int, shake_duration: float) -> void:
	
	var shake_tween = get_tree().create_tween().set_loops(shake_loop)
	shake_tween.tween_property(cam, "rotation_degrees", Vector3(randf_range(-shake_force, shake_force), randf_range(-shake_force, shake_force), 0), shake_duration)
	shake_tween.tween_property(cam, "rotation_degrees", Vector3(randf_range(-shake_force, shake_force), randf_range(-shake_force, shake_force), 0), shake_duration)
	
	if shake_tween.loop_finished:
		cam.rotation_degrees = Vector3.ZERO

## mouse pointer function to toggle mouse visibility
func pointer_state() -> void:
	mousetstate = !mousetstate
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if (mousetstate == false) else Input.MOUSE_MODE_VISIBLE)

## camera zoom function (new zoom distance, transition from current zoom to new zoom distance)
func camera_zoom(zoom:= 70, zoom_speed:= 0.5) -> void:
	var zoom_tween = get_tree().create_tween()
	zoom_tween.tween_property(cam, "fov", zoom, zoom_speed)

## calculate character head bob
func _headbob(time: float) -> Vector3:
	var cam_position = Vector3.ZERO
	cam_position.y = sin(time * head_bob_frequency) * head_bob_amplitude
	cam_position.x = cos(time * head_bob_frequency / 2) * head_bob_amplitude
	return cam_position

func interactivity() -> void:
	var intreract_ray = %Interaction_ray
	
	if intreract_ray.is_colliding():
		var colliding_object = intreract_ray.get_collider()
		if colliding_object.is_in_group("interactive"):
			$HUD/Interact.visible = true
			$HUD/Normal.visible = false
			if Input.is_action_just_pressed("interact"):
					colliding_object.interact()
		else:
			$HUD/Interact.visible = false
			$HUD/Normal.visible = true
	else:
		$HUD/Interact.visible = false
		$HUD/Normal.visible = true
