local dev, good = ...
--print(dev)

devS = string.sub(dev, 4, -1)
--print("devS = ", devS)

require ("socket")
local now = socket.gettime()
local date = os.date("*t")
local hour = date.hour
local min = date.min
local sec = date.sec

------------------------ Read Setpoints Start ---------------------------------

------------------------- Read Function Start ---------------------------------

function CHECKDATATIME(dev, now, field)
 local midNight = (now - ((hour * 60 * 60) + (min * 60) + sec))
 local dataTime = WR.ts(dev, field)
 if (dataTime < midNight) then
  WR.setProp(dev, field, 0)
 else
  local data = WR.read(dev, field)
  WR.setProp(dev, field, data)
 end
end

function EAI_CALCULATE(dev, ...)
 local result = 0
 local value = 0
 for i,v in ipairs(arg) do
  value = WR.read(dev, v)
  if is_nan(value) then value = 0 end
  result = result + value
 end
 return result
end

function SUM02(meter1, meter2, targetmeter, val, sumval)
 local value1 = WR.read(meter1, val)
 if is_nan(value1) then value1 = 0 end
 local value2 = WR.read(meter2, val)
 if is_nan(value2) then value2 = 0 end

 WR.setProp(targetmeter, sumval, value1+value2)
end


function AVG02(meter1, meter2, targetmeter, val, avgval)
 local cnt = 2
 local value1 = WR.read(meter1, val)
 if is_nan(value1) then value1 = 0; cnt = cnt - 1 end
 local value2 = WR.read(meter2, val)
 if is_nan(value2) then value2 = 0; cnt = cnt - 1 end

 if cnt > 0 then
  WR.setProp(targetmeter, avgval, (value1+value2)/cnt)
 end
end



function COM02(meter1, meter2, targetmeter, val, resval)
 local value1 = WR.read(meter1, val)
 if is_nan(value1) then value1 = 1 end
 local value2 = WR.read(meter2, val)
 if is_nan(value2) then value2 = 1 end
 local value = value1 + value2
 if value > 0 then value = 1 end
 WR.setProp(targetmeter, resval, value)
end
------------------------- Read Function End -----------------------------------

if not(settings) then
 --print ("Inside file loading")
 settingsConfig = assert(io.open("/mnt/jffs2/solar/modbus/Settings.txt", "r"))
 settingsJson = settingsConfig:read("*all")
 settings = cjson.decode(settingsJson)
 settingsConfig:close()
end

if not(settings.EM[devS].dcCapacity and settings.EM[devS].prAlarmSetpoint and settings.EM[devS].prAlarmRadSetpoint and settings.EM[devS].prAlarmTimeSetpoint and settings.EM[devS].prRealRadSetpoint and settings.EM[devS].prMinRadSetpoint and settings.EM[devS].gridVoltSetpoint) then
 --print ("Data loading")
 settings.EM[devS].dcCapacity = settings.EM[devS].dcCapacity or settings.EM.dcCapacity or 53510
 settings.EM[devS].prAlarmSetpoint = settings.EM[devS].prAlarmSetpoint or settings.EM.prAlarmSetpoint or 75
 settings.EM[devS].prAlarmRadSetpoint = settings.EM[devS].prAlarmRadSetpoint or settings.EM.prAlarmRadSetpoint or 500
 settings.EM[devS].prAlarmTimeSetpoint = settings.EM[devS].prAlarmTimeSetpoint or settings.EM.prAlarmTimeSetpoint or 300
 settings.EM[devS].prRealRadSetpoint = settings.EM[devS].prRealRadSetpoint or settings.EM.prRealRadSetpoint or 100
 settings.EM[devS].prMinRadSetpoint = settings.EM[devS].prMinRadSetpoint or settings.EM.prMinRadSetpoint or 500
 settings.EM[devS].gridVoltSetpoint = settings.EM[devS].gridVoltSetpoint or settings.EM.gridVoltSetpoint or 50

 CHECKDATATIME(dev, now, "EAEN_DAY")
 CHECKDATATIME(dev, now, "PC_START_TIME")
 CHECKDATATIME(dev, now, "PC_STOP_TIME")
 CHECKDATATIME(dev, now, "OPERATIONAL_TIME")
 CHECKDATATIME(dev, now, "GRID_ON")
 CHECKDATATIME(dev, now, "GRID_OFF")
 CHECKDATATIME(dev, now, "PR_MIN")
 CHECKDATATIME(dev, now, "PR_DAY")
 CHECKDATATIME(dev, now, "PR_DAY_GL")
 CHECKDATATIME(dev, now, "PAC_MAX_TIME")
 CHECKDATATIME(dev, now, "COMMUNICATION_DAY_ONLINE")
 CHECKDATATIME(dev, now, "COMMUNICATION_DAY_OFFLINE")
end

--print ("dcCapacity = ", settings.EM[devS].dcCapacity)
--print ("prAlarmSetpoint = ", settings.EM[devS].prAlarmSetpoint)
--print ("prAlarmRadSetpoint = ", settings.EM[devS].prAlarmRadSetpoint)
--print ("prAlarmTimeSetpoint = ", settings.EM[devS].prAlarmTimeSetpoint)
--print ("prRealRadSetpoint = ", settings.EM[devS].prRealRadSetpoint)
--print ("prMinRadSetpoint = ", settings.EM[devS].prMinRadSetpoint)
--print ("gridVoltSetpoint = ", settings.EM[devS].gridVoltSetpoint)

------------------------ Read Setpoints End -----------------------------------



--[[if devS=="EM01" then
 local deviceIn1 = "SN:EM02"
 local deviceIn2 = "SN:EM03"
 local deviceOut = "SN:EM01"
 AVG02(deviceIn1, deviceIn2, deviceOut, "UAC",         "UAC")
 AVG02(deviceIn1, deviceIn2, deviceOut, "UAC12",       "UAC12")
 AVG02(deviceIn1, deviceIn2, deviceOut, "UAC23",       "UAC23")
 AVG02(deviceIn1, deviceIn2, deviceOut, "UAC31",       "UAC31")
 AVG02(deviceIn1, deviceIn2, deviceOut, "UAC1",        "UAC1")
 AVG02(deviceIn1, deviceIn2, deviceOut, "UAC2",        "UAC2")
 AVG02(deviceIn1, deviceIn2, deviceOut, "UAC3",        "UAC3")
 SUM02(deviceIn1, deviceIn2, deviceOut, "IAC1",        "IAC1")
 SUM02(deviceIn1, deviceIn2, deviceOut, "IAC2",        "IAC2")
 SUM02(deviceIn1, deviceIn2, deviceOut, "IAC3",        "IAC3")
 AVG02(deviceIn1, deviceIn2, deviceOut, "FAC",         "FAC")
 AVG02(deviceIn1, deviceIn2, deviceOut, "PF",          "PF")
 SUM02(deviceIn1, deviceIn2, deviceOut, "PAC",         "PAC")
 SUM02(deviceIn1, deviceIn2, deviceOut, "PAC_AVG_05",  "PAC_AVG_05")
 SUM02(deviceIn1, deviceIn2, deviceOut, "PAC_AVG_15",  "PAC_AVG_15")
 SUM02(deviceIn1, deviceIn2, deviceOut, "PAC_MAX",     "PAC_MAX")
 SUM02(deviceIn1, deviceIn2, deviceOut, "QAC",         "QAC")
 SUM02(deviceIn1, deviceIn2, deviceOut, "SAC",         "SAC")
 SUM02(deviceIn1, deviceIn2, deviceOut, "EAI",         "EAI")
 SUM02(deviceIn1, deviceIn2, deviceOut, "EAI_DAY",     "EAI_DAY")
 SUM02(deviceIn1, deviceIn2, deviceOut, "EAE",         "EAE")
 SUM02(deviceIn1, deviceIn2, deviceOut, "EAE_DAY",     "EAE_DAY")
 SUM02(deviceIn1, deviceIn2, deviceOut, "EQI",         "EQI")
 SUM02(deviceIn1, deviceIn2, deviceOut, "EQI_DAY",     "EQI_DAY")
 SUM02(deviceIn1, deviceIn2, deviceOut, "EQE",         "EQE")
 SUM02(deviceIn1, deviceIn2, deviceOut, "EQE_DAY",     "EQE_DAY")
 SUM02(deviceIn1, deviceIn2, deviceOut, "EAE_YDAY",    "TOTAL_EAE_YDAY")
 COM02(deviceIn1, deviceIn2, deviceOut, "COMMUNICATION_STATUS",  "COMMUNICATION_STATUS")
end

if devS=="EM02" then
 local deviceIn1 = "SN:EM04"
 local deviceIn2 = "SN:EM05"
 local deviceOut = "SN:EM02"
 AVG02(deviceIn1, deviceIn2, deviceOut, "UAC",         "UAC")
 AVG02(deviceIn1, deviceIn2, deviceOut, "UAC12",       "UAC12")
 AVG02(deviceIn1, deviceIn2, deviceOut, "UAC23",       "UAC23")
 AVG02(deviceIn1, deviceIn2, deviceOut, "UAC31",       "UAC31")
 AVG02(deviceIn1, deviceIn2, deviceOut, "UAC1",        "UAC1")
 AVG02(deviceIn1, deviceIn2, deviceOut, "UAC2",        "UAC2")
 AVG02(deviceIn1, deviceIn2, deviceOut, "UAC3",        "UAC3")
 SUM02(deviceIn1, deviceIn2, deviceOut, "IAC1",        "IAC1")
 SUM02(deviceIn1, deviceIn2, deviceOut, "IAC2",        "IAC2")
 SUM02(deviceIn1, deviceIn2, deviceOut, "IAC3",        "IAC3")
 AVG02(deviceIn1, deviceIn2, deviceOut, "FAC",         "FAC")
 AVG02(deviceIn1, deviceIn2, deviceOut, "PF",          "PF")
 SUM02(deviceIn1, deviceIn2, deviceOut, "PAC",         "PAC")
 SUM02(deviceIn1, deviceIn2, deviceOut, "PAC_AVG_05",  "PAC_AVG_05")
 SUM02(deviceIn1, deviceIn2, deviceOut, "PAC",         "PAC_AVG_15")
 SUM02(deviceIn1, deviceIn2, deviceOut, "PAC_MAX",     "PAC_MAX")
 SUM02(deviceIn1, deviceIn2, deviceOut, "QAC",         "QAC")
 SUM02(deviceIn1, deviceIn2, deviceOut, "SAC",         "SAC")
 SUM02(deviceIn1, deviceIn2, deviceOut, "EAI",         "EAI")
 SUM02(deviceIn1, deviceIn2, deviceOut, "EAI_DAY",     "EAI_DAY")
 SUM02(deviceIn1, deviceIn2, deviceOut, "EAE",         "EAE")
 SUM02(deviceIn1, deviceIn2, deviceOut, "EAE_DAY",     "EAE_DAY")
 SUM02(deviceIn1, deviceIn2, deviceOut, "EQI_EAI",     "EQI_EAI")
 SUM02(deviceIn1, deviceIn2, deviceOut, "EQE_EAI",     "EQE_EAI")
 SUM02(deviceIn1, deviceIn2, deviceOut, "EQI_EAE",     "EQI_EAE")
 SUM02(deviceIn1, deviceIn2, deviceOut, "EQE_EAE",     "EQE_EAE")
 SUM02(deviceIn1, deviceIn2, deviceOut, "EAE_YDAY",    "EAE_YDAY2")
 COM02(deviceIn1, deviceIn2, deviceOut, "COMMUNICATION_STATUS",  "COMMUNICATION_STATUS")
end

if devS=="EM03" then
 local deviceIn1 = "SN:EM06"
 local deviceIn2 = "SN:EM07"
 local deviceOut = "SN:EM03"
 AVG02(deviceIn1, deviceIn2, deviceOut, "UAC",         "UAC")
 AVG02(deviceIn1, deviceIn2, deviceOut, "UAC12",       "UAC12")
 AVG02(deviceIn1, deviceIn2, deviceOut, "UAC23",       "UAC23")
 AVG02(deviceIn1, deviceIn2, deviceOut, "UAC31",       "UAC31")
 AVG02(deviceIn1, deviceIn2, deviceOut, "UAC1",        "UAC1")
 AVG02(deviceIn1, deviceIn2, deviceOut, "UAC2",        "UAC2")
 AVG02(deviceIn1, deviceIn2, deviceOut, "UAC3",        "UAC3")
 SUM02(deviceIn1, deviceIn2, deviceOut, "IAC1",        "IAC1")
 SUM02(deviceIn1, deviceIn2, deviceOut, "IAC2",        "IAC2")
 SUM02(deviceIn1, deviceIn2, deviceOut, "IAC3",        "IAC3")
 AVG02(deviceIn1, deviceIn2, deviceOut, "FAC",         "FAC")
 AVG02(deviceIn1, deviceIn2, deviceOut, "PF",          "PF")
 SUM02(deviceIn1, deviceIn2, deviceOut, "PAC",         "PAC")
 SUM02(deviceIn1, deviceIn2, deviceOut, "PAC_AVG_05",  "PAC_AVG_05")
 SUM02(deviceIn1, deviceIn2, deviceOut, "PAC",         "PAC_AVG_15")
 SUM02(deviceIn1, deviceIn2, deviceOut, "PAC_MAX",     "PAC_MAX")
 SUM02(deviceIn1, deviceIn2, deviceOut, "QAC",         "QAC")
 SUM02(deviceIn1, deviceIn2, deviceOut, "SAC",         "SAC")
 SUM02(deviceIn1, deviceIn2, deviceOut, "EAI",         "EAI")
 SUM02(deviceIn1, deviceIn2, deviceOut, "EAI_DAY",     "EAI_DAY")
 SUM02(deviceIn1, deviceIn2, deviceOut, "EAE",         "EAE")
 SUM02(deviceIn1, deviceIn2, deviceOut, "EAE_DAY",     "EAE_DAY")
 SUM02(deviceIn1, deviceIn2, deviceOut, "EQI_EAI",     "EQI_EAI")
 SUM02(deviceIn1, deviceIn2, deviceOut, "EQE_EAI",     "EQE_EAI")
 SUM02(deviceIn1, deviceIn2, deviceOut, "EQI_EAE",     "EQI_EAE")
 SUM02(deviceIn1, deviceIn2, deviceOut, "EQE_EAE",     "EQE_EAE")
 SUM02(deviceIn1, deviceIn2, deviceOut, "EAE_YDAY",    "EAE_YDAY3")
 COM02(deviceIn1, deviceIn2, deviceOut, "COMMUNICATION_STATUS",  "COMMUNICATION_STATUS")
end
]]--
------------------------ Read Required Data Start -----------------------------

commStatus = commStatus or {}
commStatus[dev] = commStatus[dev] or {DayOn=WR.read(dev, "COMMUNICATION_DAY_ONLINE"), DayOff=WR.read(dev, "COMMUNICATION_DAY_OFFLINE"), HourOn=0, HourOff=0, ts=now}
if is_nan(commStatus[dev].DayOn) then commStatus[dev].DayOn = 0 end
if is_nan(commStatus[dev].DayOff) then commStatus[dev].DayOff = 0 end
--local radiation = WR.read(dev, "RADIATION")
--local radiationDay = WR.read(dev, "RADIATION_DAY")
--local pac = WR.read(dev, "PAC")
--local pacMax = WR.read(dev, "PAC_MAX")
--local pr = WR.read(dev, "PR")
--if is_nan(pr) then pr = 0 end
--local prMin = WR.read(dev, "PR_MIN")
--if is_nan(prMin) then prMin = 0 end
--local prDay = WR.read(dev, "PR_DAY")
--if is_nan(prDay) then prDay = 0 end
--local prDayGL = WR.read(dev, "PR_DAY_GL")
--if is_nan(prDayGL) then prDayGL = 0 end
--local pacn = pac / (settings.EM[devS].dcCapacity / 1000)
--if is_nan(pacn) then pacn = 0 end
--local eai = WR.read(dev, "EAI")
--local eae = WR.read(dev, "EAE")
--local eaiDay = WR.read(dev, "EAI_DAY")
--local eaeDay = WR.read(dev, "EAE_DAY")
--local uac = WR.read(dev, "UAC")
--local uac1 = WR.read(dev, "UAC1")
--local uac2 = WR.read(dev, "UAC2")
--local uac3 = WR.read(dev, "UAC3")
--local iac1 = WR.read(dev, "IAC1")
--local iac2 = WR.read(dev, "IAC2")
--local iac3 = WR.read(dev, "IAC3")


--local yday1 = WR.read(dev, "EAE_YDAY1")
--local yday2 = WR.read(dev, "EAE_YDAY2")
--local yday3 = WR.read(dev, "EAE_YDAY3")
--local eqiEai = WR.read(dev, "EQI_EAI")
--local eqiEae = WR.read(dev, "EQI_EAE")
--local eqeEai = WR.read(dev, "EQE_EAI")
--local eqeEae = WR.read(dev, "EQE_EAE")

--[[local Em02_Pac = WR.read(dev, "EM02_PAC")
if is_nan(Em02_Pac) then Em02_Pac = 0 end
local Em03_Pac = WR.read(dev, "EM03_PAC")
if is_nan(Em03_Pac) then Em03_Pac = 0 end
local Em04_Pac = WR.read(dev, "EM04_PAC")
if is_nan(Em04_Pac) then Em04_Pac = 0 end
local Em05_Pac = WR.read(dev, "EM05_PAC")
if is_nan(Em05_Pac) then Em05_Pac = 0 end
WR.setProp(dev, "PAC", (Em02_Pac + Em03_Pac + Em04_Pac + Em05_Pac))

local Em02_Qac = WR.read(dev, "EM02_QAC")
if is_nan(Em02_Qac) then Em02_Qac = 0 end
local Em03_Qac = WR.read(dev, "EM03_QAC")
if is_nan(Em03_Qac) then Em03_Qac = 0 end
local Em04_Qac = WR.read(dev, "EM04_QAC")
if is_nan(Em04_Qac) then Em04_Qac = 0 end
local Em05_Qac = WR.read(dev, "EM05_QAC")
if is_nan(Em05_Qac) then Em05_Qac = 0 end
WR.setProp(dev, "QAC", (Em02_Qac + Em03_Qac + Em04_Qac + Em05_Qac))

local Em02_Pf = WR.read(dev, "EM02_PF")
if is_nan(Em02_Pf) then Em02_Pf = 0 end
local Em03_Pf = WR.read(dev, "EM03_PF")
if is_nan(Em03_Pf) then Em03_Pf = 0 end
local Em04_Pf = WR.read(dev, "EM04_PF")
if is_nan(Em04_Pf) then Em04_Pf = 0 end
local Em05_Pf = WR.read(dev, "EM05_PF")
if is_nan(Em05_Pf) then Em05_Pf = 0 end
WR.setProp(dev, "PF", ((Em02_Pf + Em03_Pf + Em04_Pf + Em05_Pf) / 4))

local Em02_Uac12 = WR.read(dev, "EM02_UAC12")
if is_nan(Em02_Uac12) then Em02_Uac12 = 0 end
local Em03_Uac12 = WR.read(dev, "EM03_UAC12")
if is_nan(Em03_Uac12) then Em03_Uac12 = 0 end
local Em04_Uac12 = WR.read(dev, "EM04_UAC12")
if is_nan(Em04_Uac12) then Em04_Uac12 = 0 end
local Em05_Uac12 = WR.read(dev, "EM05_UAC12")
if is_nan(Em05_Uac12) then Em05_Uac12 = 0 end
WR.setProp(dev, "UAC12", ((Em02_Uac12 + Em03_Uac12 + Em04_Uac12 + Em05_Uac12) / 4))

local Em02_Uac23 = WR.read(dev, "EM02_UAC23")
if is_nan(Em02_Uac23) then Em02_Uac23 = 0 end
local Em03_Uac23 = WR.read(dev, "EM03_UAC23")
if is_nan(Em03_Uac23) then Em03_Uac23 = 0 end
local Em04_Uac23 = WR.read(dev, "EM04_UAC23")
if is_nan(Em04_Uac23) then Em04_Uac23 = 0 end
local Em05_Uac23 = WR.read(dev, "EM05_UAC23")
if is_nan(Em05_Uac23) then Em05_Uac23 = 0 end
WR.setProp(dev, "UAC23", ((Em02_Uac23 + Em03_Uac23 + Em04_Uac23 + Em05_Uac23) / 4))

local Em02_Uac31 = WR.read(dev, "EM02_UAC31")
if is_nan(Em02_Uac31) then Em02_Uac31 = 0 end
local Em03_Uac31 = WR.read(dev, "EM03_UAC31")
if is_nan(Em03_Uac31) then Em03_Uac31 = 0 end
local Em04_Uac31 = WR.read(dev, "EM04_UAC31")
if is_nan(Em04_Uac31) then Em04_Uac31 = 0 end
local Em05_Uac31 = WR.read(dev, "EM05_UAC31")
if is_nan(Em05_Uac31) then Em05_Uac31 = 0 end
WR.setProp(dev, "UAC31", ((Em02_Uac31 + Em03_Uac31 + Em04_Uac31 + Em05_Uac31) / 4))

local Em02_Fac = WR.read(dev, "EM02_FAC")
if is_nan(Em02_Fac) then Em02_Fac = 0 end
local Em03_Fac = WR.read(dev, "EM03_FAC")
if is_nan(Em03_Fac) then Em03_Fac = 0 end
local Em04_Fac = WR.read(dev, "EM04_FAC")
if is_nan(Em04_Fac) then Em04_Fac = 0 end
local Em05_Fac = WR.read(dev, "EM05_FAC")
if is_nan(Em05_Fac) then Em05_Fac = 0 end
WR.setProp(dev, "FAC", ((Em02_Fac + Em03_Fac + Em04_Fac + Em05_Fac) / 4))

local Em02_Uac = WR.read(dev, "EM02_UAC")
if is_nan(Em02_Uac) then Em02_Uac = 0 end
local Em03_Uac = WR.read(dev, "EM02_UAC")
if is_nan(Em03_Uac) then Em03_Uac = 0 end
local Em04_Uac = WR.read(dev, "EM04_UAC")
if is_nan(Em04_Uac) then Em04_Uac = 0 end
local Em05_Uac = WR.read(dev, "EM05_UAC")
if is_nan(Em05_Uac) then Em05_Uac = 0 end
local uac = ((Em02_Uac + Em03_Uac + Em04_Uac + Em05_Uac)/4)]]--

local uac12 = WR.read(dev, "UAC12")
local uac23 = WR.read(dev, "UAC23")
local uac31 = WR.read(dev, "UAC31")
WR.setProp(dev, "UAC", ((uac12 + uac23 + uac31)/3))

local iac1 = WR.read(dev, "IAC1")
local iac2 = WR.read(dev, "IAC2")
local iac3 = WR.read(dev, "IAC3")
WR.setProp(dev, "IAC", ((iac1 + iac2 + iac3)/3))

--[[local Em02_Iac = WR.read(dev, "EM02_IAC")
if is_nan(Em02_Iac) then Em02_Iac = 0 end
local Em03_Iac = WR.read(dev, "EM02_IAC")
if is_nan(Em03_Iac) then Em03_Iac = 0 end
local Em04_Iac = WR.read(dev, "EM04_IAC")
if is_nan(Em04_Iac) then Em04_Iac = 0 end
local Em05_Iac = WR.read(dev, "EM05_IAC")
if is_nan(Em05_Iac) then Em05_Iac = 0 end
local iac = ((Em02_Iac + Em03_Iac + Em04_Iac + Em05_Iac)/4)
WR.setProp(dev, "IAC", iac)]]---


if not(pacOld) then pacOld = WR.read(dev, "PAC_MAX") end
startTime = startTime or {}
startTime[dev] = startTime[dev] or {ts=WR.read(dev, "PLANT_START_TIME")}
if is_nan(startTime[dev].ts) then startTime[dev].ts = 0 end
stopTime = stopTime or {}
stopTime[dev] = stopTime[dev] or {ts=WR.read(dev, "PLANT_STOP_TIME"), againStart=0}
if is_nan(stopTime[dev].ts) then stopTime[dev].ts = 0 end
if is_nan(stopTime[dev].againStart) then stopTime[dev].againStart = 0 end
gridAvailability = gridAvailability or {}
gridAvailability[dev] = gridAvailability[dev] or {ts=now, tson=WR.read(dev, "GRID_ON"), tsoff=WR.read(dev, "GRID_OFF")}
if is_nan(gridAvailability[dev].tson) then gridAvailability[dev].tson = 0 end
if is_nan(gridAvailability[dev].tsoff) then gridAvailability[dev].tsoff = 0 end
opTime = opTime or {}
opTime[dev] = opTime[dev] or {ts=now, tson=WR.read(dev, "OPERATIONAL_TIME")}
if is_nan(opTime[dev].tson) then opTime[dev].tson = 0 end
WR.setProp(dev, "PAC_MAX_TIME", WR.read(dev, "PAC_MAX_TIME"))
WR.setProp(dev, "EAE_YDAY", WR.read(dev, "EAE_YDAYC"))


local pacLimitCmd = WR.read(dev, "PAC_LIMIT_CMD")
local pacLimitCmd1 = WR.read(dev, "PAC_LIMIT_CMD_1")
local qacRefSelCmd = WR.read(dev, "QAC_REF_SEL_CMD")
local qacRefCmd = WR.read(dev, "QAC_REF_CMD")
local qacRefCmd1 = WR.read(dev, "QAC_REF_CMD_1")

local pacPcCmd1 = WR.read(dev, "PAC_PC_CMD1")           --PC
local SelPcCmd = WR.read(dev, "SEL_PC_CMD")             --PC
local qacPcCmd1 = WR.read(dev, "QAC_PC_CMD1")           --PC
local uacPcCmd1 = WR.read(dev, "UAC_PC_CMD1")           --PC
local facPcCmd1 = WR.read(dev, "FAC_PC_CMD1")           --PC
local pfPcCmd1 = WR.read(dev, "PF_PC_CMD1")             --PC


local pacMaxsetCmd = WR.read(dev, "PAC_MAX_SET_CMD")
local qacMaxsetCmd = WR.read(dev, "QAC_MAX_SET_CMD")
local blkpacMaxCmd = WR.read(dev, "BLOCK_PAC_MAX_CMD")
local blkqacMaxCmd = WR.read(dev, "BLOCK_QAC_MAX_CMD")
local pacUllSetCmd = WR.read(dev, "PAC_ULL_SET_CMD")
local pacClSetCmd = WR.read(dev, "PAC_CL_SET_CMD")
local pacGrSetCmd = WR.read(dev, "PAC_GR_SET_CMD")
local pacTuneStcnstCmd = WR.read(dev, "PAC_TUNE_ST_CONST_CMD")
local pacIncrcnstCmd = WR.read(dev, "PAC_INCR_CONST_CMD")
local pacDcrcnstCmd = WR.read(dev, "PAC_DECR_CONST_CMD")
local qacUllSetCmd = WR.read(dev, "QAC_ULL_SET_CMD")
local qacClSetCmd = WR.read(dev, "QAC_CL_SET_CMD")
local qacGrSetCmd = WR.read(dev, "QAC_GR_SET_CMD")
local qacTuneStcnstCmd = WR.read(dev, "QAC_TUNE_ST_CONST_CMD")
local qacIncrcnstCmd = WR.read(dev, "QAC_INCR_CONST_CMD")
local qacDcrcnstCmd = WR.read(dev, "QAC_DECR_CONST_CMD")
local quUllSetCmd = WR.read(dev, "QU_ULL_SET_CMD")
local quClSetCmd = WR.read(dev, "QU_CL_SET_CMD")
local quGrSetCmd = WR.read(dev, "QU_GR_SET_CMD")
local quTuneStcnstCmd = WR.read(dev, "QU_TUNE_ST_CONST_CMD")
local quIncrcnstCmd = WR.read(dev, "QU_INCR_CONST_CMD")
local quDcrcnstCmd = WR.read(dev, "QU_DECR_CONST_CMD")
local facUlSetCmd = WR.read(dev, "FAC_UL_SET_CMD")
local facLlSetCmd = WR.read(dev, "FAC_LL_SET_CMD")
local facGrSetCmd = WR.read(dev, "FAC_GR_SET_CMD")
local facTuneStcnstCmd = WR.read(dev, "FAC_TUNE_ST_CONST_CMD")
local facIncrcnstCmd = WR.read(dev, "FAC_INCR_CONST_CMD")
local facDcrcnstCmd = WR.read(dev, "FAC_DECR_CONST_CMD")
local facCulsetCmd = WR.read(dev, "FAC_CUL_SET_CMD")
local facCllsetCmd = WR.read(dev, "FAC_CLL_SET_CMD")
local facDroopsetCmd = WR.read(dev, "FAC_DROOP_SET_CMD")
local pfUlSetCmd = WR.read(dev, "PF_UL_SET_CMD")
local pfLlSetCmd = WR.read(dev, "PF_LL_SET_CMD")


local pacOnOffCmd = WR.read(dev, "PAC_ON_OFF_CMD")             --PC
local qacOnOffCmd = WR.read(dev, "QAC_ON_OFF_CMD")             --PC
local uacOnOffCmd = WR.read(dev, "UAC_ON_OFF_CMD")             --PC
local facOnOffCmd = WR.read(dev, "FAC_ON_OFF_CMD")             --PC
local pfOnOffCmd = WR.read(dev, "PF_ON_OFF_CMD")               --PC
local f1OnOffCmd = WR.read(dev, "F1_ON_OFF_CMD")               --PC


if (devS=="EM01") then
 local pacLimitRx = WR.read(dev, "PAC_LIMIT_CMD_RX")
 local pacLimitRx1 = WR.read(dev, "PAC_LIMIT_CMD_RX_1")

 local qacRefSelRx = WR.read(dev, "QAC_REF_SEL_CMD_RX")
 local qacRefRx = WR.read(dev, "QAC_REF_CMD_RX")
 local qacRefRx1 = WR.read(dev, "QAC_REF_CMD_RX_1")

 local pacOnOffRx = WR.read(dev, "PAC_ON_OFF_RX")             --PC
 local qacOnOffRx = WR.read(dev, "QAC_ON_OFF_RX")             --PC
 local uacOnOffRx = WR.read(dev, "UAC_ON_OFF_RX")             --PC
 local facOnOffRx = WR.read(dev, "FAC_ON_OFF_RX")             --PC
 local pfOnOffRx = WR.read(dev, "PF_ON_OFF_RX")               --PC
 local f1OnOffRx = WR.read(dev, "F1_ON_OFF_RX")               --PC


 local pacMaxsetRx = WR.read(dev, "PAC_MAX_SET_RX")
 local qacMaxsetRx = WR.read(dev, "QAC_MAX_SET_RX")
 local blkpacMaxRx = WR.read(dev, "BLOCK_PAC_MAX_RX")
 local blkqacMaxRx = WR.read(dev, "BLOCK_QAC_MAX_RX")
 local pacUllSetRx = WR.read(dev, "PAC_ULL_SET_RX")
 local pacClSetRx = WR.read(dev, "PAC_CL_SET_RX")
 local pacGrSetRx = WR.read(dev, "PAC_GR_SET_RX")
 local pacTuneStcnstRx = WR.read(dev, "PAC_TUNE_ST_CONST_RX")
 local pacIncrcnstRx = WR.read(dev, "PAC_INCR_CONST_RX")
 local pacDcrcnstRx = WR.read(dev, "PAC_DECR_CONST_RX")
 local qacUllSetRx = WR.read(dev, "QAC_ULL_SET_RX")
 local qacClSetRx = WR.read(dev, "QAC_CL_SET_RX")
 local qacGrSetRx = WR.read(dev, "QAC_GR_SET_RX")
 local qacTuneStcnstRx = WR.read(dev, "QAC_TUNE_ST_CONST_RX")
 local qacIncrcnstRx = WR.read(dev, "QAC_INCR_CONST_RX")
 local qacDcrcnstRx = WR.read(dev, "QAC_DECR_CONST_RX")
 local quUllSetRx = WR.read(dev, "QU_ULL_SET_RX")
 local quClSetRx = WR.read(dev, "QU_CL_SET_RX")
 local quGrSetRx = WR.read(dev, "QU_GR_SET_RX")
 local quTuneStcnstRx = WR.read(dev, "QU_TUNE_ST_CONST_RX")
 local quIncrcnstRx = WR.read(dev, "QU_INCR_CONST_RX")
 local quDcrcnstRx = WR.read(dev, "QU_DECR_CONST_RX")
 local facUlSetRx = WR.read(dev, "FAC_UL_SET_RX")
 local facLlSetRx = WR.read(dev, "FAC_LL_SET_RX")
 local facGrSetRx = WR.read(dev, "FAC_GR_SET_RX")
 local facTuneStcnstRx = WR.read(dev, "FAC_TUNE_ST_CONST_RX")
 local facIncrcnstRx = WR.read(dev, "FAC_INCR_CONST_RX")
 local facDcrcnstRx = WR.read(dev, "FAC_DECR_CONST_RX")
 local facCulsetRx = WR.read(dev, "FAC_CUL_SET_RX")
 local facCllsetRx = WR.read(dev, "FAC_CLL_SET_RX")
 local facDroopsetRx = WR.read(dev, "FAC_DROOP_SET_RX")
 local pfUlSetRx = WR.read(dev, "PF_UL_SET_RX")
 local pfLlSetRx = WR.read(dev, "PF_LL_SET_RX")

 local pacPcRx1 = WR.read(dev, "PAC_PC_RX1")            --PC
 local SelPcRx = WR.read(dev, "SEL_PC_RX")              --PC
 local qacPcRx1 = WR.read(dev, "QAC_PC_RX1")            --PC
 local uacPcRx1 = WR.read(dev, "UAC_PC_RX1")            --PC
 local facPcRx1 = WR.read(dev, "FAC_PC_RX1")            --PC
 local pfPcRx1 = WR.read(dev, "PF_PC_RX1")              --PC

 local SldcpacPcRx1 = WR.read(dev, "SLDC_PAC_PC_RX1")   --sldc
 local SldcqacPcRx1 = WR.read(dev, "SLDC_QAC_PC_RX1")   --sldc
 local SldcuacPcRx1 = WR.read(dev, "SLDC_UAC_PC_RX1")   --sldc
 local SldcfacPcRx1 = WR.read(dev, "SLDC_FAC_PC_RX1")   --sldc
 local SldcpfPcRx1 = WR.read(dev, "SLDC_PF_PC_RX1")     --sldc
 local SldcFBRx = WR.read(dev, "SLDC_PC_FB")            --sldc Feedback

 if is_nan(SldcFBRx) then SldcFBRx = 0 end

  local pfAct = WR.read(dev, "PF")
  WR.setProp(dev, "PF_ACT", (pfAct))

  local qacAct = WR.read(dev, "QAC")
  WR.setProp(dev, "QAC_ACT", (qacAct))


 WR.setProp(dev, "PAC_LIMIT_CMD_RX", pacLimitRx)
 WR.setProp(dev, "PAC_LIMIT_CMD_RX_1", pacLimitRx1)

 WR.setProp(dev, "QAC_REF_SEL_CMD_RX", qacRefSelRx)
 WR.setProp(dev, "QAC_REF_CMD_RX", qacRefRx)
 WR.setProp(dev, "QAC_REF_CMD_RX_1", qacRefRx1)


 WR.setProp(dev, "PAC_ON_OFF_RX", pacOnOffRx)
 WR.setProp(dev, "QAC_ON_OFF_RX", qacOnOffRx)
 WR.setProp(dev, "UAC_ON_OFF_RX", uacOnOffRx)
 WR.setProp(dev, "FAC_ON_OFF_RX", facOnOffRx)
 WR.setProp(dev, "PF_ON_OFF_RX", pfOnOffRx)
 WR.setProp(dev, "F1_ON_OFF_RX", f1OnOffRx)


 WR.setProp(dev, "PAC_PC_RX1", pacPcRx1)               --PC
 WR.setProp(dev, "SEL_PC_RX", SelPcRx)                 --PC
 WR.setProp(dev, "QAC_PC_RX1", qacPcRx1)               --PC
 WR.setProp(dev, "UAC_PC_RX1", uacPcRx1)               --PC
 WR.setProp(dev, "FAC_PC_RX1", facPcRx1)               --PC
 WR.setProp(dev, "PF_PC_RX1",  pfPcRx1)                --PC

 WR.setProp(dev, "SLDC_PAC_PC_RX1", SldcpacPcRx1)      --sldc
 WR.setProp(dev, "SLDC_QAC_PC_RX1", SldcqacPcRx1)      --sldc
 WR.setProp(dev, "SLDC_UAC_PC_RX1", SldcuacPcRx1)      --sldc
 WR.setProp(dev, "SLDC_FAC_PC_RX1", SldcfacPcRx1)      --sldc
 WR.setProp(dev, "SLDC_PF_PC_RX1",  SldcpfPcRx1)       --sldc
 WR.setProp(dev, "SLDC_PC_FB",      SldcFBRx)          --sldc

 WR.setProp(dev, "PAC_MAX_SET_RX", pacMaxsetRx)
 WR.setProp(dev, "QAC_MAX_SET_RX", qacMaxsetRx)
 WR.setProp(dev, "BLOCK_PAC_MAX_RX", blkpacMaxRx)
 WR.setProp(dev, "BLOCK_QAC_MAX_RX", blkqacMaxRx)
 WR.setProp(dev, "PAC_ULL_SET_RX", pacUllSetRx)
 WR.setProp(dev, "PAC_CL_SET_RX", pacClSetRx)
 WR.setProp(dev, "PAC_GR_SET_RX", pacGrSetRx)
 WR.setProp(dev, "PAC_TUNE_ST_CONST_RX", pacTuneStcnstRx)
 WR.setProp(dev, "PAC_INCR_CONST_RX", pacIncrcnstRx)
 WR.setProp(dev, "PAC_DECR_CONST_RX", pacDcrcnstRx)
 WR.setProp(dev, "QAC_ULL_SET_RX", qacUllSetRx)
 WR.setProp(dev, "QAC_CL_SET_RX", qacClSetRx)
 WR.setProp(dev, "QAC_GR_SET_RX", qacGrSetRx)
 WR.setProp(dev, "QAC_TUNE_ST_CONST_RX", qacTuneStcnstRx)
 WR.setProp(dev, "QAC_INCR_CONST_RX", qacIncrcnstRx)
 WR.setProp(dev, "QAC_DECR_CONST_RX", qacDcrcnstRx)
 WR.setProp(dev, "QU_ULL_SET_RX", quUllSetRx)
 WR.setProp(dev, "QU_CL_SET_RX", quClSetRx)
 WR.setProp(dev, "QU_GR_SET_RX", quGrSetRx)
 WR.setProp(dev, "QU_TUNE_ST_CONST_RX", quTuneStcnstRx)
 WR.setProp(dev, "QU_INCR_CONST_RX", quIncrcnstRx)
 WR.setProp(dev, "QU_DECR_CONST_RX", quDcrcnstRx)
 WR.setProp(dev, "FAC_UL_SET_RX", facUlSetRx)
 WR.setProp(dev, "FAC_LL_SET_RX", facLlSetRx)
 WR.setProp(dev, "FAC_GR_SET_RX", facGrSetRx)
 WR.setProp(dev, "FAC_TUNE_ST_CONST_RX", facTuneStcnstRx)
 WR.setProp(dev, "FAC_INCR_CONST_RX", facIncrcnstRx)
 WR.setProp(dev, "FAC_DECR_CONST_RX", facDcrcnstRx)
 WR.setProp(dev, "FAC_CUL_SET_RX", facCulsetRx)
 WR.setProp(dev, "FAC_CLL_SET_RX", facCllsetRx)
 WR.setProp(dev, "FAC_DROOP_SET_RX", facDroopsetRx)
 WR.setProp(dev, "PF_UL_SET_RX", pfUlSetRx)
 WR.setProp(dev, "PF_LL_SET_RX", pfLlSetRx)


 WR.setProp(dev, "PAC_LIMIT_CMD", pacLimitRx)
 WR.setProp(dev, "PAC_LIMIT_CMD_1", pacLimitRx1)

 WR.setProp(dev, "QAC_REF_SEL_CMD", qacRefSelRx)
 WR.setProp(dev, "QAC_REF_CMD", qacRefRx)
 WR.setProp(dev, "QAC_REF_CMD_1", qacRefRx1)


 WR.setProp(dev, "PAC_ON_OFF_CMD", pacOnOffRx)
 WR.setProp(dev, "QAC_ON_OFF_CMD", qacOnOffRx)
 WR.setProp(dev, "UAC_ON_OFF_CMD", uacOnOffRx)
 WR.setProp(dev, "FAC_ON_OFF_CMD", facOnOffRx)
 WR.setProp(dev, "PF_ON_OFF_CMD", pfOnOffRx)
 WR.setProp(dev, "F1_ON_OFF_CMD", f1OnOffRx)


 WR.setProp(dev, "PAC_MAX_SET_CMD", pacMaxsetRx)
 WR.setProp(dev, "QAC_MAX_SET_CMD", qacMaxsetRx)
 WR.setProp(dev, "BLOCK_PAC_MAX_CMD", blkpacMaxRx)
 WR.setProp(dev, "BLOCK_QAC_MAX_CMD", blkqacMaxRx)
 WR.setProp(dev, "PAC_ULL_SET_CMD", pacUllSetRx)
 WR.setProp(dev, "PAC_CL_SET_CMD", pacClSetRx)
 WR.setProp(dev, "PAC_GR_SET_CMD", pacGrSetRx)
 WR.setProp(dev, "PAC_TUNE_ST_CONST_CMD", pacTuneStcnstRx)
 WR.setProp(dev, "PAC_INCR_CONST_CMD", pacIncrcnstRx)
 WR.setProp(dev, "PAC_DECR_CONST_CMD", pacDcrcnstRx)
 WR.setProp(dev, "QAC_ULL_SET_CMD", qacUllSetRx)
 WR.setProp(dev, "QAC_CL_SET_CMD", qacClSetRx)
 WR.setProp(dev, "QAC_GR_SET_CMD", qacGrSetRx)
 WR.setProp(dev, "QAC_TUNE_ST_CONST_CMD", qacTuneStcnstRx)
 WR.setProp(dev, "QAC_INCR_CONST_CMD", qacIncrcnstRx)
 WR.setProp(dev, "QAC_DECR_CONST_CMD", qacDcrcnstRx)
 WR.setProp(dev, "QU_ULL_SET_CMD", quUllSetRx)
 WR.setProp(dev, "QU_CL_SET_CMD", quClSetRx)
 WR.setProp(dev, "QU_GR_SET_CMD", quGrSetRx)
 WR.setProp(dev, "QU_TUNE_ST_CONST_CMD", quTuneStcnstRx)
 WR.setProp(dev, "QU_INCR_CONST_CMD", quIncrcnstRx)
 WR.setProp(dev, "QU_DECR_CONST_CMD", quDcrcnstRx)
 WR.setProp(dev, "FAC_UL_SET_CMD", facUlSetRx)
 WR.setProp(dev, "FAC_LL_SET_CMD", facLlSetRx)
 WR.setProp(dev, "FAC_GR_SET_CMD", facGrSetRx)
 WR.setProp(dev, "FAC_TUNE_ST_CONST_CMD", facTuneStcnstRx)
 WR.setProp(dev, "FAC_INCR_CONST_CMD", facIncrcnstRx)
 WR.setProp(dev, "FAC_DECR_CONST_CMD", facDcrcnstRx)
 WR.setProp(dev, "FAC_CUL_SET_CMD", facCulsetRx)
 WR.setProp(dev, "FAC_CLL_SET_CMD", facCllsetRx)
 WR.setProp(dev, "FAC_DROOP_SET_CMD", facDroopsetRx)
 WR.setProp(dev, "PF_UL_SET_CMD", pfUlSetRx)
 WR.setProp(dev, "PF_LL_SET_CMD", pfLlSetRx)


 WR.setProp(dev, "SEL_PC_CMD", SelPcRx)                 --PC

 if (SldcFBRx == 0) then
 WR.setProp(dev, "PAC_PC_CMD1", pacPcRx1)               --PC
 WR.setProp(dev, "QAC_PC_CMD1", qacPcRx1)               --PC
 WR.setProp(dev, "UAC_PC_CMD1", uacPcRx1)               --PC
 WR.setProp(dev, "FAC_PC_CMD1", facPcRx1)               --PC
 WR.setProp(dev, "PF_PC_CMD1", pfPcRx1)                 --PC
 elseif (SldcFBRx == 1) then
 WR.setProp(dev, "PAC_PC_CMD1", SldcpacPcRx1)           --sldc
 WR.setProp(dev, "QAC_PC_CMD1", SldcqacPcRx1)           --sldc
 WR.setProp(dev, "UAC_PC_CMD1", SldcuacPcRx1)           --sldc
 WR.setProp(dev, "FAC_PC_CMD1", SldcfacPcRx1)           --sldc
 WR.setProp(dev, "PF_PC_CMD1", SldcpfPcRx1)           --sldc
 end
 end



--if is_nan(pac) then pac = 0 end

------------------------ Read Required Data End -------------------------------

checkMidnight = checkMidnight or {}
checkMidnight[dev] = checkMidnight[dev] or {ts=now}
if (os.date("*t", checkMidnight[dev].ts).hour > os.date("*t", now).hour) then
 startTime[dev].ts = 0
 stopTime[dev].ts = 0
 gridAvailability[dev].tson = 0
 gridAvailability[dev].tsoff = 0
 opTime[dev].tson = 0
 pacOld = 0
 prDay = 0
 prMin = 0
 WR.setProp(dev, "PAC_MAX_TIME", 0)
 commStatus[dev].HourOn = 0
 commStatus[dev].HourOff = 0
 commStatus[dev].DayOn = 0
 commStatus[dev].DayOff = 0
end
if (os.date("*t", checkMidnight[dev].ts).hour < os.date("*t", now).hour) then
 commStatus[dev].HourOn = 0
 commStatus[dev].HourOff = 0
end
checkMidnight[dev].ts = now

------------------------ Check Midnight End -----------------------------------

---------------------- COMMUNICATION STATUS Start -----------------------------

if WR.isOnline(dev) then
 WR.setProp(dev, "COMMUNICATION_STATUS", 0)
else
 WR.setProp(dev, "COMMUNICATION_STATUS", 1)
end

local commChannel = 0
for d in WR.devices() do
 --print("d = ",d)
 if not(WR.isOnline(d)) then
  commChannel = commChannel + 1
  if (commChannel > 1) then commChannel = 1 end
 end
 --print("commChannel = ",commChannel)
end
file = io.open("/ram/"..masterid..".temp","w+")
if file ~= nil then
 file:write(commChannel)
end
file:close()
os.remove("/ram/"..masterid.."")
os.rename("/ram/"..masterid..".temp","/ram/"..masterid.."")

if ((now-commStatus[dev].ts) >= 15) then
 --print("commStatus["..dev.."].commDayOnline = ", commStatus[dev].commDayOnline)
 --print("commStatus["..dev.."].commDayOffline = ", commStatus[dev].commDayOffline)
 --print("commStatus["..dev.."].commHourOnline = ", commStatus[dev].commHourOnline)
 --print("commStatus["..dev.."].commHourOffline = ", commStatus[dev].commHourOffline)
 --print("commStatus["..dev.."].ts = ", commStatus[dev].ts)
 if good then
  commStatus[dev].DayOn = commStatus[dev].DayOn + 1
  commStatus[dev].HourOn = commStatus[dev].HourOn + 1
 else
  commStatus[dev].DayOff = commStatus[dev].DayOff + 1
  commStatus[dev].HourOff = commStatus[dev].HourOff + 1
 end
 commStatus[dev].ts = now
 WR.setProp(dev, "COMMUNICATION_DAY_ONLINE", commStatus[dev].DayOn)
 WR.setProp(dev, "COMMUNICATION_DAY_OFFLINE", commStatus[dev].DayOff)
 WR.setProp(dev, "COMMUNICATION_DAY", (((commStatus[dev].DayOn) / (commStatus[dev].DayOn + commStatus[dev].DayOff)) * 100))
 WR.setProp(dev, "COMMUNICATION_HOUR", (((commStatus[dev].HourOn) / (commStatus[dev].HourOn + commStatus[dev].HourOff)) * 100))
end

---------------------- COMMUNICATION STATUS End -------------------------------



--------------------- Plant Operational Time Calculation Start ----------------

local SelPcCmd = WR.read(dev, "SEL_PC_CMD")
if (SelPcCmd > 0) then
 opTime[dev].tson = opTime[dev].tson + (now - opTime[dev].ts)
 if (startTime[dev].ts == 0) then
  startTime[dev].ts = ((hour * 60 * 60) + (min * 60) + sec)
 end
 stopTime[dev].againStart = 1
elseif ((SelPcCmd <= 0) and  (startTime[dev].ts ~= 0) and ((stopTime[dev].againStart == 1) or (stopTime[dev].ts == 0))) then
 stopTime[dev].ts = ((hour * 60 * 60) + (min * 60) + sec)
 stopTime[dev].againStart = 0
end
opTime[dev].ts = now
WR.setProp(dev, "PC_START_TIME", startTime[dev].ts)
WR.setProp(dev, "PC_STOP_TIME", stopTime[dev].ts)
WR.setProp(dev, "OPERATIONAL_TIME", opTime[dev].tson)

--------------------- Plant Operational Time Calculation End ------------------

