class_name WeaponFlagsTracker
extends Object

enum WeaponFlags {
	LOADED = 1 << 0,
	EMPTY = 1 << 1,
	COOKED = 1 << 2,
}

func update_flags() -> void:
	pass
