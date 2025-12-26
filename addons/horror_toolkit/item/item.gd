extends Area3D

@export_enum("None", "Key", "Battery") var Item_type : int ## Determines the item type. "KEY" used to unlock locked doors and "BATTERY" for additional torchlight batteries

@export_group("Torch Battery","Battery")
@export_range(0, 10, 1) var Battery_amount : int ## Amount of battery a single instance adds to torchlight upon collision. Item type must be "BATTERY"

@export_group("Door Key","Key")
@export var Key_unlock : Node3D ## Specific door node to be unlocked upon collision. Item type must be "KEY"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.add_to_group("interactive")
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		update_status()

func interact()-> void:
	update_status()
	pass

func update_status() -> void:
	if Item_type == 1:
		## Updates door status to enable active use
		Key_unlock.enabled  = true
	
	if Item_type == 2:
		## Update the value of torchlight battery
		var a = get_tree().get_first_node_in_group("torchlight")
		a.Battery_Amount += Battery_amount
	self.queue_free()
