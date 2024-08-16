class_name CloudShadowParallaxLayer extends AutoScrollingParallaxLayer

@export var clipping_mask_width: int
@export var clipping_mask: Texture
@onready var texture_rect = $TextureRect

func _ready():
	texture_rect.material = texture_rect.material.duplicate()
	texture_rect.material.set_shader_parameter("ClippingMask", clipping_mask)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)
	var percentage_x_offset = motion_offset.x / clipping_mask_width
	texture_rect.material.set_shader_parameter("ClippingMaskOffset", percentage_x_offset)
	
