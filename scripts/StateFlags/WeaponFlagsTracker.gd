class_name WeaponFlagsTracker
extends Object

enum WeaponFlags {
	LOADED = 1 << 0,
	EMPTY = 1 << 1,
	COOKED = 1 << 2,
	TRIGGERED = 1 << 3,
	FIRING = 1 << 4,
	RELOADING = 1 << 5,
}

const CAPACITY_FLAGS: int = (
		WeaponFlags.LOADED|
		WeaponFlags.EMPTY
)

const FIRE_FLAGS: int = (
		WeaponFlags.TRIGGERED|
		WeaponFlags.FIRING
)

var _owner: Weapon = null
var weapon_flags: int
var flags_as_string: String:
	get:
		return flags_to_string()


func _init(node_owner: Node3D) -> void:
	_owner = node_owner


func update_flags():
	# For now, the weapon is always COOKED. 
	# Used for FIRING flag
	weapon_flags |= WeaponFlags.COOKED
	
	weapon_flags &= ~CAPACITY_FLAGS
	if _owner._weapon_fire.current_bullets > 0:
		weapon_flags |= WeaponFlags.LOADED
	else:
		weapon_flags |= WeaponFlags.EMPTY
#
	if _owner.is_reloading:
		weapon_flags |= WeaponFlags.RELOADING
	else:
		weapon_flags &= ~WeaponFlags.RELOADING
		
	if _owner._weapon_fire._trigger_is_pulled:
		weapon_flags |= WeaponFlags.TRIGGERED
		if weapon_flags & WeaponFlags.COOKED:
			weapon_flags |= WeaponFlags.FIRING
	else:
		weapon_flags &= ~FIRE_FLAGS

	Hud.Print_property("WeaponStates", flags_as_string)


func flags_to_string() -> String:
	var flags: String = ""
	if (weapon_flags & WeaponFlags.LOADED) != 0:
		flags = flags + "LOADED, "
	if (weapon_flags & WeaponFlags.EMPTY) != 0:
		flags = flags + "EMPTY, "
	if (weapon_flags & WeaponFlags.COOKED) != 0:
		flags = flags + "COOKED, "
	if (weapon_flags & WeaponFlags.TRIGGERED) != 0:
		flags = flags + "TRIGGERED, "
	if (weapon_flags & WeaponFlags.FIRING) != 0:
		flags = flags + "FIRING, "
	if (weapon_flags & WeaponFlags.RELOADING) != 0:
		flags = flags + "RELOADING, "
	return flags
