local dev, good = ...
--print(dev)

devS = string.sub(dev, 8, -1)
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

------------------------- Read Function End -----------------------------------

if not(settings) then
 --print ("Inside file loading")
 settingsConfig = assert(io.open("/mnt/jffs2/solar/modbus/Settings.txt", "r"))
 settingsJson = settingsConfig:read("*all")
 settings = cjson.decode(settingsJson)
 settingsConfig:close()
end

if not(settings.INVERTER[devS].dcCapacity and settings.INVERTER[devS].prAlarmSetpoint and settings.INVERTER[devS].prAlarmRadSetpoint and settings.INVERTER[devS].prAlarmTimeSetpoint and settings.INVERTER[devS].prRealRadSetpoint and settings.INVERTER[devS].prMinRadSetpoint and settings.INVERTER[devS].igbtHighTempSetpoint) then
 --print ("Data loading")
 settings.INVERTER[devS].dcCapacity = settings.INVERTER[devS].dcCapacity or settings.INVERTER.dcCapacity or 1073.6
 settings.INVERTER[devS].prAlarmSetpoint = settings.INVERTER[devS].prAlarmSetpoint or settings.INVERTER.prAlarmSetpoint or 75
 settings.INVERTER[devS].prAlarmRadSetpoint = settings.INVERTER[devS].prAlarmRadSetpoint or settings.INVERTER.prAlarmRadSetpoint or 500
 settings.INVERTER[devS].prAlarmTimeSetpoint = settings.INVERTER[devS].prAlarmTimeSetpoint or settings.INVERTER.prAlarmTimeSetpoint or 300
 settings.INVERTER[devS].prRealRadSetpoint = settings.INVERTER[devS].prRealRadSetpoint or settings.INVERTER.prRealRadSetpoint or 100
 settings.INVERTER[devS].prMinRadSetpoint = settings.INVERTER[devS].prMinRadSetpoint or settings.INVERTER.prMinRadSetpoint or 500
 settings.INVERTER[devS].igbtHighTempSetpoint = settings.INVERTER[devS].igbtHighTempSetpoint or settings.INVERTER.igbtHighTempSetpoint or 100
 settings.INVERTER[devS].operationTimePowerSetpoint = settings.INVERTER[devS].operationTimePowerSetpoint or settings.INVERTER.operationTimePowerSetpoint or 10
 settings.INVERTER[devS].ProductionTimeRadSetpoint = settings.INVERTER[devS].ProductionTimeRadSetpoint or settings.INVERTER.ProductionTimeRadSetpoint or 25

 CHECKDATATIME(dev, now, "START_TIME")
 CHECKDATATIME(dev, now, "STOP_TIME")
 CHECKDATATIME(dev, now, "OPERATIONAL_TIME")
 CHECKDATATIME(dev, now, "PLANNED_PRODUCTION_TIME")
 CHECKDATATIME(dev, now, "EDC_DAY")
 CHECKDATATIME(dev, now, "PR_MIN")
 CHECKDATATIME(dev, now, "PR_DAY")
end

--print ("dcCapacity = ", settings.INVERTER[devS].dcCapacity)
--print ("prAlarmSetpoint = ", settings.INVERTER[devS].prAlarmSetpoint)
--print ("prAlarmRadSetpoint = ", settings.INVERTER[devS].prAlarmRadSetpoint)
--print ("prAlarmTimeSetpoint = ", settings.INVERTER[devS].prAlarmTimeSetpoint)
--print ("prRealRadSetpoint = ", settings.INVERTER[devS].prRealRadSetpoint)
--print ("prMinRadSetpoint = ", settings.INVERTER[devS].prMinRadSetpoint)
--print ("igbtHighTempSetpoint = ", settings.INVERTER[devS].igbtHighTempSetpoint)

------------------------ Read Setpoints End -----------------------------------

------------------------ Read Required Data Start -----------------------------

local radiation = WR.read(dev, "RADIATION")
local radiationCum = WR.read(dev, "RADIATION_CUM")
local pdc = WR.read(dev, "PDC")
if is_nan(pdc) then pdc = 0 end
local pac = WR.read(dev, "PAC")
local pacAvg5 = WR.read(dev, "PAC_AVG5")
if is_nan(pac) then pac = 0 end
local pacn = pac / (settings.INVERTER[devS].dcCapacity)
local qac = WR.read(dev, "QAC")
local sac = math.sqrt(((pac * pac) + (qac * qac)))
local pr = WR.read(dev, "PR")
if is_nan(pr) then pr = 0 end
local prMin = WR.read(dev, "PR_MIN")
if is_nan(prMin) then prMin = 0 end
local prDay = WR.read(dev, "PR_DAY")
if is_nan(prDay) then prDay = 0 end
local eae = WR.read(dev, "EAE")
local eaeDay = WR.read(dev, "EAE_DAY")
if is_nan(eaeDay) then eaeDay = 0 end
local mainStFault = WR.read(dev, "MAIN_ST_Fault")
local mainStWarn = WR.read(dev, "MAIN_ST_Warning")
local pvSt = WR.read(dev, "PV_ST")
local gndSt = WR.read(dev, "GND_ST")
local ioFault = WR.read(dev, "IO_FAULT")
local supplyFault = WR.read(dev, "SUPPLY_FAULT")
local supplyAlarm = WR.read(dev, "SUPPLY_ALARM")
local mcuFault = WR.read(dev, "MCU_FAULT")
local mcuAlarm = WR.read(dev, "MCU_ALARM")

opTime = opTime or {}
opTime[dev] = opTime[dev] or {ts=now, tson=WR.read(dev, "OPERATIONAL_TIME")}
if is_nan(opTime[dev].tson) then opTime[dev].tson = 0 end

productionTime = productionTime or {}
productionTime[dev] = productionTime[dev] or {ts=now, tson=WR.read(dev, "PLANNED_PRODUCTION_TIME")}
if is_nan(productionTime[dev].tson) then productionTime[dev].tson = 0 end

startTime = startTime or {}
startTime[dev] = startTime[dev] or {ts=WR.read(dev, "START_TIME")}
if is_nan(startTime[dev].ts) then startTime[dev].ts = 0 end

stopTime = stopTime or {}
stopTime[dev] = stopTime[dev] or {ts=WR.read(dev, "STOP_TIME"), againStart=0}
if is_nan(stopTime[dev].ts) then stopTime[dev].ts = 0 end
if is_nan(stopTime[dev].againStart) then stopTime[dev].againStart = 0 end

invEDcDay = invEDcDay or {}
invEDcDay[dev] = invEDcDay[dev] or {ts=now, en=WR.read(dev, "EDC_DAY")}
if (is_nan(invEDcDay[dev].en)) then invEDcDay[dev].en = 0 end

local pacLimit = WR.read(dev, "PAC_LIMIT") * 100
local qacRefSel = WR.read(dev, "QAC_REF_SEL")
local qacRef = WR.read(dev, "QAC_REF")
local pacLimitCmd = WR.read(dev, "PAC_LIMIT_CMD") * 100
local qacRefSelCmd = WR.read(dev, "QAC_REF_SEL_CMD")
local qacRefCmd = WR.read(dev, "QAC_REF_CMD")

------------------------ Read Required Data End -------------------------------

------------------------ Check Midnight Start ---------------------------------

checkMidnight = checkMidnight or {}
checkMidnight[dev] = checkMidnight[dev] or {ts=now}
if (os.date("*t", checkMidnight[dev].ts).hour > os.date("*t", now).hour) then
 startTime[dev].ts = 0
 stopTime[dev].ts = 0
 opTime[dev].ts = 0
 stopTime[dev].againStart = 0
 invEDcDay[dev].en = 0
 prMin = 0
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

---------------------- COMMUNICATION STATUS End -------------------------------

--------------------- Inverter POWER LIMIT Start ------------------------------

function Dec2Hex(nValue)
 if type(nValue) == "string" then
  nValue = String.ToNumber(nValue);
 end
 if (nValue < 0 ) then
  nValue = 65536 + nValue
 end
 nHexVal = string.format("%04X", nValue);  -- %X returns uppercase hex, %x gives lowercase letters
 sHexVal = nHexVal.."";
 return sHexVal;
end

function logEvent(file, msg)
 file = io.open(file,"a")
 if file~=nil then
  file:write(os.date("%a %b %d %X %Y",currTime).." "..msg.."\n")
 end
 file:close()
end

if (pacLimitCmd == -1) then
 WR.writeHex(dev, ("PAC_LIMIT"), "4E20")
 logEvent("/var/log/event.log",""..devS.." RESET \"PAC_LIMIT\"   from Scada. Setting to \"200\" %")
elseif ((not(is_nan(pacLimitCmd))) and (pacLimitCmd ~= pacLimit)) then
 WR.writeHex(dev, ("PAC_LIMIT"), Dec2Hex(pacLimitCmd))
 logEvent("/var/log/event.log",""..devS.." SET   \"PAC_LIMIT\"   from Scada. Setting to \""..pacLimitCmd.."\" %")
end

if ((qacRefSel == 2) and (not((qacRef >= -32678) and (qacRef <= 32767)))) then
 qacRefCmd = 0
 WR.writeHex(dev, "QAC_REF", Dec2Hex(qacRefCmd))
 logEvent("/var/log/event.log",""..devS.." RESET \"QAC_REF\"     from iGate Due to \"OUT_OF_RANGE\". Setting to \"0\"")
elseif ((qacRefSel == 4) and ((not((qacRef <= -8500) and (qacRef >= -9999))) and (not((qacRef >= 8500) and (qacRef <= 10000))))) then
 qacRefCmd = 10000
 WR.writeHex(dev, "QAC_REF", Dec2Hex(qacRefCmd))
 logEvent("/var/log/event.log",""..devS.." RESET \"QAC_REF\"     from iGate Due to \"OUT_OF_RANGE\". Setting to \"10000\"")
end

if (qacRefSelCmd == -1) then
 if ((qacRefSel ~= 2) or (qacRef ~= 0)) then
  WR.writeHex(dev, ("QAC_REF_SEL"), "0002")
  WR.writeHex(dev, ("QAC_REF"), "0000")
  logEvent("/var/log/event.log",""..devS.." RESET \"QAC_REF_SEL\" from Scada. Setting to \"2\" (kVAr Mode)")
  logEvent("/var/log/event.log",""..devS.." RESET \"QAC_REF\"     from Scada. Setting to \"0\"")
 end
elseif ((not(is_nan(qacRefSelCmd))) and (qacRefSelCmd ~= qacRefSel)) then
 qacRefSel = qacRefSelCmd
 WR.writeHex(dev, ("QAC_REF_SEL"), Dec2Hex(qacRefSelCmd))
 logEvent("/var/log/event.log",""..devS.." SET   \"QAC_REF_SEL\" from Scada. Setting to \""..qacRefSelCmd.."\"")
end

if (qacRefCmd == -1) then
 if (qacRefSelCmd == 2) then
  WR.writeHex(dev, ("QAC_REF"), "0000")
  logEvent("/var/log/event.log",""..devS.." RESET \"QAC_REF\"     from Scada. Setting to \"0000\"")
 elseif (qacRefSelCmd == 4) then
  WR.writeHex(dev, ("QAC_REF"), "2710")
  logEvent("/var/log/event.log",""..devS.." RESET \"QAC_REF\"     from Scada. Setting to \"10000\"")
 end
elseif ((not(is_nan(qacRefCmd))) and (qacRefCmd ~= qacRef)) then
 if ((qacRefSel == 2) and (not((qacRefCmd >= -32768) and (qacRefCmd <= 32767)))) then
  qacRefCmd = 0
 elseif ((qacRefSel == 4) and (not(((qacRefCmd <= -8500) and (qacRefCmd >= -9999)) or ((qacRefCmd >= 8500) and (qacRefCmd <= 10000))))) then
  qacRefCmd = 10000
 end
 WR.writeHex(dev, ("QAC_REF"), Dec2Hex(qacRefCmd))
 logEvent("/var/log/event.log",""..devS.." SET   \"QAC_REF\"     from Scada. Setting to \""..qacRefCmd.."\"")
end

---------------------- Inverter POWER LIMIT End -------------------------------

----------------- Inverter Start & Stop Time Calculation Start ----------------

if ((pvSt == 3) or (pvSt == 4) or (pac > settings.INVERTER[devS].operationTimePowerSetpoint)) then
 opTime[dev].tson = opTime[dev].tson + (now - opTime[dev].ts)
 if (startTime[dev].ts == 0) then
  startTime[dev].ts = (now + 19800)
 end
 stopTime[dev].againStart = 1
elseif (((pvSt == 1) or (pvSt == 2) or (pvSt == 6) or (pac <= 0)) and (startTime[dev].ts ~= 0) and ((stopTime[dev].againStart == 1) or (stopTime[dev].ts == 0))) then
 stopTime[dev].ts = (now + 19800)
 stopTime[dev].againStart = 0
end
opTime[dev].ts = now
WR.setProp(dev, "PLANT_START_TIME", startTime[dev].ts)
WR.setProp(dev, "PLANT_STOP_TIME", stopTime[dev].ts)
WR.setProp(dev, "OPERATIONAL_TIME", opTime[dev].tson)

----------------- Inverter Start & Stop Time Calculation End ------------------

------------------- Inverter Datapoint Calculation Start ----------------------

local eaeNow = (WR.read(dev, "EAE_GWH") * 1000) + WR.read(dev, "EAE_MWH") + (WR.read(dev, "EAE_KWH") / 1000)
if not((is_nan(eaeNow)) or (eaeNow == 0)) then
 eae = eaeNow
end
WR.setProp(dev, "EAE", eae)
WR.setProp(dev, "EAE_DAY", eae)
WR.setProp(dev, "EAE_YDAY", (eae - eaeDay))
WR.setProp(dev, "EAEN_DAY", (eaeDay / (settings.INVERTER[devS].dcCapacity / 1000)))
WR.setProp(dev, "UAC",((WR.read(dev, "UAC1") + WR.read(dev, "UAC2") + WR.read(dev, "UAC3")) / 3))
WR.setProp(dev, "IAC",((WR.read(dev, "IAC1") + WR.read(dev, "IAC2") + WR.read(dev, "IAC3")) / 3))
WR.setProp(dev, "SAC", sac)

------------------- Inverter Datapoint Calculation End ------------------------

--------------------------- DC Energy Start------------------------------------

invEDcDay[dev].en = invEDcDay[dev].en + (((now-invEDcDay[dev].ts) * pdc) / (60*60*1000))
invEDcDay[dev].ts = now
WR.setProp(dev, "EDC_DAY", invEDcDay[dev].en)

--------------------------- DC Energy End--------------------------------------

------------------------ Inverter Alarm Start ---------------------------------

if (WR.read(dev, "INV_FAIL") == 1) then
 WR.setProp(dev, "INV_FAULT_CODE", WR.read(dev, "ICU_FCL"))
else
 WR.setProp(dev, "INV_FAULT_CODE", 0)
end
if (WR.read(dev, "INV_ALARM") == 1) then
 WR.setProp(dev, "INV_ALARM_CODE", WR.read(dev, "ICU_ALM1"))
else
 WR.setProp(dev, "INV_ALARM_CODE", 0)
end

------------------------ Inverter Alarm End -----------------------------------

---------------------- IGBT Temp Alarm Start ----------------------------------

local igbtOvertemp = 0
if (WR.read(dev, "IGBT_TEMP") > settings.INVERTER[devS].igbtHighTempSetpoint) then
 igbtOvertemp = 1
else
 igbtOvertemp = 0
end
WR.setProp(dev, "IGBT_OVERTEMP_Alarm", igbtOvertemp)
WR.setProp(dev, "IGBT_OVERTEMP", igbtOvertemp)

---------------------- IGBT Temp Alarm End ------------------------------------

----------------------- Logic for INVERTER Alarm Start-------------------------

if (mainStFault==1 or mainStWarn==1 or pvSt==6 or gndSt==1 or gndSt==64 or ioFault==1 or supplyFault==1 or supplyAlarm==1 or mcuFault==1 or mcuAlarm==1 or igbtOvertemp==1) then
 WR.setProp(dev, "INVERTER_Alarm", 1)
else
 WR.setProp(dev, "INVERTER_Alarm", 0)
end

----------------------- Logic for INVERTER Alarm Start-------------------------

------------------------ CUF Calculation Start --------------------------------

local cuf = ((eaeDay) / ((settings.INVERTER[devS].dcCapacity / 1000) * 24)) * 100
if is_nan(cuf) then cuf = 0 end
WR.setProp(dev, "CUF", cuf)

------------------------ CUF Calculation End -----------------------------------

------------------------ Efficiency Calculation Start --------------------------

local invEff = (pac / pdc)
WR.setProp(dev, "INV_EFFICIENCY", invEff)

------------------------ Efficiency Calculation End ----------------------------

--------------------- INVERTER Availability Calculation Start ----------------
--[[
if ((pvSt == 3) or (pvSt == 4) or (pac > settings.INV[devS].operationTimePowerSetpoint)) then
 opTime[dev].tson = opTime[dev].tson + (now - opTime[dev].ts)
 if (startTime[dev].ts == 0) then
  startTime[dev].ts = ((hour * 60 * 60) + (min * 60) + sec)
 end
 stopTime[dev].againStart = 1
elseif (((pvSt == 1) or (pvSt == 2) or (pvSt == 6) or (pac <= 0)) and (startTime[dev].ts ~= 0) and ((stopTime[dev].againStart == 1) or (stopTime[dev].ts == 0))) then
 stopTime[dev].ts = ((hour * 60 * 60) + (min * 60) + sec)
 stopTime[dev].againStart = 0
end
opTime[dev].ts = now
WR.setProp(dev, "OPERATIONAL_TIME", opTime[dev].tson)
WR.setProp(dev, "START_TIME", startTime[dev].ts)
WR.setProp(dev, "STOP_TIME", stopTime[dev].ts)
]]--

if (radiation > settings.INVERTER[devS].ProductionTimeRadSetpoint) then
 productionTime[dev].tson = productionTime[dev].tson + (now - productionTime[dev].ts)
end
productionTime[dev].ts = now
WR.setProp(dev, "PRODUCTION_TIME", productionTime[dev].tson)

local invavailability = ((opTime[dev].tson) / (productionTime[dev].tson) * 100)
if not((is_nan(invavailability)) or (invavailability == 0) or (invavailability < 100)) then
WR.setProp(dev, "INV_AVAILABILITY", ((opTime[dev].tson) / (productionTime[dev].tson) * 100))
elseif (invavailability > 100) then
WR.setProp(dev, "INV_AVAILABILITY", 100)
else
WR.setProp(dev, "INV_AVAILABILITY", WR.read(dev, "INV_AVAILABILITY"))
end

--------------------- Plant Availability Calculation End ------------------

------------------------ PR Calculation Start ---------------------------------

invAlarm = invAlarm or {}
invAlarm[dev] = invAlarm[dev] or {tsp=now}

--print("now = ",now)
--print("invAlarm["..dev.."].tsp = ",invAlarm[dev].tsp)

local prNow = 0
local prAlarm = 0
if ((radiation > settings.INVERTER[devS].prRealRadSetpoint) and (pac >= 0)) then
 prNow = ((pacAvg5 / settings.INVERTER[devS].dcCapacity) / (radiation / 1000)) * 100
 if is_nan(prNow) then prNow = 0 end
 if (prNow > 100) then prNow = pr end
 if ((pr < settings.INVERTER[devS].prAlarmSetpoint) and (radiation > settings.INVERTER[devS].prAlarmRadSetpoint)) then
  prAlarm = 1
 end
end
if (prAlarm == 1) then
 if ((now-invAlarm[dev].tsp) < settings.INVERTER[devS].prAlarmTimeSetpoint) then prAlarm  = 0 end
else
 invAlarm[dev].tsp = now
 prAlarm = 0
end
local prDayNow = (((eaeDay * 1000) / settings.INVERTER[devS].dcCapacity) / radiationCum) * 100
if is_nan(prDayNow) then prDayNow = prDay end
if ((radiation > settings.INVERTER[devS].prMinRadSetpoint) and ((pr < prMin) or (prMin == 0))) then
 prMin = pr
end
WR.setProp(dev, "PR", prNow)
WR.setProp(dev, "PR_MAX", pr)
WR.setProp(dev, "PR_MIN", prMin)
WR.setProp(dev, "PR_Alarm", prAlarm)
WR.setProp(dev, "PR_DAY", prDayNow)

------------------------ PR Calculation End -----------------------------------

