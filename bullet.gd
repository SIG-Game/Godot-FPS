class_name Bullet extends Area3D

const SPEED := 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.translate(Vector3.FORWARD * SPEED * delta)

func _on_timer_timeout() -> void:
	self.queue_free()
