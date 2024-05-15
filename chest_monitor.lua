function print_inventory_on_monitor(chest, monitor)
    monitor.clear()
    local inventory = chest.list()

    -- Haal de grootte van de monitor op
    local monitorBreedte, monitorHoogte = monitor.getSize()

    -- Bereken de startpositie Y om de lijst te centreren
    local aantalItems = #inventory
    local startY = math.floor((monitorHoogte - aantalItems * 2) / 2) + 1

    local y = startY

    for slot, item in pairs(inventory) do
        local itemName = string.gsub(item.name, "minecraft:", "")
        local itemText = slot .. ": " .. itemName
        local countText = "x" .. item.count

        -- Centreer de naam van het item op de monitor
        local itemX = math.floor((monitorBreedte - string.len(itemText)) / 2)
        monitor.setCursorPos(itemX, y)
        monitor.write(itemText)

        -- Centreer het aantal van het item op de regel onder de naam van het item
        local countX = math.floor((monitorBreedte - string.len(countText)) / 2)
        y = y + 1
        monitor.setCursorPos(countX, y)
        monitor.setTextColor(colors.gray)
        monitor.write(countText)
        monitor.setTextColor(colors.white)

        y = y + 1
    end
end

-- Vind het monitor randapparaat
local monitor = peripheral.find("monitor")

-- Vind het kist randapparaat
local chest = peripheral.find("minecraft:chest")

-- Controleer of er een monitor is gevonden
if monitor == nil then
    print("Geen monitor gevonden.")
    return
end

-- Controleer of er een kist is gevonden
if chest == nil then
    print("Geen kist gevonden.")
    return
end

-- Blijf de inventaris continu bijwerken op het monitor
while true do
    print_inventory_on_monitor(chest, monitor)
    sleep(10)
end
