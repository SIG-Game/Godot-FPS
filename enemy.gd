extends StaticBody3D

@onready var material : Material = $Body.get_surface_override_material(0)
var def_color : Color
var damage_color : Color = Color.RED

var health : int = 5:
	set(value):
		health = value
		print("Enemy health: %d" % health)
		if health <= 0:
			self.queue_free()

func _ready() -> void:
	def_color = material.albedo_color

func _on_hurt_area_area_entered(area: Area3D) -> void:
	if area is Bullet:
		area.queue_free()
		material.albedo_color = damage_color
		await get_tree().create_timer(0.5).timeout
		material.albedo_color = def_color
		health -= 1
