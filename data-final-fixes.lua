-- Wir holen uns die Library der anderen Mod, um deren schlaue Funktion zu nutzen
local data_util = require("__sei-library__.data_util")

-- 1. Deine Liste mit den BZ-Rezepten
local my_extra_recipes = {
    "gyro",
    "silicon-wafer",
    "solar-cell"
}
-- 2. Die Funktion der Original-Mod aufrufen
-- Das fügt "electromagnetics" hinzu, lässt aber "advanced-crafting" etc. beim Rezept aktiv!
data_util.add_additional_category_to_recipes("electromagnetics", my_extra_recipes)

-- 3. DEIN LUBRICANT-FIX (Silikon entfernen)
local function remove_silicone(recipe)
    if not recipe or not recipe.ingredients then return end
    local ingredients = recipe.ingredients
    for i = #ingredients, 1, -1 do
        local ing = ingredients[i]
        if ing.name == "silicone" or ing[1] == "silicone" then
            table.remove(ingredients, i)
        end
    end
end

if data.raw.recipe["lubricant"] then
    local r = data.raw.recipe["lubricant"]
    remove_silicone(r)
    if r.normal then remove_silicone(r.normal) end
    if r.expensive then remove_silicone(r.expensive) end
end