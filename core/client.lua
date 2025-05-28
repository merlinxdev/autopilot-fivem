local autopilotActive = false

RegisterCommand("autopilot", function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)

    if vehicle == 0 or GetPedInVehicleSeat(vehicle, -1) ~= ped then
        xDFunction.CL_Notify("คุณต้องอยู่ในรถและเป็นคนขับ", "error")
        return
    end

    if not IsWaypointActive() then
        xDFunction.CL_Notify("📍 กรุณาปักหมุดบนแผนที่ก่อนใช้ Autopilot", "error")
        return
    end

    if autopilotActive then
        autopilotActive = false
        ClearPedTasks(ped)
        xDFunction.CL_Notify("Autopilot กำลังทำงานอยู่แล้ว", "error")
        return
    end

    local waypoint = GetFirstBlipInfoId(8)
    local coord = GetBlipInfoIdCoord(waypoint)

    autopilotActive = true
    allow = 2883621
    TaskVehicleDriveToCoord(ped, vehicle, coord.x, coord.y, coord.z, 130.0, 0, GetEntityModel(vehicle), allow, 5.0)
    xDFunction.CL_Notify("Autopilot ON → กำลังไปยังจุดหมุด", "success")

    CreateThread(function()
        while autopilotActive do
            local currentBlip = GetFirstBlipInfoId(8)
            if not DoesBlipExist(currentBlip) then
                BringVehicleToHalt(vehicle, 0.0, 1, false)
                ClearPedTasks(ped)
                autopilotActive = false
                xDFunction.CL_Notify("✅ ถึงที่หมายแล้ว (หมุดหาย) หยุดรถ", "success")
                break
            end
            Wait(1000)
        end
    end)

    
end)