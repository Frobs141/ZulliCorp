extends HSlider

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Ensure slider uses a dB range appropriate for audio volume
	min_value = -50.0
	max_value = 10.0
	step = 0.1

	var bus = AudioServer.get_bus_index("Master")
	# Read the current bus volume (float in dB) and set the slider value
	value = AudioServer.get_bus_volume_db(bus)

	# Connect the slider signal if not already connected in the editor
	var cb = Callable(self, "_on_value_changed")
	if not is_connected("value_changed", cb):
		connect("value_changed", cb)


func _on_value_changed(new_value: float) -> void:
	var bus = AudioServer.get_bus_index("Master")
	# Set the bus volume; requires both bus index and dB value
	AudioServer.set_bus_volume_db(bus, new_value)
