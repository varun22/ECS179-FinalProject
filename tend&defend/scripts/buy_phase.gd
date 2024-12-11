class_name BuyPhase
extends Node2D

var currency_to_switch:int = globalVars.currency_to_switch
var currency_to_upgrade:int = globalVars.currency_to_upgrade
var time_start:bool = true
var buy_phase_time = 30.0
var buy_phase_timer:Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	buy_phase_timer = Timer.new()
	buy_phase_timer.one_shot = true
	add_child(buy_phase_timer)
	buy_phase_timer.start(buy_phase_time)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if buy_phase_timer.is_stopped():
		scene_switcher.switch_scene("res://scenes/stage1.tscn")

# When pressed, switches to power tower if enough currency
func _on_power_upgrade_1_pressed() -> void:
	if globalVars.currency >= currency_to_switch:
		globalVars.currency -= currency_to_switch
		turretType.type_array[0] = turretType.Type.POWER

# When pressed, switches to range tower if enough currency
func _on_range_upgrade_1_pressed() -> void:
	if globalVars.currency >= currency_to_switch:
		globalVars.currency -= currency_to_switch
		turretType.type_array[0] = turretType.Type.REACH

# When pressed, switches to frequency tower if enough currency
func _on_frequency_upgrade_1_pressed() -> void:
	if globalVars.currency >= currency_to_switch:
		globalVars.currency -= currency_to_switch
		turretType.type_array[0] = turretType.Type.FREQUENCY

# When confirmed, changes to upgrade button, which upgrades level of particular tower type chosen
func _on_confirm_1_pressed() -> void:
	$"Lane 1/Power Upgrade 1".visible = false
	$"Lane 1/Range Upgrade 1".visible = false
	$"Lane 1/Frequency Upgrade 1".visible = false
	if turretType.type_array[0] == turretType.Type.POWER:
		$"Lane 1/Upgrade 1".text = "Upgrade to Level " + str(turretType.power_level[0] + 1)
	elif turretType.type_array[0] == turretType.Type.REACH:
		$"Lane 1/Upgrade 1".text = "Upgrade to Level " + str(turretType.reach_level[0] + 1)
	elif turretType.type_array[0] == turretType.Type.FREQUENCY:
		$"Lane 1/Upgrade 1".text = "Upgrade to Level " + str(turretType.frequency_level[0] + 1)
	elif turretType.type_array[0] == turretType.Type.BASIC:
		$"Lane 1/Upgrade 1".text = "Basic Turret Cannot Upgrade"
	$"Lane 1/Upgrade 1".visible = true

# When upgrade, if enough currency, increases level of current tower type by 1
func _on_upgrade_1_pressed() -> void:
	if globalVars.currency >= currency_to_upgrade:
		globalVars.currency -= currency_to_upgrade
		if turretType.type_array[0] == turretType.Type.POWER:
			turretType.power_level[0] += 1
			$"Lane 1/Upgrade 1".text = "Upgrade to Level " + str(turretType.power_level[0] + 1)
		elif turretType.type_array[0] == turretType.Type.REACH:
			turretType.reach_level[0] += 1
			$"Lane 1/Upgrade 1".text = "Upgrade to Level " + str(turretType.reach_level[0] + 1)
		elif turretType.type_array[0] == turretType.Type.FREQUENCY:
			turretType.frequency_level[0] += 1
			$"Lane 1/Upgrade 1".text = "Upgrade to Level " + str(turretType.frequency_level[0] + 1)


func _on_power_upgrade_2_pressed() -> void:
	if globalVars.currency >= currency_to_switch:
		globalVars.currency -= currency_to_switch
		turretType.type_array[1] = turretType.Type.POWER

func _on_range_upgrade_2_pressed() -> void:
	if globalVars.currency >= currency_to_switch:
		globalVars.currency -= currency_to_switch
		turretType.type_array[1] = turretType.Type.REACH

func _on_frequency_upgrade_2_pressed() -> void:
	if globalVars.currency >= currency_to_switch:
		globalVars.currency -= currency_to_switch
		turretType.type_array[1] = turretType.Type.FREQUENCY

func _on_confirm_2_pressed() -> void:
	$"Lane 2/Power Upgrade 2".visible = false
	$"Lane 2/Range Upgrade 2".visible = false
	$"Lane 2/Frequency Upgrade 2".visible = false
	if turretType.type_array[1] == turretType.Type.POWER:
		$"Lane 2/Upgrade 2".text = "Upgrade to Level " + str(turretType.power_level[1] + 1)
	elif turretType.type_array[1] == turretType.Type.REACH:
		$"Lane 2/Upgrade 2".text = "Upgrade to Level " + str(turretType.reach_level[1] + 1)
	elif turretType.type_array[1] == turretType.Type.FREQUENCY:
		$"Lane 2/Upgrade 2".text = "Upgrade to Level " + str(turretType.frequency_level[1] + 1)
	elif turretType.type_array[1] == turretType.Type.BASIC:
		$"Lane 2/Upgrade 2".text = "Basic Turret Cannot Upgrade"
	$"Lane 2/Upgrade 2".visible = true

func _on_upgrade_2_pressed() -> void:
	if globalVars.currency >= currency_to_upgrade:
		globalVars.currency -= currency_to_upgrade
		if turretType.type_array[1] == turretType.Type.POWER:
			turretType.power_level[1] += 1
			$"Lane 2/Upgrade 2".text = "Upgrade to Level " + str(turretType.power_level[1] + 1)
		elif turretType.type_array[1] == turretType.Type.REACH:
			turretType.reach_level[1] += 1
			$"Lane 2/Upgrade 2".text = "Upgrade to Level " + str(turretType.reach_level[1] + 1)
		elif turretType.type_array[1] == turretType.Type.FREQUENCY:
			turretType.frequency_level[1] += 1
			$"Lane 2/Upgrade 2".text = "Upgrade to Level " + str(turretType.frequency_level[1] + 1)


func _on_power_upgrade_3_pressed() -> void:
	if globalVars.currency >= currency_to_switch:
		globalVars.currency -= currency_to_switch
		turretType.type_array[2] = turretType.Type.POWER

func _on_range_upgrade_3_pressed() -> void:
	if globalVars.currency >= currency_to_switch:
		globalVars.currency -= currency_to_switch
		turretType.type_array[2] = turretType.Type.REACH

func _on_frequency_upgrade_3_pressed() -> void:
	if globalVars.currency >= currency_to_switch:
		globalVars.currency -= currency_to_switch
		turretType.type_array[2] = turretType.Type.FREQUENCY

func _on_confirm_3_pressed() -> void:
	$"Lane 3/Power Upgrade 3".visible = false
	$"Lane 3/Range Upgrade 3".visible = false
	$"Lane 3/Frequency Upgrade 3".visible = false
	if turretType.type_array[2] == turretType.Type.POWER:
		$"Lane 3/Upgrade 3".text = "Upgrade to Level " + str(turretType.power_level[2] + 1)
	elif turretType.type_array[2] == turretType.Type.REACH:
		$"Lane 3/Upgrade 3".text = "Upgrade to Level " + str(turretType.reach_level[2] + 1)
	elif turretType.type_array[2] == turretType.Type.FREQUENCY:
		$"Lane 3/Upgrade 3".text = "Upgrade to Level " + str(turretType.frequency_level[2] + 1)
	elif turretType.type_array[2] == turretType.Type.BASIC:
		$"Lane 3/Upgrade 3".text = "Basic Turret Cannot Upgrade"
	$"Lane 3/Upgrade 3".visible = true

func _on_upgrade_3_pressed() -> void:
	if globalVars.currency >= currency_to_upgrade:
		globalVars.currency -= currency_to_upgrade
		if turretType.type_array[2] == turretType.Type.POWER:
			turretType.power_level[2] += 1
			$"Lane 3/Upgrade 3".text = "Upgrade to Level " + str(turretType.power_level[2] + 1)
		elif turretType.type_array[2] == turretType.Type.REACH:
			turretType.reach_level[2] += 1
			$"Lane 3/Upgrade 3".text = "Upgrade to Level " + str(turretType.reach_level[2] + 1)
		elif turretType.type_array[2] == turretType.Type.FREQUENCY:
			turretType.frequency_level[2] += 1
			$"Lane 3/Upgrade 3".text = "Upgrade to Level " + str(turretType.frequency_level[2] + 1)


func _on_power_upgrade_4_pressed() -> void:
	if globalVars.currency >= currency_to_switch:
		globalVars.currency -= currency_to_switch
		turretType.type_array[3] = turretType.Type.POWER

func _on_range_upgrade_4_pressed() -> void:
	if globalVars.currency >= currency_to_switch:
		globalVars.currency -= currency_to_switch
		turretType.type_array[3] = turretType.Type.REACH

func _on_frequency_upgrade_4_pressed() -> void:
	if globalVars.currency >= currency_to_switch:
		globalVars.currency -= currency_to_switch
		turretType.type_array[3] = turretType.Type.FREQUENCY

func _on_confirm_4_pressed() -> void:
	$"Lane 4/Power Upgrade 4".visible = false
	$"Lane 4/Range Upgrade 4".visible = false
	$"Lane 4/Frequency Upgrade 4".visible = false
	if turretType.type_array[3] == turretType.Type.POWER:
		$"Lane 4/Upgrade 4".text = "Upgrade to Level " + str(turretType.power_level[3] + 1)
	elif turretType.type_array[3] == turretType.Type.REACH:
		$"Lane 4/Upgrade 4".text = "Upgrade to Level " + str(turretType.reach_level[3] + 1)
	elif turretType.type_array[3] == turretType.Type.FREQUENCY:
		$"Lane 4/Upgrade 4".text = "Upgrade to Level " + str(turretType.frequency_level[3] + 1)
	elif turretType.type_array[3] == turretType.Type.BASIC:
		$"Lane 4/Upgrade 4".text = "Basic Turret Cannot Upgrade"
	$"Lane 4/Upgrade 4".visible = true

func _on_upgrade_4_pressed() -> void:
	if globalVars.currency >= currency_to_upgrade:
		globalVars.currency -= currency_to_upgrade
		if turretType.type_array[3] == turretType.Type.POWER:
			turretType.power_level[3] += 1
			$"Lane 4/Upgrade 4".text = "Upgrade to Level " + str(turretType.power_level[3] + 1)
		elif turretType.type_array[3] == turretType.Type.REACH:
			turretType.reach_level[3] += 1
			$"Lane 4/Upgrade 4".text = "Upgrade to Level " + str(turretType.reach_level[3] + 1)
		elif turretType.type_array[3] == turretType.Type.FREQUENCY:
			turretType.frequency_level[3] += 1
			$"Lane 4/Upgrade 4".text = "Upgrade to Level " + str(turretType.frequency_level[3] + 1)


func _on_power_upgrade_5_pressed() -> void:
	if globalVars.currency >= currency_to_switch:
		globalVars.currency -= currency_to_switch
		turretType.type_array[4] = turretType.Type.POWER

func _on_range_upgrade_5_pressed() -> void:
	if globalVars.currency >= currency_to_switch:
		globalVars.currency -= currency_to_switch
		turretType.type_array[4] = turretType.Type.REACH

func _on_frequency_upgrade_5_pressed() -> void:
	if globalVars.currency >= currency_to_switch:
		globalVars.currency -= currency_to_switch
		turretType.type_array[4] = turretType.Type.FREQUENCY

func _on_confirm_5_pressed() -> void:
	$"Lane 5/Power Upgrade 5".visible = false
	$"Lane 5/Range Upgrade 5".visible = false
	$"Lane 5/Frequency Upgrade 5".visible = false
	if turretType.type_array[4] == turretType.Type.POWER:
		$"Lane 5/Upgrade 5".text = "Upgrade to Level " + str(turretType.power_level[4] + 1)
	elif turretType.type_array[4] == turretType.Type.REACH:
		$"Lane 5/Upgrade 5".text = "Upgrade to Level " + str(turretType.reach_level[4] + 1)
	elif turretType.type_array[4] == turretType.Type.FREQUENCY:
		$"Lane 5/Upgrade 5".text = "Upgrade to Level " + str(turretType.frequency_level[4] + 1)
	elif turretType.type_array[4] == turretType.Type.BASIC:
		$"Lane 5/Upgrade 5".text = "Basic Turret Cannot Upgrade"
	$"Lane 5/Upgrade 5".visible = true

func _on_upgrade_5_pressed() -> void:
	if globalVars.currency >= currency_to_upgrade:
		globalVars.currency -= currency_to_upgrade
		if turretType.type_array[4] == turretType.Type.POWER:
			turretType.power_level[4] += 1
			$"Lane 5/Upgrade 5".text = "Upgrade to Level " + str(turretType.power_level[4] + 1)
		elif turretType.type_array[4] == turretType.Type.REACH:
			turretType.reach_level[4] += 1
			$"Lane 5/Upgrade 5".text = "Upgrade to Level " + str(turretType.reach_level[4] + 1)
		elif turretType.type_array[4] == turretType.Type.FREQUENCY:
			turretType.frequency_level[4] += 1
			$"Lane 5/Upgrade 5".text = "Upgrade to Level " + str(turretType.frequency_level[4] + 1)
