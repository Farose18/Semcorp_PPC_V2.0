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

---------------------- UAC Smoothing start ------------------------------------

local Uac12 = WR.read(dev, "UAC12")
if is_nan(Uac12) then Uac12 = 0 end
local Uac23 = WR.read(dev, "UAC23")
if is_nan(Uac23) then Uac23 = 0 end
local Uac31 = WR.read(dev, "UAC31")
if is_nan(Uac31) then Uac31 = 0 end

local uac = ((Uac12+Uac23+Uac31)/3)
if is_nan(uac) then uac = 0 end

local uacAct = WR.read(dev, "UAC")
if is_nan(uacAct) then uacAct = 0 end


if(uac >= 40) then
    local uac = uacAct
    WR.setProp(dev, "UAC", uacAct)
elseif(uac < 40) then
    WR.setProp(dev, "UAC", uac)
end

local qac = WR.read(dev, "QAC")
WR.setProp(dev, "QAC_ACT", (qac * (-1)))

local pf = WR.read(dev, "PF")
WR.setProp(dev, "PF_ACT", (pf * (-1)))

---------------------- UAC Smoothing End -----------------------------------------

