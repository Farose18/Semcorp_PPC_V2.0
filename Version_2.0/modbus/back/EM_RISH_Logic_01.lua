local dev, good = ...
--print(dev)

devS = string.sub(dev, 4, -1)
--print("devS = ", devS)

---------------------- COMMUNICATION STATUS Start -----------------------------

if WR.isOnline(dev) then
 WR.setProp(dev, "COMMUNICATION_STATUS", 0)
else
 WR.setProp(dev, "COMMUNICATION_STATUS", 1)
end

---------------------- COMMUNICATION STATUS End -------------------------------

local Uac12 = WR.read(dev, "UAC12")
if is_nan(Uac12) then Uac12 = 0 end
local Uac23 = WR.read(dev, "UAC23")
if is_nan(Uac23) then Uac23 = 0 end
local Uac31 = WR.read(dev, "UAC31")
if is_nan(Uac31) then Uac31 = 0 end
WR.setProp(dev, "UAC", (Uac12+Uac23+Uac31)/3)

