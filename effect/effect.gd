class_name Effect extends Resource



enum EffectType {

	INSTANT,

	DURATION,

	PASSIVE,

	TRIGGER,

}



@export var effect_type: EffectType

@export var duration:= 0.0

@export var tick_rate:= 0.0

