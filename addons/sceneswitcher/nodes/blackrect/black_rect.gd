class_name SceneSwitcherBlackRect
extends CanvasLayer

signal finished

@onready var color_rect: ColorRect = $ColorRect
@onready var fade_duration: float = ProjectSettings.get_setting(SceneSwitcherHandler.PROPERTY_NAME_FADE_DURATION, 0.5)


func _ready() -> void:
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE


func fade_out() -> void:
	await get_tree().create_tween().tween_property(color_rect, "color:a", 0.0, fade_duration).finished
	finished.emit()


func fade_in() -> void:
	await get_tree().create_tween().tween_property(color_rect, "color:a", 1.0, fade_duration).finished
	finished.emit()
