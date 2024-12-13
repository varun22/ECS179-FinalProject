class_name BuyPhase
extends Node2D

var currency_to_switch:int = globalVars.currency_to_switch
var currency_to_upgrade:int = globalVars.currency_to_upgrade
var currency_to_tend:int = globalVars.currency_to_tend
var time_start:bool = true
var buy_phase_time = 30.0
var buy_phase_timer:Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	buy_phase_timer = Timer.new()
	buy_phase_timer.one_shot = true
	add_child(buy_phase_timer)
	buy_phase_timer.start(buy_phase_time)
	
	$TimerProgress.max_value = buy_phase_time
	$TimerProgress.value = buy_phase_time
	
	# Give text cost values as well
	$"Lane 1/Power Upgrade 1".text = "Make Power Turret\nCost: " + str(currency_to_switch)
	$"Lane 2/Power Upgrade 2".text = "Make Power Turret\nCost: " + str(currency_to_switch)
	$"Lane 3/Power Upgrade 3".text = "Make Power Turret\nCost: " + str(currency_to_switch)
	$"Lane 4/Power Upgrade 4".text = "Make Power Turret\nCost: " + str(currency_to_switch)
	$"Lane 5/Power Upgrade 5".text = "Make Power Turret\nCost: " + str(currency_to_switch)
	
	$"Lane 1/Range Upgrade 1".text = "Make Range Turret\nCost: " + str(currency_to_switch)
	$"Lane 2/Range Upgrade 2".text = "Make Range Turret\nCost: " + str(currency_to_switch)
	$"Lane 3/Range Upgrade 3".text = "Make Range Turret\nCost: " + str(currency_to_switch)
	$"Lane 4/Range Upgrade 4".text = "Make Range Turret\nCost: " + str(currency_to_switch)
	$"Lane 5/Range Upgrade 5".text = "Make Range Turret\nCost: " + str(currency_to_switch)
	
	$"Lane 1/Frequency Upgrade 1".text = "Make Frequency Turret\nCost: " + str(currency_to_switch)
	$"Lane 2/Frequency Upgrade 2".text = "Make Frequency Turret\nCost: " + str(currency_to_switch)
	$"Lane 3/Frequency Upgrade 3".text = "Make Frequency Turret\nCost: " + str(currency_to_switch)
	$"Lane 4/Frequency Upgrade 4".text = "Make Frequency Turret\nCost: " + str(currency_to_switch)
	$"Lane 5/Frequency Upgrade 5".text = "Make Frequency Turret\nCost: " + str(currency_to_switch)
	
	# Check if turret is alive, if not, give option to tend (revive) turret
	if turretType.turret_health[0] == 0.0:
		$"Lane 1/Tend1".visible = true
		$"Lane 1/Tend1".text = "Tend to Turret?\nCost: " + str(currency_to_tend)
		$"Lane 1/Power Upgrade 1".visible = false
		$"Lane 1/Range Upgrade 1".visible = false
		$"Lane 1/Frequency Upgrade 1".visible = false
		$"Lane 1/Confirm 1".visible = false
	
	if turretType.turret_health[1] == 0.0:
		$"Lane 2/Tend2".visible = true
		$"Lane 2/Tend2".text = "Tend to Turret?\nCost: " + str(currency_to_tend)
		$"Lane 2/Power Upgrade 2".visible = false
		$"Lane 2/Range Upgrade 2".visible = false
		$"Lane 2/Frequency Upgrade 2".visible = false
		$"Lane 2/Confirm 2".visible = false
	
	if turretType.turret_health[2] == 0.0:
		$"Lane 3/Tend3".visible = true
		$"Lane 3/Tend3".text = "Tend to Turret?\nCost: " + str(currency_to_tend)
		$"Lane 3/Power Upgrade 3".visible = false
		$"Lane 3/Range Upgrade 3".visible = false
		$"Lane 3/Frequency Upgrade 3".visible = false
		$"Lane 3/Confirm 3".visible = false
	
	if turretType.turret_health[3] == 0.0:
		$"Lane 4/Tend4".visible = true
		$"Lane 4/Tend4".text = "Tend to Turret?\nCost: " + str(currency_to_tend)
		$"Lane 4/Power Upgrade 4".visible = false
		$"Lane 4/Range Upgrade 4".visible = false
		$"Lane 4/Frequency Upgrade 4".visible = false
		$"Lane 4/Confirm 4".visible = false
	
	if turretType.turret_health[4] == 0.0:
		$"Lane 5/Tend5".visible = true
		$"Lane 5/Tend5".text = "Tend to Turret?\nCost: " + str(currency_to_tend)
		$"Lane 5/Power Upgrade 5".visible = false
		$"Lane 5/Range Upgrade 5".visible = false
		$"Lane 5/Frequency Upgrade 5".visible = false
		$"Lane 5/Confirm 5".visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$TimerProgress.value = buy_phase_timer.time_left
	if buy_phase_timer.is_stopped():
		scene_switcher.switch_scene("res://scenes/stage1.tscn")


#func _on_stick_pressed() -> void:
	#player.type = 2
#
#func _on_hammer_pressed() -> void:
	#player.type = 3
	#
#func _on_racket_pressed() -> void:
	#player.type = 4
	#
	
# When pressed, switches to power tower if enough currency
func _on_power_upgrade_1_pressed() -> void:
	signals.button_click.emit()
	if globalVars.currency >= currency_to_switch and not turretType.type_array[0] == turretType.Type.POWER:
		globalVars.currency -= currency_to_switch
		turretType.type_array[0] = turretType.Type.POWER

# When pressed, switches to range tower if enough currency
func _on_range_upgrade_1_pressed() -> void:
	signals.button_click.emit()
	if globalVars.currency >= currency_to_switch and not turretType.type_array[0] == turretType.Type.REACH:
		globalVars.currency -= currency_to_switch
		turretType.type_array[0] = turretType.Type.REACH

# When pressed, switches to frequency tower if enough currency
func _on_frequency_upgrade_1_pressed() -> void:
	signals.button_click.emit()
	if globalVars.currency >= currency_to_switch and not turretType.type_array[0] == turretType.Type.FREQUENCY:
		globalVars.currency -= currency_to_switch
		turretType.type_array[0] = turretType.Type.FREQUENCY

# When confirmed, changes to upgrade button, which upgrades level of particular tower type chosen
func _on_confirm_1_pressed() -> void:
	signals.button_click.emit()
	$"Lane 1/Power Upgrade 1".visible = false
	$"Lane 1/Range Upgrade 1".visible = false
	$"Lane 1/Frequency Upgrade 1".visible = false
	if turretType.type_array[0] == turretType.Type.POWER:
		$"Lane 1/Upgrade 1".text = "Upgrade to Level " + str(turretType.power_level[0] + 1) + "\nCost: " + str(currency_to_upgrade)
	elif turretType.type_array[0] == turretType.Type.REACH:
		$"Lane 1/Upgrade 1".text = "Upgrade to Level " + str(turretType.reach_level[0] + 1) + "\nCost: " + str(currency_to_upgrade)
	elif turretType.type_array[0] == turretType.Type.FREQUENCY:
		$"Lane 1/Upgrade 1".text = "Upgrade to Level " + str(turretType.frequency_level[0] + 1) + "\nCost: " + str(currency_to_upgrade)
	elif turretType.type_array[0] == turretType.Type.BASIC:
		$"Lane 1/Upgrade 1".text = "Basic Turret Cannot Upgrade"
	$"Lane 1/Upgrade 1".visible = true

# When upgrade, if enough currency, increases level of current tower type by 1
func _on_upgrade_1_pressed() -> void:
	signals.button_click.emit()
	if globalVars.currency >= currency_to_upgrade:
		globalVars.currency -= currency_to_upgrade
		if turretType.type_array[0] == turretType.Type.POWER:
			turretType.power_level[0] += 1
			$"Lane 1/Upgrade 1".text = "Upgrade to Level " + str(turretType.power_level[0] + 1) + "\nCost: " + str(currency_to_upgrade)
		elif turretType.type_array[0] == turretType.Type.REACH:
			turretType.reach_level[0] += 1
			$"Lane 1/Upgrade 1".text = "Upgrade to Level " + str(turretType.reach_level[0] + 1) + "\nCost: " + str(currency_to_upgrade)
		elif turretType.type_array[0] == turretType.Type.FREQUENCY:
			turretType.frequency_level[0] += 1
			$"Lane 1/Upgrade 1".text = "Upgrade to Level " + str(turretType.frequency_level[0] + 1) + "\nCost: " + str(currency_to_upgrade)

func _on_tend_1_pressed() -> void:
	signals.button_click.emit()
	if globalVars.currency >= currency_to_tend:
		$"Lane 1/Tend1".visible = false
		$"Lane 1/Power Upgrade 1".visible = true
		$"Lane 1/Range Upgrade 1".visible = true
		$"Lane 1/Frequency Upgrade 1".visible = true
		$"Lane 1/Confirm 1".visible = true
		turretType.turret_health[0] = 100.0


func _on_power_upgrade_2_pressed() -> void:
	signals.button_click.emit()
	if globalVars.currency >= currency_to_switch and not turretType.type_array[1] == turretType.Type.POWER:
		globalVars.currency -= currency_to_switch
		turretType.type_array[1] = turretType.Type.POWER

func _on_range_upgrade_2_pressed() -> void:
	signals.button_click.emit()
	if globalVars.currency >= currency_to_switch and not turretType.type_array[1] == turretType.Type.REACH:
		globalVars.currency -= currency_to_switch
		turretType.type_array[1] = turretType.Type.REACH

func _on_frequency_upgrade_2_pressed() -> void:
	signals.button_click.emit()
	if globalVars.currency >= currency_to_switch and not turretType.type_array[1] == turretType.Type.FREQUENCY:
		globalVars.currency -= currency_to_switch
		turretType.type_array[1] = turretType.Type.FREQUENCY

func _on_confirm_2_pressed() -> void:
	signals.button_click.emit()
	$"Lane 2/Power Upgrade 2".visible = false
	$"Lane 2/Range Upgrade 2".visible = false
	$"Lane 2/Frequency Upgrade 2".visible = false
	if turretType.type_array[1] == turretType.Type.POWER:
		$"Lane 2/Upgrade 2".text = "Upgrade to Level " + str(turretType.power_level[1] + 1) + "\nCost: " + str(currency_to_upgrade)
	elif turretType.type_array[1] == turretType.Type.REACH:
		$"Lane 2/Upgrade 2".text = "Upgrade to Level " + str(turretType.reach_level[1] + 1) + "\nCost: " + str(currency_to_upgrade)
	elif turretType.type_array[1] == turretType.Type.FREQUENCY:
		$"Lane 2/Upgrade 2".text = "Upgrade to Level " + str(turretType.frequency_level[1] + 1) + "\nCost: " + str(currency_to_upgrade)
	elif turretType.type_array[1] == turretType.Type.BASIC:
		$"Lane 2/Upgrade 2".text = "Basic Turret Cannot Upgrade"
	$"Lane 2/Upgrade 2".visible = true

func _on_upgrade_2_pressed() -> void:
	signals.button_click.emit()
	if globalVars.currency >= currency_to_upgrade:
		globalVars.currency -= currency_to_upgrade
		if turretType.type_array[1] == turretType.Type.POWER:
			turretType.power_level[1] += 1
			$"Lane 2/Upgrade 2".text = "Upgrade to Level " + str(turretType.power_level[1] + 1) + "\nCost: " + str(currency_to_upgrade)
		elif turretType.type_array[1] == turretType.Type.REACH:
			turretType.reach_level[1] += 1
			$"Lane 2/Upgrade 2".text = "Upgrade to Level " + str(turretType.reach_level[1] + 1) + "\nCost: " + str(currency_to_upgrade)
		elif turretType.type_array[1] == turretType.Type.FREQUENCY:
			turretType.frequency_level[1] += 1
			$"Lane 2/Upgrade 2".text = "Upgrade to Level " + str(turretType.frequency_level[1] + 1) + "\nCost: " + str(currency_to_upgrade)

func _on_tend_2_pressed() -> void:
	signals.button_click.emit()
	if globalVars.currency >= currency_to_tend:
		$"Lane 2/Tend2".visible = false
		$"Lane 2/Power Upgrade 2".visible = true
		$"Lane 2/Range Upgrade 2".visible = true
		$"Lane 2/Frequency Upgrade 2".visible = true
		$"Lane 2/Confirm 2".visible = true
		turretType.turret_health[1] = 100.0


func _on_power_upgrade_3_pressed() -> void:
	signals.button_click.emit()
	if globalVars.currency >= currency_to_switch and not turretType.type_array[2] == turretType.Type.POWER:
		globalVars.currency -= currency_to_switch
		turretType.type_array[2] = turretType.Type.POWER

func _on_range_upgrade_3_pressed() -> void:
	signals.button_click.emit()
	if globalVars.currency >= currency_to_switch and not turretType.type_array[2] == turretType.Type.REACH:
		globalVars.currency -= currency_to_switch
		turretType.type_array[2] = turretType.Type.REACH

func _on_frequency_upgrade_3_pressed() -> void:
	signals.button_click.emit()
	if globalVars.currency >= currency_to_switch and not turretType.type_array[2] == turretType.Type.FREQUENCY:
		globalVars.currency -= currency_to_switch
		turretType.type_array[2] = turretType.Type.FREQUENCY

func _on_confirm_3_pressed() -> void:
	signals.button_click.emit()
	$"Lane 3/Power Upgrade 3".visible = false
	$"Lane 3/Range Upgrade 3".visible = false
	$"Lane 3/Frequency Upgrade 3".visible = false
	if turretType.type_array[2] == turretType.Type.POWER:
		$"Lane 3/Upgrade 3".text = "Upgrade to Level " + str(turretType.power_level[2] + 1) + "\nCost: " + str(currency_to_upgrade)
	elif turretType.type_array[2] == turretType.Type.REACH:
		$"Lane 3/Upgrade 3".text = "Upgrade to Level " + str(turretType.reach_level[2] + 1) + "\nCost: " + str(currency_to_upgrade)
	elif turretType.type_array[2] == turretType.Type.FREQUENCY:
		$"Lane 3/Upgrade 3".text = "Upgrade to Level " + str(turretType.frequency_level[2] + 1) + "\nCost: " + str(currency_to_upgrade)
	elif turretType.type_array[2] == turretType.Type.BASIC:
		$"Lane 3/Upgrade 3".text = "Basic Turret Cannot Upgrade"
	$"Lane 3/Upgrade 3".visible = true

func _on_upgrade_3_pressed() -> void:
	signals.button_click.emit()
	if globalVars.currency >= currency_to_upgrade:
		globalVars.currency -= currency_to_upgrade
		if turretType.type_array[2] == turretType.Type.POWER:
			turretType.power_level[2] += 1
			$"Lane 3/Upgrade 3".text = "Upgrade to Level " + str(turretType.power_level[2] + 1) + "\nCost: " + str(currency_to_upgrade)
		elif turretType.type_array[2] == turretType.Type.REACH:
			turretType.reach_level[2] += 1
			$"Lane 3/Upgrade 3".text = "Upgrade to Level " + str(turretType.reach_level[2] + 1) + "\nCost: " + str(currency_to_upgrade)
		elif turretType.type_array[2] == turretType.Type.FREQUENCY:
			turretType.frequency_level[2] += 1
			$"Lane 3/Upgrade 3".text = "Upgrade to Level " + str(turretType.frequency_level[2] + 1) + "\nCost: " + str(currency_to_upgrade)

func _on_tend_3_pressed() -> void:
	signals.button_click.emit()
	if globalVars.currency >= currency_to_tend:
		$"Lane 3/Tend3".visible = false
		$"Lane 3/Power Upgrade 3".visible = true
		$"Lane 3/Range Upgrade 3".visible = true
		$"Lane 3/Frequency Upgrade 3".visible = true
		$"Lane 3/Confirm 3".visible = true
		turretType.turret_health[2] = 100.0


func _on_power_upgrade_4_pressed() -> void:
	signals.button_click.emit()
	if globalVars.currency >= currency_to_switch and not turretType.type_array[3] == turretType.Type.POWER:
		globalVars.currency -= currency_to_switch
		turretType.type_array[3] = turretType.Type.POWER

func _on_range_upgrade_4_pressed() -> void:
	signals.button_click.emit()
	if globalVars.currency >= currency_to_switch and not turretType.type_array[3] == turretType.Type.REACH:
		globalVars.currency -= currency_to_switch
		turretType.type_array[3] = turretType.Type.REACH

func _on_frequency_upgrade_4_pressed() -> void:
	signals.button_click.emit()
	if globalVars.currency >= currency_to_switch and not turretType.type_array[3] == turretType.Type.FREQUENCY:
		globalVars.currency -= currency_to_switch
		turretType.type_array[3] = turretType.Type.FREQUENCY

func _on_confirm_4_pressed() -> void:
	signals.button_click.emit()
	$"Lane 4/Power Upgrade 4".visible = false
	$"Lane 4/Range Upgrade 4".visible = false
	$"Lane 4/Frequency Upgrade 4".visible = false
	if turretType.type_array[3] == turretType.Type.POWER:
		$"Lane 4/Upgrade 4".text = "Upgrade to Level " + str(turretType.power_level[3] + 1) + "\nCost: " + str(currency_to_upgrade)
	elif turretType.type_array[3] == turretType.Type.REACH:
		$"Lane 4/Upgrade 4".text = "Upgrade to Level " + str(turretType.reach_level[3] + 1) + "\nCost: " + str(currency_to_upgrade)
	elif turretType.type_array[3] == turretType.Type.FREQUENCY:
		$"Lane 4/Upgrade 4".text = "Upgrade to Level " + str(turretType.frequency_level[3] + 1) + "\nCost: " + str(currency_to_upgrade)
	elif turretType.type_array[3] == turretType.Type.BASIC:
		$"Lane 4/Upgrade 4".text = "Basic Turret Cannot Upgrade"
	$"Lane 4/Upgrade 4".visible = true

func _on_upgrade_4_pressed() -> void:
	signals.button_click.emit()
	if globalVars.currency >= currency_to_upgrade:
		globalVars.currency -= currency_to_upgrade
		if turretType.type_array[3] == turretType.Type.POWER:
			turretType.power_level[3] += 1
			$"Lane 4/Upgrade 4".text = "Upgrade to Level " + str(turretType.power_level[3] + 1) + "\nCost: " + str(currency_to_upgrade)
		elif turretType.type_array[3] == turretType.Type.REACH:
			turretType.reach_level[3] += 1
			$"Lane 4/Upgrade 4".text = "Upgrade to Level " + str(turretType.reach_level[3] + 1) + "\nCost: " + str(currency_to_upgrade)
		elif turretType.type_array[3] == turretType.Type.FREQUENCY:
			turretType.frequency_level[3] += 1
			$"Lane 4/Upgrade 4".text = "Upgrade to Level " + str(turretType.frequency_level[3] + 1) + "\nCost: " + str(currency_to_upgrade)

func _on_tend_4_pressed() -> void:
	signals.button_click.emit()
	if globalVars.currency >= currency_to_tend:
		$"Lane 4/Tend4".visible = false
		$"Lane 4/Power Upgrade 4".visible = true
		$"Lane 4/Range Upgrade 4".visible = true
		$"Lane 4/Frequency Upgrade 4".visible = true
		$"Lane 4/Confirm 4".visible = true
		turretType.turret_health[3] = 100.0


func _on_power_upgrade_5_pressed() -> void:
	signals.button_click.emit()
	if globalVars.currency >= currency_to_switch and not turretType.type_array[4] == turretType.Type.POWER:
		globalVars.currency -= currency_to_switch
		turretType.type_array[4] = turretType.Type.POWER

func _on_range_upgrade_5_pressed() -> void:
	signals.button_click.emit()
	if globalVars.currency >= currency_to_switch and not turretType.type_array[4] == turretType.Type.REACH:
		globalVars.currency -= currency_to_switch
		turretType.type_array[4] = turretType.Type.REACH

func _on_frequency_upgrade_5_pressed() -> void:
	signals.button_click.emit()
	if globalVars.currency >= currency_to_switch and not turretType.type_array[4] == turretType.Type.FREQUENCY:
		globalVars.currency -= currency_to_switch
		turretType.type_array[4] = turretType.Type.FREQUENCY

func _on_confirm_5_pressed() -> void:
	signals.button_click.emit()
	$"Lane 5/Power Upgrade 5".visible = false
	$"Lane 5/Range Upgrade 5".visible = false
	$"Lane 5/Frequency Upgrade 5".visible = false
	if turretType.type_array[4] == turretType.Type.POWER:
		$"Lane 5/Upgrade 5".text = "Upgrade to Level " + str(turretType.power_level[4] + 1) + "\nCost: " + str(currency_to_upgrade)
	elif turretType.type_array[4] == turretType.Type.REACH:
		$"Lane 5/Upgrade 5".text = "Upgrade to Level " + str(turretType.reach_level[4] + 1) + "\nCost: " + str(currency_to_upgrade)
	elif turretType.type_array[4] == turretType.Type.FREQUENCY:
		$"Lane 5/Upgrade 5".text = "Upgrade to Level " + str(turretType.frequency_level[4] + 1) + "\nCost: " + str(currency_to_upgrade)
	elif turretType.type_array[4] == turretType.Type.BASIC:
		$"Lane 5/Upgrade 5".text = "Basic Turret Cannot Upgrade"
	$"Lane 5/Upgrade 5".visible = true

func _on_upgrade_5_pressed() -> void:
	signals.button_click.emit()
	if globalVars.currency >= currency_to_upgrade:
		globalVars.currency -= currency_to_upgrade
		if turretType.type_array[4] == turretType.Type.POWER:
			turretType.power_level[4] += 1
			$"Lane 5/Upgrade 5".text = "Upgrade to Level " + str(turretType.power_level[4] + 1) + "\nCost: " + str(currency_to_upgrade)
		elif turretType.type_array[4] == turretType.Type.REACH:
			turretType.reach_level[4] += 1
			$"Lane 5/Upgrade 5".text = "Upgrade to Level " + str(turretType.reach_level[4] + 1) + "\nCost: " + str(currency_to_upgrade)
		elif turretType.type_array[4] == turretType.Type.FREQUENCY:
			turretType.frequency_level[4] += 1
			$"Lane 5/Upgrade 5".text = "Upgrade to Level " + str(turretType.frequency_level[4] + 1) + "\nCost: " + str(currency_to_upgrade)

func _on_tend_5_pressed() -> void:
	signals.button_click.emit()
	if globalVars.currency >= currency_to_tend:
		$"Lane 5/Tend5".visible = false
		$"Lane 5/Power Upgrade 5".visible = true
		$"Lane 5/Range Upgrade 5".visible = true
		$"Lane 5/Frequency Upgrade 5".visible = true
		$"Lane 5/Confirm 5".visible = true
		turretType.turret_health[4] = 100.0
