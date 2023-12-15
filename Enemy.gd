extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_contact_monitor(true)
	set_max_contacts_reported(1)
	connect("body_entered", self, "_on_Semi_Auto_Bullet_body_entered")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Semi_Auto_Bullet_body_entered(body):
	if body.is_in_group('Bullet'):
		queue_free()

func _on_Visibility_screen_exited():
	queue_free()
