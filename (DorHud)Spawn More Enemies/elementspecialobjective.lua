core:import("CoreMissionScriptElement")
ElementSpecialObjective = ElementSpecialObjective or class(CoreMissionScriptElement.MissionScriptElement)

function ElementSpecialObjective:nav_link_delay()
	return 0.1
end