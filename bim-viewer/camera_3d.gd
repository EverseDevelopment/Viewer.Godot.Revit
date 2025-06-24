extends Camera3D

var orbit_rotation = Vector2(0.0, 0.0)
var distance := 10.0
var target := Vector3.ZERO
var orbit_sensitivity := 0.01
var zoom_sensitivity := 0.5
var pan_sensitivity := 0.01

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		orbit_rotation.x -= event.relative.y * orbit_sensitivity
		orbit_rotation.y -= event.relative.x * orbit_sensitivity
		orbit_rotation.x = clamp(orbit_rotation.x, -90, 90)

	elif event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE):
		var pan = -transform.basis.x * event.relative.x * pan_sensitivity
		pan += transform.basis.y * event.relative.y * pan_sensitivity
		target += pan

	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_UP:
		distance = max(1.0, distance - zoom_sensitivity)
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		distance += zoom_sensitivity

func _process(delta):
	var rot = Basis(Vector3.UP, orbit_rotation.y) * Basis(Vector3.RIGHT, orbit_rotation.x)
	global_transform.origin = target + rot * Vector3(0, 0, distance)
	look_at(target)
