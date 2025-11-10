# GodsAPI, a library to create Gods.
This is a very early library made to make it easy for developers to add new Gods/NPC Gods & Keepsakes.
This library does nothing to the game on its own, without outside function calls.
You should only install it if another mod requires it, or if you will be using this library to create Gods/Keepsakes.

>[!IMPORTANT]
> *Currently, this library only supports adding in **Olympian** Gods eg. Zeus and **NPC**-type Gods eg. Hermes - as well as custom Keepsakes.* <br>
> NPC Type means that they will not fill up the `MetGods` table during a run - meaning you can have `Zeus, Aphrodite, Hera, Hestia` and meet `Hermes` and `Your God`.

- I would like to add Spells and proper NPC's such as Dionysus/Athena/Arachne during runs, and Hub NPCS such as Hecate/Hypnos.<br> However, there are a lot of functions that are hard-coded to `SpellDrop`, and I am unsure about the state of adding 3D models.

<br>

> [!NOTE]
> If there are any requests, anything I missed, or anything working incorrectly, [post an issue](https://github.com/excellent-ae/zannc-GodsAPI/issues/new), or create a help thread in the [Hades Modding Discord](https://discord.gg/AHk3D48WYD).

# Developer Documentation

1. Create a dependency in `manifest.json` (if testing locally) by adding `"zannc-GodsAPI-1.0.0"` and in `thunderstore.toml` by adding `zannc-GodsAPI = "1.0.0"` if publishing the mod by adding to respective files.

2. In `main.lua`, add:
    ```lua
    --@module 'zannc-GodsAPI'
    gods = mods['zannc-GodsAPI']
    ```
    So that it looks like this as an example:
    ```lua
    _PLUGIN = PLUGIN
    game = rom.game

    --@module 'SGG_Modding-ModUtil'
    modutil = mods["SGG_Modding-ModUtil"]
    --@module 'SGG_Modding-ReLoad'
    reload = mods["SGG_Modding-ReLoad"]
    --@module 'SGG_Modding-SJSON'
    sjson = mods["SGG_Modding-SJSON"]
    --@module 'zannc-GodsAPI'
    gods = mods["zannc-GodsAPI"]
    ```

#### For more in-depth examples of how to use these functions, refer to the [DEV.md](https://github.com/excellent-ae/zannc-GodsAPI/blob/main/DEV.md) file.

3. To create a god, you must call `gods.InitializeGod(params)`, and optionally followed by `gods.CreateOlympianSJSONData(sjsonData)` and provide the required paramaters / sjson paramaters.<br><br>
4. To create a Keepsake, you must call `gods.CreateKeepsake(params)`, and pass in the required fields - as well as any custom functions you need to make the keepsake function. <br>



## Planned Features
I am planning to add support for trait creation, and will be released in later versions. <br>
I am also looking into the possibility of Hex Gods like Selene, as well as physical 3D NPCs if possible - however to my knowledge, 3D models have not been created yet.