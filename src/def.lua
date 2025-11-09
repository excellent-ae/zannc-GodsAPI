--- @class GodsAPI
local GodsAPI = {}

--- Initializes the GodsAPI library with your plugin GUID >> Must be called before any other functions. [DEFUNCT]
function GodsAPI.Initialize() end

--- @class params
--- @field godName string (required) - The name of the God | eg "Ares", "Zeus" etc
--- @field godType string (required) - The type of God | eg "god" or "npcgod" (God = Zeus, NPC = Hermes)

--- @param params params
function GodsAPI.InitializeGod(params) end

--- @param godName string (required) - The name of the NPC | eg "Dionysus", "Athena" etc
--- @class params (optional) - A set of options to create colour, text, gender, spawn sound etc.
function GodsAPI.InitializeNPC(godName, params) end

--- Adds a set of SJSON needed to create a Droppable God.
--- @class sjsonData
--- @field godName string (required) - The name of the God | e.g "Artemis", "Apollo" etc
--- @field godType string (required) - The type of God | eg "god" or "npcgod" (God = Zeus, NPC = Hermes)
--- @field skipBoonSelectSymbol boolean (optional) - If the select symbol already exists in the game (Artemis, Hermes, Athena etc.)

--- @param sjsonData sjsonData
function GodsAPI.CreateOlympianSJSONData(sjsonData) end

--- Checks if a God is registered.
--- @param godName string (required) - The name of the God to check
--- @param debug boolean (optional) - Enable Debug Prints
--- @return boolean - True if the God is registered
function GodsAPI.IsGodRegistered(godName, debug) end

return GodsAPI
