extends CharacterBody3D

const JUMP_FORCE: float = 4.5
const SPEED : float = 5
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
const X_ROT : int = 45

#Mouse movement / rotation
const MOUSE_SENSISTIVITY : float = 0.002
@onready var camera = $Camera3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * MOUSE_SENSISTIVITY)
		camera.rotate_x(-event.relative.y * MOUSE_SENSISTIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-X_ROT), deg_to_rad(X_ROT))

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			
	

func _physics_process(delta: float) -> void:
	if not self.is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = -0.1
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_FORCE
	
	var input_vector : Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_vector.x, 0, input_vector.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()
