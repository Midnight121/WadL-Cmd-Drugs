----- [ Script made by: WadL ]
----- https://forum.cfx.re/t/release-wadls-command-drugs-standalone
----- https://github.com/Midnight121/WadL-Cmd-Drugs

--Usage 
--/weed <amount> (Smokes Weed)
--/coke <amount> (Snortes Coke)
--/lean <amount> (Drinks Double-Cup of Lean)
--/meth <amount> (Injects Syringe of meth)
--/N2O <amount> (Inhales N2O Cannisters)
--/killdrugs (Removes all effects of drugs If enabled)

--The amount of drugs you take will effect the duration
--Config

--Enable overdose
local OD = true

--Enable killdrugs command?
local kd = true

--Duration of weed effect 
local WadLWeedDura = 60*1000

--Duration of coke effect 
local WadLCokeDura = 40*1000

--Duration of lean effect 
local WadLLeanDura = 120*1000

--Duration of meth effect 
local WadLMethDura = 80*1000

--Duration of N2O effect 
local WadLN2ODura = 5*1000

--START OF CODE
high = false 
DisabledRun = false

Citizen.CreateThread(function()
		Citizen.Wait(0)
		if DisabledRun == true then
			DisableControlAction(0,21,true)
		end
end)


RegisterCommand("weed", function(source, args, rawCommand)
	if #args < 1 then
	    -- Too low args
	    TriggerEvent('chat:addMessage', {
			color = { 255, 0, 0},
			multiline = true,
			args = {"WadL Drugs", "^2Correct usage of command is ^*/weed <amount>"}
		})
	    return;
	end
	if high == false then
		local amount = tonumber(args[1])
		TriggerEvent('chat:addMessage', {
			color = { 255, 0, 0},
			multiline = true,
			args = {"WadL Drugs", "^2You have smoked ".. amount.." gram(s) of weed"}
		})
		ShakeGameplayCam('DRUNK_SHAKE', 0.35)
		SetPedMotionBlur(GetPlayerPed(-1), true)
		runAnim("move_m@muscle@a")
		local FadeTime = (WadLWeedDura/10)
		high = true
		SetTimecycleModifier('BloomMid')
		Citizen.Wait(WadLWeedDura*amount)
		high = false
		StopGameplayCamShaking(true)
		resetAnims()
		SetPedMotionBlur(GetPlayerPed(-1), false)
		SetTransitionTimecycleModifier('default', 0.35)
	else 
	TriggerEvent('chat:addMessage', {
		color = { 255, 0, 0},
		multiline = true,
		args = {"WadL Drugs", "^2^*You are already high"}
	})
	end
end)

AddEventHandler('baseevents:onPlayerDied', function()
	if high == true then
	StopGameplayCamShaking(true)
		resetAnims()
		DisabledRun = false
		high = false
		SetTransitionTimecycleModifier('default', 0.35)
		--SetPedMoveRateOverride(source, 0)
		SetRunSprintMultiplierForPlayer(source, 1.01)
		SetEntityMaxHealth(GetPlayerPed(-1), 200)
	TriggerEvent('chat:addMessage', {
		color = { 255, 0, 0},
		multiline = true,
		args = {"WadL Drugs", "^2^*You have died under the influence"}
	})
end
end)

RegisterCommand("coke", function(source, args, rawCommand)
	if #args < 1 then
	    -- Too low args
	    TriggerEvent('chat:addMessage', {
			color = { 255, 0, 0},
			multiline = true,
			args = {"WadL Drugs", "^2Correct usage of command is ^*/coke <amount>"}
		})
	    return;
	end
	if high == false then
		local amount = tonumber(args[1])
		TriggerEvent('chat:addMessage', {
			color = { 255, 0, 0},
			multiline = true,
			args = {"WadL Drugs", "^2You have snorted ".. amount.." gram(s) of coke"}
		})
		-- DRUG EFFECTS START HERE
		ShakeGameplayCam('SKY_DIVING_SHAKE', 0.95)
		SetPedMotionBlur(GetPlayerPed(-1), true)
		--runAnim("move_m@drunk@moderatedrunk")
		local FadeTime = (WadLCokeDura/10)
		--SetPedMoveRateOverride(source, 5.0)
		SetRunSprintMultiplierForPlayer(source, 1.49)
		high = true
		SetTimecycleModifier('Bloom')
		--Coming Down
		DisabledRun = true
		Citizen.Wait(WadLCokeDura*amount)
		SetRunSprintMultiplierForPlayer(source, 1.01)
		--SetPedMoveRateOverride(source, 0)
		runAnim("move_m@drunk@moderatedrunk")
		Citizen.Wait(15000)
		local r = math.random(1,30)
		if r == 1 then
			SetEntityHealth(PlayerPedId(), 0)
			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = true,
				args = {"WadL Drugs", "^2^*Your body did not react well with the cocaine and you died"}
			})	
		end
		--ENDING THE HIGH
		DisabledRun = false
		high = false
		StopGameplayCamShaking(true)
		resetAnims()
		SetPedMotionBlur(GetPlayerPed(-1), false)
		SetTransitionTimecycleModifier('default', 0.35)
		-- OVERDOSE
		if amount == 2 or amount > 2 and OD == true then
			SetEntityHealth(PlayerPedId(), 0)
			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = true,
				args = {"WadL Drugs", "^2^*You have died to an overdose"}
			})
		end
	else 
	TriggerEvent('chat:addMessage', {
		color = { 255, 0, 0},
		multiline = true,
		args = {"WadL Drugs", "^2^*You are already high"}
	})
	end
end)

RegisterCommand("lean", function(source, args, rawCommand)
	if #args < 1 then
	    -- Too low args
	    TriggerEvent('chat:addMessage', {
			color = { 255, 0, 0},
			multiline = true,
			args = {"WadL Drugs", "^2Correct usage of command is ^*/lean <amount>"}
		})
	    return;
	end
	if high == false then
		local amount = tonumber(args[1])
		TriggerEvent('chat:addMessage', {
			color = { 255, 0, 0},
			multiline = true,
			args = {"WadL Drugs", "^2You have drank ".. amount.." doublecup(s) (500ml each) of lean"}
		})
		-- DRUG EFFECTS START HERE
		ShakeGameplayCam('DRUNK_SHAKE', 4.95)
		SetPedMotionBlur(GetPlayerPed(-1), true)
		runAnim("MOVE_M@DRUNK@SLIGHTLYDRUNK")
		high = true
		SetTimecycleModifier('BlackOut')
		--Coming Down
		DisabledRun = true
		Citizen.Wait(WadLLeanDura*amount)
		if amount == 0.5 or amount > 0.5 then
			SetPedToRagdoll(GetPlayerPed(-1), 7500, 7500, 0, 0, 0, 0)
			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = true,
				args = {"WadL Drugs", "^2You were very tired from the lean and fell asleep"}
			})
			Citizen.Wait(7500)
		end
		--ENDING THE HIGH
		DisabledRun = false
		high = false
		StopGameplayCamShaking(true)
		resetAnims()
		SetPedMotionBlur(GetPlayerPed(-1), false)
		SetTransitionTimecycleModifier('default', 0.35)
		-- OVERDOSE
		if amount == 4 or amount > 4 and OD == true then
			SetEntityHealth(PlayerPedId(), 0)
			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = true,
				args = {"WadL Drugs", "^2^*You have died to an overdose"}
			})
		end
	else 
	TriggerEvent('chat:addMessage', {
		color = { 255, 0, 0},
		multiline = true,
		args = {"WadL Drugs", "^2^*You are already high"}
	})
	end
end)

RegisterCommand("meth", function(source, args, rawCommand)
	if #args < 1 then
	    -- Too low args
	    TriggerEvent('chat:addMessage', {
			color = { 255, 0, 0},
			multiline = true,
			args = {"WadL Drugs", "^2Correct usage of command is ^*/meth <amount>"}
		})
	    return;
	end
	if high == false then
		local amount = tonumber(args[1])
		TriggerEvent('chat:addMessage', {
			color = { 255, 0, 0},
			multiline = true,
			args = {"WadL Drugs", "^2You have injected ".. amount.." syringe(s) of meth"}
		})
		-- DRUG EFFECTS START HERE
		ShakeGameplayCam('DRUNK_SHAKE', 0.65)
		SetPedMotionBlur(GetPlayerPed(-1), true)
		runAnim("MOVE_M@DRUNK@MODERATEDRUNK_HEAD_UP")
		--FOR TESTING
		Citizen.Wait(3)
		--END
		SetEntityHealth(GetPlayerPed(-1), 200)
		high = true
		SetTimecycleModifier('BeastIntro01')
		--Coming Down
		Citizen.Wait(WadLMethDura*amount)
		SetEntityHealth(GetPlayerPed(-1), 110)
		local r = math.random(1,20)
		if r == 1 then
			SetEntityHealth(PlayerPedId(), 0)
			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = true,
				args = {"WadL Drugs", "^2^*Your body did not react well with the meth and you died"}
			})	
		end
		--ENDING THE HIGH
		high = false
		StopGameplayCamShaking(true)
		resetAnims()
		SetPedMotionBlur(GetPlayerPed(-1), false)
		SetTransitionTimecycleModifier('default', 0.35)
		-- OVERDOSE
		if amount == 3 or amount > 3 and OD == true then
			SetEntityHealth(PlayerPedId(), 0)
			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = true,
				args = {"WadL Drugs", "^2^*You have died to an overdose"}
			})
		end
	else 
	TriggerEvent('chat:addMessage', {
		color = { 255, 0, 0},
		multiline = true,
		args = {"WadL Drugs", "^2^*You are already high"}
	})
	end
end)

RegisterCommand("N2O", function(source, args, rawCommand)
	if #args < 1 then
	    -- Too low args
	    TriggerEvent('chat:addMessage', {
			color = { 255, 0, 0},
			multiline = true,
			args = {"WadL Drugs", "^2Correct usage of command is ^*/N2O <amount>"}
		})
	    return;
	end
	if high == false then
		local amount = tonumber(args[1])
		TriggerEvent('chat:addMessage', {
			color = { 255, 0, 0},
			multiline = true,
			args = {"WadL Drugs", "^2You have sucked in ".. amount.." canister(s) of N2O"}
		})
		-- DRUG EFFECTS START HERE
		ShakeGameplayCam('DRUNK_SHAKE', 90.95)
		SetPedMotionBlur(GetPlayerPed(-1), true)
		runAnim("MOVE_M@DRUNK@SLIGHTLYDRUNK")
		high = true
		SetTimecycleModifier('BarryFadeOut')
		--Coming Down
		DisabledRun = true
		Citizen.Wait(WadLN2ODura*amount)
		if amount == 1 or amount > 1 then
			SetPedToRagdoll(GetPlayerPed(-1), 7500, 7500, 0, 0, 0, 0)
			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = true,
				args = {"WadL Drugs", "^2You passed out from the N2O"}
			})
			Citizen.Wait(7500)
		end
		local r = math.random(1,50)
		if r == 1 then
			SetEntityHealth(PlayerPedId(), 0)
			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = true,
				args = {"WadL Drugs", "^2^*Your body did not react well with the N2O and you died"}
			})	
		end
		--ENDING THE HIGH
		DisabledRun = false
		high = false
		StopGameplayCamShaking(true)
		resetAnims()
		SetPedMotionBlur(GetPlayerPed(-1), false)
		SetTransitionTimecycleModifier('default', 0.35)
		-- OVERDOSE
		if amount == 5 or amount > 5 and OD == true then
			SetEntityHealth(PlayerPedId(), 0)
			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = true,
				args = {"WadL Drugs", "^2^*You have died to an overdose"}
			})
		end
	else 
	TriggerEvent('chat:addMessage', {
		color = { 255, 0, 0},
		multiline = true,
		args = {"WadL Drugs", "^2^*You are already high"}
	})
	end
end)

RegisterCommand("killdrugs", function(source, args, rawCommand)
	if kd == true then
		high = false
		StopGameplayCamShaking(true)
		resetAnims()
		SetTransitionTimecycleModifier('default', 0.35)
		--SetPedMoveRateOverride(source, 0)
		SetRunSprintMultiplierForPlayer(source, 1.01)
		SetEntityMaxHealth(GetPlayerPed(-1), 200)
		TriggerEvent('chat:addMessage', {
			color = { 255, 0, 0},
			multiline = true,
			args = {"WadL Drugs", "^2Drugs have been removed from your bodie"}
		})
	else
	TriggerEvent('chat:addMessage', {
		color = { 255, 0, 0},
		multiline = true,
		args = {"WadL Drugs", "^2^*Kill drugs has been disabled on this server"}
	})
	end
end)

function runAnim(anim)
	RequestAnimSet(anim)
	SetPedMovementClipset(GetPlayerPed(-1), anim, true)
end

function resetAnims()
	ResetPedMovementClipset(GetPlayerPed(-1))
	ResetPedWeaponMovementClipset(GetPlayerPed(-1))
	ResetPedStrafeClipset(GetPlayerPed(-1))
end
