extends State


func  update(_delta: float) -> void:
	
	if player_node.is_on_floor():
		if player_node.new_veloity.length() >= 0:
			state_machine.change_state("move")
		
		if Input.is_action_just_pressed("jump"):
			state_machine.change_state("jump")
	else:
		state_machine.change_state("fall")

func  physics_update(_delta: float) -> void:
	pass
