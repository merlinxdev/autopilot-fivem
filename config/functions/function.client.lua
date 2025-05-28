xDFunction = {}
xDFunction.CL_Notify = function(msg,types)
    pcall(function()
        exports.nc_notify:PushNotification({
            title = "xD.AutoPilot",
            description = msg,
            type = types,
            duration = 3000
        })
    end)
end