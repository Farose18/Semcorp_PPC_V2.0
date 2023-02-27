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
local datw = os.date ("%u")
--print("datw=", datw)

------------------------ Define Function Start --------------------------------

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

-- function to log events in file
function logEvent(file, msg)
 file = io.open(file,"a")
 now = socket.gettime()
 if file~=nil then
  file:write(os.date("%a %b %d %Y %X",currTime)..":"..string.sub(now*1000, 11, 13).." "..msg.."\n")
 end
 file:close()
end

function logCsv(file, msg)
 file1 = io.open(file,"r")
 if file1 == nil then
  fileName = filePath.."/"..anlagen_id.."_ZE_LOG_IM21_"..string.sub(now, 1, 10).."_21.csv"
  file = fileName
  file1 = io.open(file,"a")
  file1:write(anlagen_id..",SN:ZE_LOG_IMC21,ZE_LOG,0.0.0.0,3".."\n")
  -- log format ts, dg01Pac, dg02Pac, pvPac, pacLimit, gridConnSt, pacLimitSet, gridConnSet
  file1:write("TS,CASE,ZE_PAC,ZE_QAC,ZE_PF,ZE_UAC,ZE_FAC,PV_PAC,PV_QAC,PAC_LIMIT,QAC_LIMIT,PAC_LIMIT_WRITE,QAC_LIMIT_WRITE".."\n")
 end
 file1:close()

 file = io.open(file,"a")
 now = socket.gettime()
 if file~=nil then
  file:write(string.sub(now, 1, 10)..","..msg.."\n")
 end
 file:close()
end

function logCsvZE(file, msg)
 file2 = io.open(file,"r")
 if file2 == nil then
  fileNameZE = filePath.."/"..anlagen_id.."_ZE_LOG_IM22_"..string.sub(now, 1, 10).."_22.csv"
  file = fileNameZE
  file2 = io.open(file,"a")
  file2:write(anlagen_id..",SN:ZE_LOG_IMC22,ZE_LOG,0.0.0.0,4".."\n")
  -- log format ts, dg01Pac, dg02Pac, pvPac, pacLimit, gridConnSt, pacLimitSet, gridConnSet
  file2:write("TS,CASE,ZE_PAC,ZE_QAC,ZE_PF,ZE_UAC,ZE_FAC,PV_PAC,PV_QAC,PAC_LIMIT,QAC_LIMIT,PAC_LIMIT_WRITE,QAC_LIMIT_WRITE".."\n")
 end
 file2:close()

 file = io.open(file,"a")
 now = socket.gettime()
 if file~=nil then
  file:write(string.sub(now, 1, 10)..","..msg.."\n")
 end
 file:close()
end

function logCsvZEU(file, msg)
 file3 = io.open(file,"r")
 if file3 == nil then
  fileNameZEU = filePath.."/"..anlagen_id.."_ZE_LOG_IM23_"..string.sub(now, 1, 10).."_23.csv"
  file = fileNameZEU
  file3 = io.open(file,"a")
  file3:write(anlagen_id..",SN:ZE_LOG_IMC23,ZE_LOG,0.0.0.0,5".."\n")
  -- log format ts, dg01Pac, dg02Pac, pvPac, pacLimit, gridConnSt, pacLimitSet, gridConnSet
  file3:write("TS,CASE,ZE_PAC,ZE_QAC,ZE_PF,ZE_UAC,ZE_FAC,PV_PAC,PV_QAC,PAC_LIMIT,QAC_LIMIT,PAC_LIMIT_WRITE,QAC_LIMIT_WRITE".."\n")
 end
 file3:close()

 file = io.open(file,"a")
 now = socket.gettime()
 if file~=nil then
  file:write(string.sub(now, 1, 10)..","..msg.."\n")
 end
 file:close()
end

function logCsvZEF(file, msg)
   file4 = io.open(file,"r")
   if file4 == nil then
      fileNameZEF = filePath.."/"..anlagen_id.."_ZE_LOG_IM24_"..string.sub(now, 1, 10).."_24.csv"
      file = fileNameZEF
      file4 = io.open(file,"a")
      file4:write(anlagen_id..",SN:ZE_LOG_IMC24,ZE_LOG,0.0.0.0,4".."\n")
      -- log format ts, dg01Pac, dg02Pac, pvPac, pacLimit, gridConnSt, pacLimitSet, gridConnSet
      file4:write("TS,CASE,ZE_PAC,ZE_QAC,ZE_PF,ZE_UAC,ZE_FAC,PV_PAC,PV_QAC,PAC_LIMIT,QAC_LIMIT,PAC_LIMIT_WRITE,QAC_LIMIT_WRITE".."\n")
   end
   file4:close()

   file = io.open(file,"a")
   now = socket.gettime()
   if file~=nil then
      file:write(string.sub(now, 1, 10)..","..msg.."\n")
   end
   file:close()
end

function logCsvZEPF(file, msg)
   file5 = io.open(file,"r")
   if file5 == nil then
      fileNameZEPF = filePath.."/"..anlagen_id.."_ZE_LOG_IM25_"..string.sub(now, 1, 10).."_25.csv"
      file = fileNameZEPF
      file5 = io.open(file,"a")
      file5:write(anlagen_id..",SN:ZE_LOG_IMC25,ZE_LOG,0.0.0.0,5".."\n")
      -- log format ts, dg01Pac, dg02Pac, pvPac, pacLimit, gridConnSt, pacLimitSet, gridConnSet
      file5:write("TS,CASE,ZE_PAC,ZE_QAC,ZE_PF,ZE_UAC,ZE_FAC,PV_PAC,PV_QAC,PAC_LIMIT,QAC_LIMIT,PAC_LIMIT_WRITE,QAC_LIMIT_WRITE".."\n")
   end
   file5:close()

   file = io.open(file,"a")
   now = socket.gettime()
   if file~=nil then
      file:write(string.sub(now, 1, 10)..","..msg.."\n")
   end
   file:close()
end
------------------------ Define Function End ----------------------------------

-------------------------- Read Setpoints Start -------------------------------

if not(settings) then
 --print ("Inside file loading")
 settingsConfig = assert(io.open("/mnt/jffs2/solar/modbus/Settings.txt", "r"))
 settingsJson = settingsConfig:read("*all")
 settings = cjson.decode(settingsJson)
 settingsConfig:close()
 filePath = "/mnt/jffs2/dglog"
 fileName = filePath.."/"..anlagen_id.."_ZE_LOG_IM21_"..string.sub(now, 1, 10).."_21.csv"
 fileNameZE = filePath.."/"..anlagen_id.."_ZE_LOG_IM22_"..string.sub(now, 1, 10).."_22.csv"
 fileNameZEU = filePath.."/"..anlagen_id.."_ZE_LOG_IM23_"..string.sub(now, 1, 10).."_23.csv"
 fileNameZEF = filePath.."/"..anlagen_id.."_ZE_LOG_IM24_"..string.sub(now, 1, 10).."_24.csv"
 fileNameZEPF = filePath.."/"..anlagen_id.."_ZE_LOG_IM25_"..string.sub(now, 1, 10).."_25.csv"
 filePackts = now
 dgCtlDev = {}
 lastDev = "SN:B03_INV01"
 caseReset = 5
 case1ZE = caseReset
 case2ZE = caseReset
 case3ZE = caseReset
 case4ZE = caseReset
 case5ZE = caseReset

 case1ZEQ = caseReset
 case2ZEQ = caseReset
 case3ZEQ = caseReset
 case4ZEQ = caseReset
 case5ZEQ = caseReset

 case1ZEU = caseReset
 case2ZEU = caseReset
 case3ZEU = caseReset
 case4ZEU = caseReset
 case5ZEU = caseReset
 case6ZEU = caseReset
 case7ZEU = caseReset
 
 case1ZEF = caseReset
 case2ZEF = caseReset
 case3ZEF = caseReset
 case4ZEF = caseReset
 case5ZEF = caseReset
 case6ZEF = caseReset
 case7ZEF = caseReset
 
 case1ZEPF = caseReset
 case2ZEPF = caseReset
 case3ZEPF = caseReset
 case4ZEPF = caseReset
 case5ZEPF = caseReset
end

if not(settings.INVERTER[devS].dcCapacity and settings.INVERTER[devS].prAlarmSetpoint and settings.INVERTER[devS].prAlarmRadSetpoint and settings.INVERTER[devS].prAlarmTimeSetpoint and settings.INVERTER[devS].prRealRadSetpoint and settings.INVERTER[devS].prMinRadSetpoint and settings.INVERTER[devS].igbtHighTempSetpoint and settings.INVERTER[devS].gridVoltSetpoint) then
 --print ("Data loading")
 settings.INVERTER[devS].dcCapacity = settings.INVERTER[devS].dcCapacity or settings.INVERTER.dcCapacity or 1073.6

 tunePStep = settings.PLANT.tunePStep or 1
 tuneStep = settings.PLANT.tuneStep or 1
 zeIacMaxCmd = settings.PLANT.zeIacMaxCmd or 1370
 zeIacSetCmd = settings.PLANT.zeIacSetCmd or 1350
 zePfMaxCmd = settings.PLANT.zePfMaxCmd or 0.95
 zePfSetCmd = settings.PLANT.zePfSetCmd or 0.96

 pacLimitResetCnt = 0

 --totalInverters = settings.PLANT.totalInverters or 2
 --totalInverters = settings.PLANT.totalInvertersAcCapacity or 2
 --totalInverters = settings.PLANT.totalInvertersQacCapacity or 2

 --zeMinLoad = settings.PLANT.zeMinLoad or -90
 --zeCriticalLoad = settings.PLANT.zeCriticalLoad or 100
 --zeThreshold = 5 --settings.PLANT.zeThreshold or 5

 --zePMinLoad = settings.PLANT.zePMinLoad or 10
 --zePCriticalLoad = settings.PLANT.zePCriticalLoad or 9
 --zePThreshold = 5 --settings.PLANT.zePThreshold or 5
 --zeUThreshold = 3 --settings.PLANT.zeUThreshold or 5

 dgCtlDev = dgCtlDev or {}
 dgCtlDev[dev] = dev
 CHECKDATATIME(dev, now, "PR_DAY")
end

--------------------------- Read setpoints End --------------------------------

------------------------- Pack CSV For Portal Start ---------------------------

if (now > (filePackts + 300)) then
 os.execute("cd "..filePath.."; for f in *.csv; do mv -- \"$f\" \"${f%}.unsent\"; done")
 fileName = filePath.."/"..anlagen_id.."_ZE_LOG_IM21_"..string.sub(now, 1, 10).."_21.csv"
 fileNameZE = filePath.."/"..anlagen_id.."_ZE_LOG_IM22_"..string.sub(now, 1, 10).."_22.csv"
 fileNameZEU = filePath.."/"..anlagen_id.."_ZE_LOG_IM23_"..string.sub(now, 1, 10).."_23.csv"
 fileNameZEF = filePath.."/"..anlagen_id.."_ZE_LOG_IM24_"..string.sub(now, 1, 10).."_24.csv"
 fileNameZEPF = filePath.."/"..anlagen_id.."_ZE_LOG_IM25_"..string.sub(now, 1, 10).."_25.csv"
 filePackts = now
end

-------------------------- Pack CSV For Portal End ----------------------------

---------------------- Reset DG & ZE case Start -------------------------------

if (dev == lastDev) then
 case1ZE = caseReset
 case2ZE = caseReset
 case3ZE = caseReset
 case4ZE = caseReset
 case5ZE = caseReset

 case1ZEQ = caseReset
 case2ZEQ = caseReset
 case3ZEQ = caseReset
 case4ZEQ = caseReset
 case5ZEQ = caseReset

 case1ZEU = caseReset
 case2ZEU = caseReset
 case3ZEU = caseReset
 case4ZEU = caseReset
 case5ZEU = caseReset
 case6ZEU = caseReset
 case7ZEU = caseReset
 
 case1ZEF = caseReset
 case2ZEF = caseReset
 case3ZEF = caseReset
 case4ZEF = caseReset
 case5ZEF = caseReset
 case6ZEF = caseReset
 case7ZEF = caseReset
 
 case1ZEPF = caseReset
 case2ZEPF = caseReset
 case3ZEPF = caseReset
 case4ZEPF = caseReset
 case5ZEPF = caseReset
end

----------------------- Reset DG & ZE case End --------------------------------

---------------------- COMMUNICATION STATUS Start -----------------------------

if WR.isOnline(dev) then
 WR.setProp(dev, "COMMUNICATION_STATUS", 0)
else
 WR.setProp(dev, "COMMUNICATION_STATUS", 1)
end

---------------------- COMMUNICATION STATUS End -------------------------------

--[[----------------- ZE & DG Logic Main Loop START ------------------------------

dgCtlDev = dgCtlDev or {}
local pvPacM = 0
for devV in pairs(dgCtlDev) do
 local invPacM = WR.read(devV, "PAC")
 if not(is_nan(invPacM)) then pvPacM = pvPacM + invPacM end
end
local dg01PacM = 0 --WR.read(dev, "DG01_PAC")
local dg02PacM = 0 --WR.read(dev, "DG02_PAC")
local zePacM = WR.read(dev, "TOTAL_ZE_PAC")
local pacLimitMWrite = "PAC_LIMIT"
local gridConnMWrite = "GRID_CONNECT"
local cmdEnableMWrite = "CMD_ENABLE"

if ((is_nan(dg01PacM)) or (is_nan(dg02PacM)) or (is_nan(zePacM))) then
 dg01PacM = ""
 dg02PacM = ""
 zePacM = ""
 if (pacLimitResetCnt > 4) then
  local pacLimitM = WR.read(dev, "PAC_LIMIT")
  local gridConnM = 207 --WR.read(dev, "GRID_CONNECT")
  if (gridConnM == 206) then
   --logCsv(fileName,"1".."INTOLOG3".."")
   for devV in pairs(dgCtlDev) do
    --WR.writeHexOpts(dev, cmdEnableMWrite, bit.tohex(1,4),0x6)
    WR.writeHexOpts(devV, pacLimitMWrite, bit.tohex(0,4),0x6)
   end
   logCsv(fileName,"0.1"..","..dg01PacM..","..dg02PacM..","..pvPacM..","..pacLimitM..","..gridConnM..",".."0"..",".."1")
  elseif (pacLimitM >= 0) then
   for devV in pairs(dgCtlDev) do
    --WR.writeHexOpts(dev, cmdEnableMWrite, bit.tohex(1,4),0x6)
      WR.writeHexOpts(devV, pacLimitMWrite, bit.tohex(0,4),0x6)
   end
   logCsv(fileName,"0.2"..","..dg01PacM..","..dg02PacM..","..pvPacM..","..pacLimitM..","..gridConnM..",".."0"..",".."")
  end
  pacLimitResetCnt = 0
 else
  pacLimitResetCnt = pacLimitResetCnt + 1
 end
end

-------------------- ZE & DG Logic Main Loop END -----------------------------]]--

-------------------------- ZE Logic START ---------------------------------------

if (dev == lastDev) then
 if ampZE01FUHF == nil then
  -- Initialise FUH Function to Control PV Power
  ampZE01FUHF =
  function(dev)
    local pacMaxSetCmd = (WR.read(dev, "PAC_MAX_SET_CMD")/1.2)
    local qacMaxSetCmd = (WR.read(dev, "QAC_MAX_SET_CMD")/1.2)
    local blkPacMaxCmd = (WR.read(dev, "BLOCK_PAC_MAX_CMD")/1.2)
    local blkQacMaxCmd = (WR.read(dev, "BLOCK_QAC_MAX_CMD")/1.2)

    local pacULSetCmd = WR.read(dev, "PAC_UL_SET_CMD")
    local pacLLSetCmd = WR.read(dev, "PAC_LL_SET_CMD")
    local pacGRSetCmd = WR.read(dev, "PAC_GR_SET_CMD")
    local pacTuneStCmd = WR.read(dev, "PAC_TUNE_ST_CONST_CMD")
    local pacIncConstCmd = WR.read(dev, "PAC_INCR_CONST_CMD")
    local pacDecConstCmd = WR.read(dev, "PAC_DECR_CONST_CMD")

    local qacULSetCmd = WR.read(dev, "QAC_UL_SET_CMD")
    local qacLLSetCmd = WR.read(dev, "QAC_LL_SET_CMD")
    local qacGRSetCmd = WR.read(dev, "QAC_GR_SET_CMD")
    local qacTuneStCmd = WR.read(dev, "QAC_TUNE_ST_CONST_CMD")
    local qacIncConstCmd = WR.read(dev, "QAC_INCR_CONST_CMD")
    local qacDecConstCmd = WR.read(dev, "QAC_DECR_CONST_CMD")

    local quULSetCmd = WR.read(dev, "QU_UL_SET_CMD")
    local quLLSetCmd = WR.read(dev, "QU_LL_SET_CMD")
    local quGRSetCmd = WR.read(dev, "QU_GR_SET_CMD")
    local quTuneStCmd = WR.read(dev, "QU_TUNE_ST_CONST_CMD")
    local quIncConstCmd = WR.read(dev, "QU_INCR_CONST_CMD")
    local quDecConstCmd = WR.read(dev, "QU_DECR_CONST_CMD")
	
	local pfULSetCmd = WR.read(dev, "PF_UL_SET_CMD")
    local pfLLSetCmd = WR.read(dev, "PF_LL_SET_CMD")
	
	local facULSetCmd = WR.read(dev, "FAC_UL_SET_CMD")
    local facLLSetCmd = WR.read(dev, "FAC_LL_SET_CMD")
    local facCULSetCmd = WR.read(dev, "FAC_CUL_SET_CMD")
    local facCLLSetCmd = WR.read(dev, "FAC_CLL_SET_CMD")
    local facGRSetCmd = WR.read(dev, "FAC_GR_SET_CMD")
    local facTuneStCmd = WR.read(dev, "FAC_TUNE_ST_CONST_CMD")
    local facIncConstCmd = WR.read(dev, "FAC_INCR_CONST_CMD")
    local facDecConstCmd = WR.read(dev, "FAC_DECR_CONST_CMD")	

    local pacOnOffCmd = WR.read(dev, "PAC_ON_OFF_CMD")
    local qacOnOffCmd = WR.read(dev, "QAC_ON_OFF_CMD")
    local uacOnOffCmd = WR.read(dev, "UAC_ON_OFF_CMD")
    local pfOnOffCmd = WR.read(dev, "PF_ON_OFF_CMD")
    local facOnOffCmd = WR.read(dev, "FAC_ON_OFF_CMD") --facOnOffCmd
    local fOnOffCmd = WR.read(dev, "F_ON_OFF_CMD")
    local fDroopCmd = WR.read(dev, "F_DROOP_SET_CMD")

    if is_nan(pacMaxSetCmd) then pacMaxSetCmd = 6750 end
    if is_nan(qacMaxSetCmd) then qacMaxSetCmd = 4050 end
    if is_nan(blkPacMaxCmd) then blkPacMaxCmd = 6750 end
    if is_nan(blkQacMaxCmd) then blkQacMaxCmd = 4050 end

    if is_nan(pacULSetCmd) then pacULSetCmd = 2 end
    if is_nan(pacLLSetCmd) then pacLLSetCmd = 4 end
    if is_nan(pacGRSetCmd) then pacGRSetCmd = 5 end
    if is_nan(pacTuneStCmd) then pacTuneStCmd = 1 end
    if is_nan(pacIncConstCmd) then pacIncConstCmd = 1 end
    if is_nan(pacDecConstCmd) then pacDecConstCmd = 1 end

    if is_nan(qacULSetCmd) then qacULSetCmd = 2 end
    if is_nan(qacLLSetCmd) then qacLLSetCmd = 4 end
    if is_nan(qacGRSetCmd) then qacGRSetCmd = 5 end
    if is_nan(qacTuneStCmd) then qacTuneStCmd = 1 end
    if is_nan(qacIncConstCmd) then qacIncConstCmd = 1 end
    if is_nan(qacDecConstCmd) then qacDecConstCmd = 1 end


	if is_nan(pfULSetCmd) then pfULSetCmd = 0.004 end
    if is_nan(pfLLSetCmd) then pfLLSetCmd = 0.004 end
	
    if is_nan(quULSetCmd) then quULSetCmd = 3 end
    if is_nan(quLLSetCmd) then quLLSetCmd = 1 end
    if is_nan(quGRSetCmd) then quGRSetCmd = 0 end
    if is_nan(quTuneStCmd) then quTuneStCmd = 1 end
    if is_nan(quIncConstCmd) then quIncConstCmd = 1 end
    if is_nan(quDecConstCmd) then quDecConstCmd = 1 end

	if is_nan(facULSetCmd) then facULSetCmd = 0.03 end
    if is_nan(facLLSetCmd) then facLLSetCmd = 0.3 end
    if is_nan(facCULSetCmd) then facCULSetCmd = 2.0 end
    if is_nan(facCLLSetCmd) then facCLLSetCmd = 2.5 end
    if is_nan(facGRSetCmd) then facGRSetCmd = 0 end
    if is_nan(facTuneStCmd) then facTuneStCmd = 100 end
    if is_nan(facIncConstCmd) then facIncConstCmd = 1 end
    if is_nan(facDecConstCmd) then facDecConstCmd = 1 end
    if is_nan(fDroopCmd) then fDroopCmd = 3 end

   local zePac = (WR.read(dev, "ZE_PAC") * (6.750/(21.150))) * 1000
   if is_nan(zePac) then zePac = 6750 end

   local zeUac = WR.read(dev, "ZE_UAC") * 1000
   if is_nan(zeUac) then zeUac = 33000 end
   
   local zeFac = WR.read(dev, "ZE_FAC") -- zeFac
   if is_nan(zeFac) then zeFac = 50 end   

   local PowSelCmd = WR.read(dev, "SEL_PC_CMD")

   local zePMinLoad = (WR.read(dev, "PAC_PC_CMD") * (6.750/(21.150))) * 1000
   local zePCriticalLoad = zePMinLoad - ((pacLLSetCmd / 100) * blkPacMaxCmd)

   local zeMinLoad = (WR.read(dev, "QAC_PC_CMD") * (6.750/(21.150))) * 1000
   local zeCriticalLoad = zeMinLoad - ((qacLLSetCmd / 100) * blkQacMaxCmd)

   local zePFMinLoad = (WR.read(dev, "PF_PC_CMD"))
   --local zePFCriticalLoad = zePFMinLoad - PFLLSetCmd
   
   local zeUMinLoad = WR.read(dev, "UAC_PC_CMD") * 1000
   local zeUCriticalLoad = zeUMinLoad - ((quLLSetCmd / 100) * zeUMinLoad)

   local zeFMinLoad = WR.read(dev, "FAC_PC_CMD")
   local zeFCriticalLoad = facLLSetCmd  ----10% to 100% reduction in active power
   local zeFUCriticalLoad = facCULSetCmd
   local zeFLCriticalLoad = facCLLSetCmd

   zeThreshold  = (qacULSetCmd / 100) * blkQacMaxCmd
   zePThreshold = (pacULSetCmd / 100) * blkPacMaxCmd
   zeUThreshold = (quULSetCmd / 100) * zeUMinLoad
   zePFThreshold  = pfULSetCmd
   zeFThreshold  = facULSetCmd  ----Droop Characteristics 3% to 6%
   

   local zeIac = WR.read(dev, "ZE_IAC")
   --print (zeIac)
   if is_nan(zeIac) then zeIac = 0 end

--[[
   if (zeIac > 215) then
   local maxPacLimit = (WR.read(dev, "PAC_LIMIT"))
   local pacMaxSetCmd = maxPacLimit
   else
   local pacMaxSetCmd = WR.read(dev, "PAC_MAX_SET_CMD")
   end
   --if (zeIac > 215) then
    --local pacMaxSetCmd = oldPacLimit
   --end
]]--

   local maxPacLimit = (WR.read(dev, "PAC_LIMIT"))
   if is_nan(maxPacLimit) then maxPacLimit = 2 end
   local minPacLimit = maxPacLimit
   for devV in pairs(dgCtlDev) do
    local invPacLimit = (WR.read(dev, "PAC_LIMIT"))
    if ((not(is_nan(invPacLimit))) and (invPacLimit > maxPacLimit)) then maxPacLimit = invPacLimit end
    if ((not(is_nan(invPacLimit))) and (invPacLimit < minPacLimit)) then minPacLimit = invPacLimit end
   end
   local pacLimit = maxPacLimit
   local oldPacLimit = pacLimit
   local pacLimitW = pacLimit
   local gridConn = 207 --WR.read(dev, "GRID_CONNECT")
   local pacLimitWrite = "PAC_LIMIT"
   local gridConnWrite = "GRID_CONNECT"
   local olddelF = delF

   --local dg02Pac = ""
   local pvPac = 0
   for devV in pairs(dgCtlDev) do
    local invPac = WR.read(devV, "PAC")
    if not(is_nan(invPac)) then pvPac = pvPac + invPac end
   end

   local zeQac = ((WR.read(dev, "ZE_QAC")) * (6.750/(21.150))) * 1000
   if is_nan(zeQac) then zeQac = 0 end

   local zePf = WR.read(dev, "ZE_PF")
   if is_nan(zePf) then zePf = 1 end
--[[
   if (zePf >= -0.96 or zePf <= 0.96) then
    local maxQacLimit = (WR.read(dev, "QAC_KVAR_LIMIT"))
    local qacMaxSetCmd = maxQacLimit
   else
    local qacMaxSetCmd = WR.read(dev, "QAC_MAX_SET_CMD")
   end
]]--
   local maxQacLimit = (WR.read(dev, "QAC_KVAR_LIMIT") / qacMaxSetCmd) * 100
   if is_nan(maxQacLimit) then maxQacLimit = 0 end
   local minQacLimit = maxQacLimit
   for devV in pairs(dgCtlDev) do
    local invQacLimit = (WR.read(dev, "QAC_KVAR_LIMIT") / qacMaxSetCmd) * 100
    if ((not(is_nan(invQacLimit))) and (invQacLimit > maxQacLimit)) then maxQacLimit = invQacLimit end
    if ((not(is_nan(invQacLimit))) and (invQacLimit < minQacLimit)) then minQacLimit = invQacLimit end
   end
   local qacLimit = maxQacLimit
   local oldQacLimit = qacLimit
   local qacLimitW = qacLimit
   local oldQacLimitW = qacLimit
   local pvQacW = qacLimit
   local zeQacW = zeQac
   local gridConn = 207 --WR.read(dev, "GRID_CONNECT")
   local qacLimitWrite = "QAC_KVAR_LIMIT"
   local gridConnWrite = "GRID_CONNECT"

   local inv5_Com = WR.read("SN:B03_INV01", "COMMUNICATION_STATUS")
   --local inv6_Com = WR.read("SN:B03_INV02", "COMMUNICATION_STATUS")


   local inv5_Pac = WR.read("SN:B03_INV01", "PAC")
   --local inv6_Pac = WR.read("SN:B03_INV02", "PAC")


   local totalInverters = 0
   if ((inv5_Com < 1) and (inv5_Pac > 0)) then totalInverters = totalInverters + 1 end
   --if ((inv6_Com < 1) and (inv6_Pac > 0)) then totalInverters = totalInverters + 1 end


   WR.setProp("SN:B03_INV01", "TOTAL_INV_ONLINE", totalInverters)
   --WR.setProp("SN:B03_INV02", "TOTAL_INV_ONLINE", totalInverters)

   local totalQInverters = 0
   if (inv5_Com < 1)  then totalQInverters = totalQInverters + 1 end
   --if (inv6_Com < 1)  then totalQInverters = totalQInverters + 1 end


   WR.setProp("SN:B03_INV01", "TOTAL_INV_ONLINE_Q", totalQInverters)
   --WR.setProp("SN:B03_INV02", "TOTAL_INV_ONLINE_Q", totalQInverters)
   
   --[[local pvQacmargin1 = 0
   for devV in pairs(dgCtlDev) do
    local invQacmargin = WR.read(dev, "QAC_ZERO_MARGIN")
    if not(is_nan(invQacmargin)) then pvQacmargin1 = pvQacmargin1 + invQacmargin end
   end
   local pvQacmargin = (pvQacmargin1 / totalInverters)--]]--
   
   -------- Reactive Power Selection Calculation Start ------------------

    for devV in pairs(dgCtlDev) do
	 local qacRefSelCmd = WR.read(devV, "QAC_REF_SEL_CMD")
       if WR.isOnline(devV) then
	    WR.setProp(devV, "QAC_REF_SEL", qacRefSelCmd)
       end
    end
   -------- Reactive Power Selection Calculation End ------------------
  

    -------- Reactive Power Selection Initialization Start ------------------

    for devV in pairs(dgCtlDev) do
     local qacRefSelCmd = WR.read(devV, "QAC_REF_SEL")
     local qacRefSelCmdWrite = "QAC_REF_SEL"
      if (qacRefSelCmd ~= 2) then
       if WR.isOnline(devV) then
        WR.writeHexOpts(devV, qacRefSelCmdWrite, bit.tohex(2,4),0x6)
        WR.writeHexOpts(devV, qacLimitWrite, bit.tohex(0,4),0x6)
       end
      end
    end
   -------- Reactive Power Selection Initialization End ------------------

   --[[------ QMode Initialization Start -----------------------------------

   local qmodeEnableCmd = WR.read(dev, "QMODE_ENABLE")
   local qmodeEnableCmdWrite = "QMODE_ENABLE"
   if ((qmodeEnableCmd ~= 2) and (pvQacmargin > 1)) then
    for devV in pairs(dgCtlDev) do
    if WR.isOnline(devV) then
    WR.writeHexOpts(devV, qmodeEnableCmdWrite, bit.tohex(2,4),0x6)
    end
    end
   end
   -------- QMode Initialization End ----------------]]--

   --local dg02Pac = ""
   local pvQac = 0
   for devV in pairs(dgCtlDev) do
    local invQac = WR.read(devV, "QAC")
    if not(is_nan(invQac)) then pvQac = pvQac + invQac end
   end
   if pvQac > 1 then tuneStep = qacTuneStCmd
   elseif pvQac < -1 then tuneStep = qacTuneStCmd end
   -- log format ts, dg01Pac, dg02Pac, pvPac, pacLimit, gridConnSt, pacLimitSet, gridConnSet
   -- logCsv("fileName","case"..","..dg01Pac..","..dg02Pac..","..pvPac..","..oldPacLimit..","..gridConn..","..pacLimit..",""")
   -- log format ts, dg01Pac, dg02Pac, pvPac, pacLimit, gridConnSt, pacLimitSet, gridConnSet
   -- logCsv("fileName","case"..","..dg01Pac..","..dg02Pac..","..pvPac..","..oldPacLimit..","..gridConn..","..pacLimit..",""")
   if ((not(is_nan(zePac))) and (PowSelCmd == 1) and (totalInverters > 0) and (fOnOffCmd == 1) and (pacOnOffCmd == 1)) then
    -- case 1 : ZE meter < critical load
    if ((zePac >= (zePMinLoad + zePThreshold)) and (maxPacLimit > 0) and (zeIac < zeIacSetCmd)) then
      pacLimit = (((pvPac + (zePMinLoad + zePThreshold - zePac)) / totalInverters) / ((100- pacGRSetCmd) / 100))
      if ((zePMinLoad / totalInverters) > pacLimit) then pacLimit = (maxPacLimit) end -- Gain control line added
     if (pacLimit <= 2) then pacLimit = 2 end
     pacLimit = tonumber(string.format("%.0f", pacLimit))
     oldPacLimit = tonumber(string.format("%.0f", (maxPacLimit)))
     if (oldPacLimit <= pacLimit) then
      pacLimit = oldPacLimit - tonumber(string.format("%.0f", (pacDecConstCmd * pacMaxSetCmd / 1000)))
      if (case1ZE >= caseReset) then
       case1ZE = 0
       for devV in pairs(dgCtlDev) do
        if WR.isOnline(devV) then
         if (pacLimit <= 2) then pacLimit = 2 end
         pacLimit = tonumber(string.format("%.0f", pacLimit))
         WR.writeHexOpts(devV, pacLimitWrite, bit.tohex(pacLimit,4),0x6)
        end
       end
       logCsv(fileName,"1.1.0"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
      else
       case1ZE = case1ZE + 1
       logCsv(fileName,"1.1.1"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
     end
     else
      if (case1ZE >= caseReset) then
       case1ZE = 0
       for devV in pairs(dgCtlDev) do
        if WR.isOnline(devV) then
         if (pacLimit <= 2) then pacLimit = 2 end
         pacLimit = tonumber(string.format("%.0f", pacLimit))
         WR.writeHexOpts(devV, pacLimitWrite, bit.tohex(pacLimit,4),0x6)
        end
       end
       logCsv(fileName,"1.1.2"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
      else
       case1ZE = case1ZE + 1
       logCsv(fileName,"1.1.3"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
      end
     end
    -- case 2 : ZE meter > 10  force up
    elseif ((zePac <= zePCriticalLoad) and (minPacLimit < pacMaxSetCmd) and (zeIac < zeIacSetCmd)) then
     pacLimit = (((pvPac - (zePac - zePCriticalLoad)) / totalInverters) * ((100- pacGRSetCmd) / 100))        ---- Formula updated with minload
     if ((zePMinLoad / totalInverters) < pacLimit) then pacLimit = (minPacLimit) end----Gain control line added
     if (pacLimit > pacMaxSetCmd) then pacLimit = pacMaxSetCmd end
     pacLimit = tonumber(string.format("%.0f", pacLimit))
     oldPacLimit = tonumber(string.format("%.0f", (minPacLimit)))
     if (oldPacLimit >= pacLimit) then
      pacLimit = oldPacLimit + tonumber(string.format("%.0f", (pacIncConstCmd * pacMaxSetCmd / 1000)))
      if (case2ZE >= caseReset) then
       case3ZE = 0
       for devV in pairs(dgCtlDev) do
        if WR.isOnline(devV) then
         if (pacLimit <= 2) then pacLimit = 2 end
         pacLimit = tonumber(string.format("%.0f", pacLimit))
         WR.writeHexOpts(devV, pacLimitWrite, bit.tohex(pacLimit,4),0x6)
        end
       end
       logCsv(fileName,"1.2.0"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
      else
       case2ZE = case2ZE + 1
       logCsv(fileName,"1.2.1"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
      end
     else
      if (case2ZE >= caseReset) then
       case2ZE = 0
       for devV in pairs(dgCtlDev) do
        if WR.isOnline(devV) then
         if (pacLimit <= 2) then pacLimit = 2 end
         pacLimit = tonumber(string.format("%.0f", pacLimit))
         WR.writeHexOpts(devV, pacLimitWrite, bit.tohex(pacLimit,4),0x6)
        end
       end
       logCsv(fileName,"1.2.2"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
      else
       case2ZE = case2ZE + 1
       logCsv(fileName,"1.2.3"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
      end
     end
    -- case 3 : ZE meter > minload & ZE meter < 10  tune up
    elseif ((zePac <= zePMinLoad - zePThreshold) and (maxPacLimit < pacMaxSetCmd) and (zeIac < zeIacSetCmd)) then         ----less than changed to Greater than
     pacLimit = tonumber(minPacLimit + (pacTuneStCmd * pacMaxSetCmd / 1000))
     pacLimit = tonumber(string.format("%.0f", pacLimit))
     if (pacLimit >= pacMaxSetCmd) then pacLimit = pacMaxSetCmd end
     if (case3ZE >= caseReset) then
      case3ZE = 0
      for devV in pairs(dgCtlDev) do
       if WR.isOnline(devV) then
        if (pacLimit <= 2) then pacLimit = 2 end
        pacLimit = tonumber(string.format("%.0f", pacLimit))
        WR.writeHexOpts(devV, pacLimitWrite, bit.tohex(pacLimit,4),0x6)
       end
      end
      logCsv(fileName,"1.3.0"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
     else
      case3ZE = case3ZE + 1
      logCsv(fileName,"1.3.1"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
     end
    ---case 4 : ZE meter > 0 & ZE meter < minload  no change
    elseif ((zeIac >= zeIacSetCmd) and (maxPacLimit < pacMaxSetCmd)) then
     if (zeIac > zeIacMaxCmd) then
         pacLimit = tonumber(maxPacLimit - (pacTuneStCmd * pacMaxSetCmd / 1000))
         pacLimit = tonumber(string.format("%.0f", pacLimit))
		 if (case4ZE >= caseReset) then
                     case4ZE = 0
         for devV in pairs(dgCtlDev) do
       if WR.isOnline(devV) then
          if (maxPacLimit <= 2) then pacLimit = 2 end
             pacLimit = tonumber(string.format("%.0f", pacLimit))
             WR.writeHexOpts(devV, pacLimitWrite, bit.tohex(pacLimit,4),0x6)
           end
      end
	  logCsv(fileName,"1.4.0"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
	  else
	      case4ZE = case4ZE + 1
	      logCsv(fileName,"1.4.1`"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
         end
       end
     else
        case5ZE = case5ZE + 1
        logCsv(fileName,"1.5.0"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..","..",".."")
     end
   end
-------------------------------------------- Closed loop Q Control -------------------------------------------------------------------------

  if ((not(is_nan(zeQac))) and (PowSelCmd == 1) and (totalQInverters > 0) and (fOnOffCmd == 1) and (qacOnOffCmd == 1))then   -- checking Grid Reactive Power not nan
      -- case 1 : ZE meter < critical load (100VAR) ; Reactive Power supply to grid
    if ((zeQac <= zeCriticalLoad) and (maxQacLimit > -100) and ((zePf > zePfSetCmd) or (zePf < -zePfSetCmd))) then
     qacLimit = ((((pvQac + (zeQac - zeCriticalLoad)) / totalQInverters)) / ((100- qacGRSetCmd) / 100))
     if ((( -1 * zeMinLoad) / totalQInverters) > qacLimit) then qacLimit = (maxQacLimit * qacMaxSetCmd / 100) end
     if (qacLimit < -(qacMaxSetCmd)) then qacLimit = -qacMaxSetCmd end
     qacLimit = tonumber(string.format("%.0f", qacLimit))
     oldQacLimit = tonumber(string.format("%.0f", (maxQacLimit * qacMaxSetCmd / 100)))
     if (oldQacLimit <= qacLimit) then
      qacLimit = oldQacLimit - tonumber(string.format("%.0f", (qacDecConstCmd * qacMaxSetCmd / 1000)))
      oldQacLimitW = tonumber(string.format("%.1f", (1 * (oldQacLimit / qacMaxSetCmd) * 100)))
      qacLimitW = tonumber(string.format("%.1f", (1 * (qacLimit / qacMaxSetCmd) * 100)))
      pvQacW = 1 * (pvQac)     
	 if (case1ZEQ >= caseReset) then
       case1ZEQ = 0
       for devV in pairs(dgCtlDev) do
        if WR.isOnline(devV) then
         WR.writeHexOpts(devV, qacLimitWrite, bit.tohex(qacLimit,4),0x6)
        end
       end
       logCsvZE(fileNameZE,"2.1.0"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
      else
       case1ZEQ = case1ZEQ + 1
       logCsvZE(fileNameZE,"2.1.1"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
      end
     else
	   oldQacLimitW = tonumber(string.format("%.1f", (1 * (oldQacLimit / qacMaxSetCmd) * 100)))
       qacLimitW = tonumber(string.format("%.1f", (1 * (qacLimit / qacMaxSetCmd) * 100)))
       pvQacW = 1 * (pvQac)
      if (case1ZEQ >= caseReset) then
       case1ZEQ = 0
       for devV in pairs(dgCtlDev) do
        if WR.isOnline(devV) then
         qacLimit = tonumber(string.format("%.0f", qacLimit))
         WR.writeHexOpts(devV, qacLimitWrite, bit.tohex(qacLimit,4),0x6)
        end
       end
       logCsvZE(fileNameZE,"2.1.2"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
       case1ZEQ = case1ZEQ + 1
       logCsvZE(fileNameZE,"2.1.3"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
      end
     end
    -- case 2 : ZE meter > Min Load  force up --  Reactive Power consumption from grid < -50VAR
     elseif ((zeQac >= (zeMinLoad + zeThreshold)) and (minQacLimit < 100) and ((zePf > zePfSetCmd) or (zePf < -zePfSetCmd))) then
     qacLimit = ((((pvQac - (zeMinLoad + zeThreshold - zeQac)) / totalQInverters)) * ((100- qacGRSetCmd) / 100))
     if ((( -1 * zeMinLoad) / totalQInverters) < qacLimit) then qacLimit = (minQacLimit * qacMaxSetCmd / 100) end
     if (qacLimit > qacMaxSetCmd) then qacLimit = qacMaxSetCmd end
     qacLimit = tonumber(string.format("%.0f", qacLimit))
     oldQacLimit = tonumber(string.format("%.0f", (minQacLimit * qacMaxSetCmd / 100)))
     if (oldQacLimit >= qacLimit) then
      qacLimit = oldQacLimit + tonumber(string.format("%.0f", (qacIncConstCmd * qacMaxSetCmd / 1000)))
      oldQacLimitW = tonumber(string.format("%.1f", (1 * (oldQacLimit / qacMaxSetCmd) * 100)))
      qacLimitW = tonumber(string.format("%.1f", (1 * (qacLimit / qacMaxSetCmd) * 100)))
      pvQacW = 1 * (pvQac)
	  if (case2ZEQ >= caseReset) then
       case2ZEQ = 0
       for devV in pairs(dgCtlDev) do
        if WR.isOnline(devV) then
         WR.writeHexOpts(devV, qacLimitWrite, bit.tohex(qacLimit,4),0x6)
        end
       end
       logCsvZE(fileNameZE,"2.2.0"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
      else
       case2ZEQ = case2ZEQ + 1
       logCsvZE(fileNameZE,"2.2.1"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
      end
     else
      oldQacLimitW = tonumber(string.format("%.1f", (1 * (oldQacLimit / qacMaxSetCmd) * 100)))
      qacLimitW = tonumber(string.format("%.1f", (1 * (qacLimit / qacMaxSetCmd) * 100)))
      pvQacW = 1 * (pvQac)
	  if (case2ZEQ >= caseReset) then
       case2ZEQ = 0
       for devV in pairs(dgCtlDev) do
        if WR.isOnline(devV) then
         WR.writeHexOpts(devV, qacLimitWrite, bit.tohex(qacLimit,4),0x6)
        end
       end
       logCsvZE(fileNameZE,"2.2.2"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
      else
       case2ZEQ = case2ZEQ + 1
       logCsvZE(fileNameZE,"2.2.3"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
      end
     end
   -- case 3 : ZE meter > minload & ZE meter < 10  tune up
    elseif ((zeQac <= (zeMinLoad - zeThreshold)) and (minQacLimit > -100) and ((zePf > zePfSetCmd) or (zePf < -zePfSetCmd))) then
           qacLimit = tonumber((maxQacLimit * qacMaxSetCmd / 100) - (tuneStep * qacMaxSetCmd / 1000))
           qacLimit = tonumber(string.format("%.0f", qacLimit))
     oldQacLimit = tonumber(string.format("%.0f", (oldQacLimit * qacMaxSetCmd / 100)))
     if (qacLimit < -qacMaxSetCmd) then qacLimit = qacMaxSetCmd end
        oldQacLimitW = tonumber(string.format("%.1f", (1 * (oldQacLimit / qacMaxSetCmd) * 100)))
        qacLimitW = tonumber(string.format("%.1f", (1 * (qacLimit / qacMaxSetCmd) * 100)))
        pvQacW = 1 * (pvQac)
	 if (case3ZEQ >= caseReset) then
      case3ZEQ = 0
      for devV in pairs(dgCtlDev) do
       if WR.isOnline(devV) then
        WR.writeHexOpts(devV, qacLimitWrite, bit.tohex(qacLimit,4),0x6)
       end
      end
      logCsvZE(fileNameZE,"2.3.0"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
     else
      case3ZEQ = case3ZEQ + 1
      logCsvZE(fileNameZE,"2.3.1"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
     end
    --case 4 : ZE meter > 0 & ZE meter < minload  no change
    elseif (((zePf < 0) and (zePf >= -zePfSetCmd)) or ((zePf > 0) and (zePf <= zePfSetCmd)))  then --and (zePac <= zeThreshold)) then
          oldQacLimit = tonumber(string.format("%.0f", (oldQacLimit * qacMaxSetCmd / 100)))
		  qacLimit = tonumber(string.format("%.0f", (qacLimit * qacMaxSetCmd / 100)))
          if (((zePf <= zePfMaxCmd) and (zePf >= -zePfMaxCmd)) and (maxQacLimit >= 0)) then
			qacLimit = tonumber((maxQacLimit * qacMaxSetCmd / 100) - (qacTuneStCmd * qacMaxSetCmd / 1000))
			qacLimit = tonumber(string.format("%.0f", qacLimit))
           if (qacLimit < -qacMaxSetCmd) then qacLimit = -qacMaxSetCmd end
		          qacLimit = tonumber(string.format("%.1f", qacLimit))
                  qacLimitW = tonumber(string.format("%.1f", (1 * (qacLimit / qacMaxSetCmd) * 100)))
                  pvQacW = 1 * (pvQac)
					if (case4ZEQ >= caseReset) then
                       case4ZEQ = 0
                for devV in pairs(dgCtlDev) do
                  if WR.isOnline(devV) then
                     WR.writeHexOpts(devV, qacLimitWrite, bit.tohex(qacLimit,4),0x6)
                  end
               end
			   logCsvZE(fileNameZE,"2.4.0"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
			else 
			   case4ZEQ = case4ZEQ + 1
               logCsvZE(fileNameZE,"2.4.1"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
			end   
      elseif (((zePf <= zePfMaxCmd) and (zePf >= -zePfMaxCmd)) and (maxQacLimit < 0)) then
        qacLimit = tonumber((maxQacLimit * qacMaxSetCmd / 100) + (qacTuneStCmd * qacMaxSetCmd / 1000))
        qacLimit = tonumber(string.format("%.0f", qacLimit))
                 if (qacLimit > qacMaxSetCmd) then qacLimit = qacMaxSetCmd end
                  qacLimit = tonumber(string.format("%.1f", qacLimit))
                  qacLimitW = tonumber(string.format("%.1f", (1 * (qacLimit / qacMaxSetCmd) * 100)))
                  pvQacW = 1 * (pvQac)		           
				   if (case4ZEQ >= caseReset) then
                       case4ZEQ = 0				 
                for devV in pairs(dgCtlDev) do
                   if WR.isOnline(devV) then
                      WR.writeHexOpts(devV, qacLimitWrite, bit.tohex(qacLimit,4),0x6)
                   end
                end
               logCsvZE(fileNameZE,"2.4.2"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
			else 
			   case4ZEQ = case4ZEQ + 1
               logCsvZE(fileNameZE,"2.4.3"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")		
            end
		else	
          logCsvZE(fileNameZE,"2.5.1"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..","..",".."")
      end
	 else
               --qacLimit = tonumber(string.format("%.1f", (qacLimit * qacMaxSetCmd / 100)))
               --oldQacLimit = tonumber(string.format("%.1f", (oldQacLimit * qacMaxSetCmd / 100)))
               oldQacLimitW = tonumber(string.format("%.1f", (1 * (oldQacLimit))))
               qacLimitW = tonumber(string.format("%.1f", (1 * (qacLimit))))
               pvQacW = 1 * (pvQac)
               case5ZEQ = case5ZEQ + 1
               logCsvZE(fileNameZE,"2.5.0"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..","..",".."")
            end
         end
		 
   -------------------------------------------- Closed loop PF Control -------------------------------------------------------------------------
     
	   if ((not(is_nan(zePf))) and (PowSelCmd == 1) and (totalQInverters > 0) and (fOnOffCmd == 1) and (pfOnOffCmd == 1))then   -- checking Grid Reactive Power not nan   
         -- case 1 : ZE meter < critical load (100VAR) ; Reactive Power supply to grid
	       if ((zePf > (zePFThreshold-zePFMinLoad)) and (zePf < 0) and (maxQacLimit < 101) and (maxQacLimit > -100)) then
           --if ((zePf < (zePFMinLoad - zePFThreshold)) and (zePf > 0) and (maxQacLimit > -100) and (zePac > 0)) then
          zePFMinLoadnew = (zePac / (zePFThreshold-zePFMinLoad)) * (math.sqrt(1 - ((zePFThreshold-zePFMinLoad) * (zePFThreshold-zePFMinLoad))))
          qacLimit = (((pvQac + zeQac - zePFMinLoadnew) / totalQInverters ) * ((100- qacGRSetCmd) / 100))
          if ((( -1 * zePFMinLoadnew) / totalQInverters) > qacLimit) then qacLimit = (maxQacLimit * qacMaxSetCmd / 100) end
          if (qacLimit < -(qacMaxSetCmd)) then qacLimit = -qacMaxSetCmd end
          qacLimit = tonumber(string.format("%.3f", qacLimit))
          oldQacLimit = tonumber(string.format("%.3f", (maxQacLimit * qacMaxSetCmd / 100)))
          if (oldQacLimit <= qacLimit) then
           qacLimit = oldQacLimit - tonumber(string.format("%.3f", (qacDecConstCmd * qacMaxSetCmd / 1000)))
           oldQacLimitW = tonumber(string.format("%.3f", (1 * (oldQacLimit / qacMaxSetCmd) * 100)))
           qacLimitW = tonumber(string.format("%.3f", (1 * (qacLimit / qacMaxSetCmd) * 100)))
           pvQacW = 1 * (pvQac)
           if (case1ZEPF >= caseReset) then
            case1ZEPF = 0
            for devV in pairs(dgCtlDev) do
                 if WR.isOnline(devV) then
                  WR.writeHexOpts(devV, qacLimitWrite, bit.tohex(qacLimit ,4),0x6)
                 end
            end
            logCsvZEPF(fileNameZEPF,"5.1.0"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
           else
            case1ZEPF = case1ZEPF + 1
            logCsvZEPF(fileNameZEPF,"5.1.1"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
           end
          else
           oldQacLimitW = tonumber(string.format("%.3f", (1 * (oldQacLimit / qacMaxSetCmd) * 100)))
           qacLimitW = tonumber(string.format("%.3f", (1 * (qacLimit / qacMaxSetCmd) * 100)))
           pvQacW = 1 * (pvQac)
           if (case1ZEPF >= caseReset) then
            case1ZEPF = 0
            for devV in pairs(dgCtlDev) do
                 if WR.isOnline(devV) then
                  WR.writeHexOpts(devV, qacLimitWrite, bit.tohex(qacLimit ,4),0x6)
                 end
            end
            logCsvZEPF(fileNameZEPF,"5.1.2"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
           else
            case1ZEPF = case1ZEPF + 1
            logCsvZEPF(fileNameZEPF,"5.1.3"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
           end
          end
          -- case 2 : ZE meter > Min Load  force up --  Reactive Power consumption from grid < -50VAR
          elseif ((zePf < (zePFMinLoad - zePFThreshold)) and (zePf > 0) and (maxQacLimit > -101) and (zePac > 0) and (maxQacLimit< 100)) then
		  --elseif ((zePf > (zePFThreshold-zePFMinLoad)) and (zePf < 0) and (minQacLimit < 100)) then
          --qacLimit = ((((pvQac - (zeMinLoad + zeThreshold - zeQac)) / totalQInverters)) * ((100- qacGRSetCmd) / 100))
          zePFMinLoadnew = (zePac / (zePFMinLoad - zePFThreshold)) * math.sqrt(1 - ((zePFMinLoad - zePFThreshold) * (zePFMinLoad - zePFThreshold)))
          qacLimit = (((pvQac + zeQac - zePFMinLoadnew) / totalQInverters) * ((100- qacGRSetCmd) / 100))
          if ((( -1 * zePFMinLoad) / totalQInverters) < qacLimit) then qacLimit = (minQacLimit * qacMaxSetCmd / 100) end
          if (qacLimit > qacMaxSetCmd) then qacLimit = qacMaxSetCmd end
          qacLimit = tonumber(string.format("%.3f", qacLimit))
          oldQacLimit = tonumber(string.format("%.0f", (minQacLimit * qacMaxSetCmd / 100)))
          if (oldQacLimit >= qacLimit) then
            qacLimit = oldQacLimit + tonumber(string.format("%.0f", (qacIncConstCmd * qacMaxSetCmd / 1000)))
            oldQacLimitW = tonumber(string.format("%.3f", (1 * (oldQacLimit / qacMaxSetCmd) * 100)))
            qacLimitW = tonumber(string.format("%.3f", (1 * (qacLimit / qacMaxSetCmd) * 100)))
            pvQacW = 1 * (pvQac)
           if (case2ZEPF >= caseReset) then
            case2ZEPF = 0
            for devV in pairs(dgCtlDev) do
                 if WR.isOnline(devV) then
                  WR.writeHexOpts(devV, qacLimitWrite, bit.tohex(qacLimit ,4),0x6)
                 end
            end
            logCsvZEPF(fileNameZEPF,"5.2.0"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
           else
            case2ZEPF = case2ZEPF + 1
            logCsvZEPF(fileNameZEPF,"5.2.1"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
           end
          else
           oldQacLimitW = tonumber(string.format("%.3f", (1 * (oldQacLimit / qacMaxSetCmd) * 100)))
           qacLimitW = tonumber(string.format("%.3f", (1 * (qacLimit / qacMaxSetCmd) * 100)))
           pvQacW = -1 * (pvQac)
           if (case2ZEPF >= caseReset) then
            case2ZEPF = 0
            for devV in pairs(dgCtlDev) do
                 if WR.isOnline(devV) then
                  WR.writeHexOpts(devV, qacLimitWrite, bit.tohex(qacLimit ,4),0x6)
                 end
            end
            logCsvZEPF(fileNameZEPF,"5.2.2"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
           else
            case2ZEPF = case2ZEPF + 1
            logCsvZEPF(fileNameZEPF,"5.2.3"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
           end
          end
         --case 4 : ZE meter > 0 & ZE meter < minload  no change
         else
                                           --qacLimit = tonumber(string.format("%.3f", (qacLimit * qacMaxSetCmd / 100)))
                                           --oldQacLimit = tonumber(string.format("%.3f", (oldQacLimit * qacMaxSetCmd / 100)))
            oldQacLimitW = tonumber(string.format("%.3f", (1 * (oldQacLimit))))
            qacLimitW = tonumber(string.format("%.3f", (1 * (qacLimit))))
            pvQacW = 1 * (pvQac)
            case5ZEPF = case5ZEPF + 1
            logCsvZEPF(fileNameZEPF,"5.5.0"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..","..",".."")
          end
      end

 -------------------------------------------- Closed loop Q/U Control--------------------------------------------------------------------

  if ((not(is_nan(zeUac))) and (PowSelCmd == 1) and (totalQInverters > 0) and (fOnOffCmd == 1) and (uacOnOffCmd == 1))then   -- checking Grid Reactive Power not nan
      -- case 1 : ZE meter < critical load (100VAR) -- Reactive power  Grid
    if ((zeUac >= (zeUMinLoad + zeUThreshold)) and ((zePf > zePfSetCmd) or (zePf < -zePfSetCmd))) then
               if ((zePac > 0) and (uacOnOffCmd == 1)) then
                  if ((zeUac > (1.01 * zeUMinLoad)) and (zeUac <= (1.02 * zeUMinLoad))) then qacMaxSet = (((pvQac - (0.2030 * zePac) + zeQac) / (totalQInverters * qacMaxSetCmd))*100) end
                  if ((zeUac > (1.02 * zeUMinLoad)) and (zeUac <= (1.03 * zeUMinLoad))) then qacMaxSet = (((pvQac - (0.2506 * zePac) + zeQac) / (totalQInverters * qacMaxSetCmd))*100) end
                  if ((zeUac > (1.03 * zeUMinLoad)) and (zeUac <= (1.04 * zeUMinLoad))) then qacMaxSet = (((pvQac - (0.2917 * zePac) + zeQac) / (totalQInverters * qacMaxSetCmd))*100) end
                  if ((zeUac > (1.04 * zeUMinLoad)) and (zeUac <= (1.05 * zeUMinLoad))) then qacMaxSet = (((pvQac - (0.3287 * zePac) + zeQac) / (totalQInverters * qacMaxSetCmd))*100) end
                  if (zeUac > (1.05 * zeUMinLoad)) then qacMaxSet = (((pvQac - (0.3287 * zePac) + zeQac) / (totalQInverters * qacMaxSetCmd))*100)  end
               elseif ((zePac <= 0) and (uacOnOffCmd == 1)) then
                  if (zeUac > (1.05 * zeUMinLoad)) then qacMaxSet = 100 end
                  --if ((zeUac >= (0.96 * zeUMinLoad)) and (zeUac < (0.97 * zeUMinLoad))) then qacMaxSet = 100 end
                  --if ((zeUac >= (0.97 * zeUMinLoad)) and (zeUac < (0.98 * zeUMinLoad))) then qacMaxSet = 100 end
                  --if ((zeUac >= (0.98 * zeUMinLoad)) and (zeUac < (0.99 * zeUMinLoad))) then qacMaxSet = 100 end
                  if ((zeUac >= (1.01 * zeUMinLoad)) and (zeUac <= (1.05 * zeUMinLoad))) then qacMaxSet = 100 end
                  --if ((zeUac > (1.02 * zeUMinLoad)) and (zeUac <= (1.03 * zeUMinLoad))) then qacMaxSet = 100 end
                  --if ((zeUac > (1.03 * zeUMinLoad)) and (zeUac <= (1.04 * zeUMinLoad))) then qacMaxSet = 100 end
                  --if ((zeUac > (1.04 * zeUMinLoad)) and (zeUac <= (1.05 * zeUMinLoad))) then qacMaxSet = 100 end
               end
     --if zeQac < 0 then zeQacW = (-1 * zeQac) end
     --zeUMinLoad = (((zeUMinLoad + zeUThreshold) * (zeUMinLoad + zeUThreshold)) / (zeUac * zeUac)) * zeQacW
     --qacLimit = (((pvQac + (zeUMinLoad - zeQacW)) / totalQInverters) / ((qacMaxSetCmd / 100) - quGRSetCmd ))
               qacMaxSet = tonumber(string.format("%.1f", qacMaxSet))
               qacLimit = qacMaxSet --/ ((100+ quGRSetCmd) / 100)
               qacLimit = tonumber(string.format("%.1f", qacLimit))
               oldQacLimit = tonumber(string.format("%.1f", maxQacLimit))
     --if (qacLimit < -100) then qacLimit = -100 end
     --qacLimit = tonumber(string.format("%.0f", qacLimit))
     --oldQacLimit = tonumber(string.format("%.0f", maxQacLimit))
     if (oldQacLimit < qacLimit) then
      qacLimit = oldQacLimit +  quDecConstCmd
      if (case1ZEU >= caseReset) then
       case1ZEU = 0
       for devV in pairs(dgCtlDev) do
        if WR.isOnline(devV) then
         qacLimitW = (qacLimit * (qacMaxSetCmd / 100))
         qacLimitW = tonumber(string.format("%.0f", qacLimitW))
         WR.writeHexOpts(devV, qacLimitWrite, bit.tohex(qacLimitW,4),0x6)
        end
       end
       logCsvZEU(fileNameZEU,"3.1.0"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQac..","..oldPacLimit..","..oldQacLimit..","..pacLimit..","..qacLimit..",".."")
      else
       case1ZEU = case1ZEU + 1
       logCsvZEU(fileNameZEU,"3.1.1"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQac..","..oldPacLimit..","..oldQacLimit..","..pacLimit..","..qacLimit..",".."")
      end
     elseif (oldQacLimit > qacMaxSet) then
      if (case1ZEU >= caseReset) then
       case1ZEU = 0
       for devV in pairs(dgCtlDev) do
        if WR.isOnline(devV) then
         qacLimitW = (qacLimit * (qacMaxSetCmd / 100))
         qacLimitW = tonumber(string.format("%.0f", qacLimitW))
         WR.writeHexOpts(devV, qacLimitWrite, bit.tohex(qacLimitW,4),0x6)
        end
       end
       logCsvZEU(fileNameZEU,"3.1.2"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQac..","..oldPacLimit..","..oldQacLimit..","..pacLimit..","..qacLimit..",".."")
      else
       case1ZEU = case1ZEU + 1
       logCsvZEU(fileNameZEU,"3.1.3"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQac..","..oldPacLimit..","..oldQacLimit..","..pacLimit..","..qacLimit..",".."")
      end
    else
       case1ZEU = case1ZEU + 1
       logCsvZEU(fileNameZEU,"3.1.4"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQac..","..oldPacLimit..","..oldQacLimit..","..pacLimit..","..qacLimit..",".."")    	
     end
    -- case 2 : ZE meter > Min Load  force up --  Reactive Power supply to grid < -50VAR
     elseif ((zeUac <= zeUCriticalLoad) and ((zePf > zePfSetCmd) or (zePf < -zePfSetCmd))) then
               if ((zePac > 0) and (uacOnOffCmd == 1)) then
                  if (zeUac < (0.95 * zeUMinLoad)) then qacMaxSet = (((pvQac + (0.3287 * zePac) + zeQac) / (totalQInverters * qacMaxSetCmd))*100) end
                  if ((zeUac >= (0.95 * zeUMinLoad)) and (zeUac < (0.96 * zeUMinLoad))) then qacMaxSet = (((pvQac + (0.3287 * zePac) + zeQac) / (totalQInverters * qacMaxSetCmd))*100) end
                  if ((zeUac >= (0.96 * zeUMinLoad)) and (zeUac < (0.97 * zeUMinLoad))) then qacMaxSet = (((pvQac + (0.2917 * zePac) + zeQac) / (totalQInverters * qacMaxSetCmd))*100) end
                  if ((zeUac >= (0.97 * zeUMinLoad)) and (zeUac < (0.98 * zeUMinLoad))) then qacMaxSet = (((pvQac + (0.2506 * zePac) + zeQac) / (totalQInverters * qacMaxSetCmd))*100) end
                  if ((zeUac >= (0.98 * zeUMinLoad)) and (zeUac < (0.99 * zeUMinLoad))) then qacMaxSet = (((pvQac + (0.2030 * zePac) + zeQac) / (totalQInverters * qacMaxSetCmd))*100) end
               elseif ((zePac <= 0) and (uacOnOffCmd == 1)) then
                  if (zeUac < (0.95 * zeUMinLoad)) then qacMaxSet = 100 end
                  if ((zeUac >= (0.95 * zeUMinLoad)) and (zeUac <= (0.99 * zeUMinLoad))) then qacMaxSet = 100 end
                  --if ((zeUac >= (0.96 * zeUMinLoad)) and (zeUac < (0.97 * zeUMinLoad))) then qacMaxSet = 100 end
                  --if ((zeUac >= (0.97 * zeUMinLoad)) and (zeUac < (0.98 * zeUMinLoad))) then qacMaxSet = 100 end
                  --if ((zeUac >= (0.98 * zeUMinLoad)) and (zeUac < (0.99 * zeUMinLoad))) then qacMaxSet = 100 end
               end
      --if zeQac < 0 then zeQacW = (-1 * zeQac) end
     --zeUCriticalLoad = ((zeUMinLoad * zeUMinLoad) / (zeUac * zeUac)) * zeQacW
     --qacLimit = (((pvQac - (zeQacW - zeUCriticalLoad)) / totalQInverters) / ((qacMaxSetCmd / 100) + quGRSetCmd ))
     --if (qacLimit > 100) then qacLimit = 100 end
     --qacLimit = tonumber(string.format("%.0f", qacLimit))
     --oldQacLimit = tonumber(string.format("%.0f", minQacLimit))
               qacMaxSet = tonumber(string.format("%.1f", qacMaxSet))
               qacLimit = qacMaxSet
               print("qacMaxSetD", qacMaxSet)
               qacLimit = tonumber(string.format("%.1f", qacLimit))
               oldQacLimit = tonumber(string.format("%.1f", minQacLimit))
     if (oldQacLimit > qacLimit) then
      qacLimit = oldQacLimit - quIncConstCmd
      if (case2ZEU >= caseReset) then
       case2ZEU = 0
       for devV in pairs(dgCtlDev) do
        if WR.isOnline(devV) then
         qacLimitW = (qacLimit * (qacMaxSetCmd / 100))
         qacLimitW = tonumber(string.format("%.0f", qacLimitW))
         WR.writeHexOpts(devV, qacLimitWrite, bit.tohex(qacLimitW,4),0x6)
        end
       end
       logCsvZEU(fileNameZEU,"3.2.0"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQac..","..oldPacLimit..","..oldQacLimit..","..pacLimit..","..qacLimit..",".."")
      else
       case2ZEU = case2ZEU + 1
       logCsvZEU(fileNameZEU,"3.2.1"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQac..","..oldPacLimit..","..oldQacLimit..","..pacLimit..","..qacLimit..",".."")
      end
     elseif (minQacLimit < qacMaxSet) then
      if (case2ZEU >= caseReset) then
       case2ZEU = 0
       for devV in pairs(dgCtlDev) do
        if WR.isOnline(devV) then
         qacLimitW = (qacLimit * (qacMaxSetCmd / 100))
         qacLimitW = tonumber(string.format("%.0f", qacLimitW))
         WR.writeHexOpts(devV, qacLimitWrite, bit.tohex(qacLimitW,4),0x6)
        end
       end
       logCsvZEU(fileNameZEU,"3.2.2"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQac..","..oldPacLimit..","..oldQacLimit..","..pacLimit..","..qacLimit..",".."")
      else
       case2ZEU = case2ZEU + 1
       logCsvZEU(fileNameZEU,"3.2.3"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQac..","..oldPacLimit..","..oldQacLimit..","..pacLimit..","..qacLimit..",".."")
      end
    else
    	case2ZEU = case2ZEU + 1
       logCsvZEU(fileNameZEU,"3.2.4"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQac..","..oldPacLimit..","..oldQacLimit..","..pacLimit..","..qacLimit..",".."")
     end
   -- case 3 : ZE meter > minload & ZE meter < 10  tune up
    elseif ((zeUac <= (zeUMinLoad - zeUThreshold)) and ((zePf > zePfSetCmd) or (zePf < -zePfSetCmd))) then
               if ((zePac > 0) and (uacOnOffCmd == 1)) then
                  if (zeUac < (0.95 * zeUMinLoad)) then qacMaxSet = (((pvQac + (0.3287 * zePac) + zeQac) / (totalQInverters * qacMaxSetCmd))*100) end
                  if ((zeUac >= (0.95 * zeUMinLoad)) and (zeUac < (0.96 * zeUMinLoad))) then qacMaxSet = (((pvQac + (0.3287 * zePac) + zeQac) / (totalQInverters * qacMaxSetCmd))*100) end
                  if ((zeUac >= (0.96 * zeUMinLoad)) and (zeUac < (0.97 * zeUMinLoad))) then qacMaxSet = (((pvQac + (0.2917 * zePac) + zeQac) / (totalQInverters * qacMaxSetCmd))*100) end
                  if ((zeUac >= (0.97 * zeUMinLoad)) and (zeUac < (0.98 * zeUMinLoad))) then qacMaxSet = (((pvQac + (0.2506 * zePac) + zeQac) / (totalQInverters * qacMaxSetCmd))*100) end
                  if ((zeUac >= (0.98 * zeUMinLoad)) and (zeUac < (0.99 * zeUMinLoad))) then qacMaxSet = (((pvQac + (0.2030 * zePac) + zeQac) / (totalQInverters * qacMaxSetCmd))*100) end
               elseif ((zePac <= 0) and (uacOnOffCmd == 1)) then
                  if (zeUac < (0.95 * zeUMinLoad)) then qacMaxSet = 100 end
                  if ((zeUac >= (0.95 * zeUMinLoad)) and (zeUac <= (0.99 * zeUMinLoad))) then qacMaxSet = 100 end
                  --if ((zeUac >= (0.96 * zeUMinLoad)) and (zeUac < (0.97 * zeUMinLoad))) then qacMaxSet = 100 end
                  --if ((zeUac >= (0.97 * zeUMinLoad)) and (zeUac < (0.98 * zeUMinLoad))) then qacMaxSet = 100 end
                  --if ((zeUac >= (0.98 * zeUMinLoad)) and (zeUac < (0.99 * zeUMinLoad))) then qacMaxSet = 100 end
               end
      --if zeQac < 0 then zeQacW = (-1 * zeQac) end
     --zeUCriticalLoad = ((zeUMinLoad * zeUMinLoad) / (zeUac * zeUac)) * zeQacW
     --qacLimit = (((pvQac - (zeQacW - zeUCriticalLoad)) / totalQInverters) / ((qacMaxSetCmd / 100) + quGRSetCmd ))
     --if (qacLimit > 100) then qacLimit = 100 end
     --qacLimit = tonumber(string.format("%.0f", qacLimit))
     --oldQacLimit = tonumber(string.format("%.0f", minQacLimit))
               qacMaxSet = tonumber(string.format("%.1f", qacMaxSet))
               qacLimit = qacMaxSet
               print("qacMaxSetD", qacMaxSet)
               qacLimit = tonumber(string.format("%.1f", qacLimit))
               oldQacLimit = tonumber(string.format("%.1f", minQacLimit))
     if (oldQacLimit >= qacLimit) then
      qacLimit = oldQacLimit - quIncConstCmd
      if (case3ZEU >= caseReset) then
       case3ZEU = 0
       for devV in pairs(dgCtlDev) do
        if WR.isOnline(devV) then
         qacLimitW = (qacLimit * (qacMaxSetCmd / 100))
         qacLimitW = tonumber(string.format("%.0f", qacLimitW))
         WR.writeHexOpts(devV, qacLimitWrite, bit.tohex(qacLimitW,4),0x6)
        end
       end
       logCsvZEU(fileNameZEU,"3.3.0"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQac..","..oldPacLimit..","..oldQacLimit..","..pacLimit..","..qacLimit..",".."")
      else
       case3ZEU = case3ZEU + 1
       logCsvZEU(fileNameZEU,"3.3.1"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQac..","..oldPacLimit..","..oldQacLimit..","..pacLimit..","..qacLimit..",".."")
      end
     elseif (minQacLimit < qacMaxSet) then
      if (case3ZEU >= caseReset) then
       case3ZEU = 0
       for devV in pairs(dgCtlDev) do
        if WR.isOnline(devV) then
         qacLimitW = (qacLimit * (qacMaxSetCmd / 100))
         qacLimitW = tonumber(string.format("%.0f", qacLimitW))
         WR.writeHexOpts(devV, qacLimitWrite, bit.tohex(qacLimitW,4),0x6)
        end
       end
       logCsvZEU(fileNameZEU,"3.3.2"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQac..","..oldPacLimit..","..oldQacLimit..","..pacLimit..","..qacLimit..",".."")
      else
       case3ZEU = case3ZEU + 1
       logCsvZEU(fileNameZEU,"3.3.3"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQac..","..oldPacLimit..","..oldQacLimit..","..pacLimit..","..qacLimit..",".."")
      end
     else
       case3ZEU = case3ZEU + 1
       logCsvZEU(fileNameZEU,"3.3.4"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQac..","..oldPacLimit..","..oldQacLimit..","..pacLimit..","..qacLimit..",".."")
     end
   -- case 5 : ZEUAC in Dead Band
    elseif ((zeUac >= (zeUMinLoad - zeUThreshold)) and (zeUac <= (zeUMinLoad + zeUThreshold)) and ((zePf > zePfSetCmd) or (zePf < -zePfSetCmd))) then
               if (zeUac > zeUMinLoad) and (maxQacLimit > 0) then
                  qacLimit = tonumber((maxQacLimit - quTuneStCmd))
                  if (case6ZEU >= caseReset) then
                     case6ZEU = 0
                     for devV in pairs(dgCtlDev) do
                        if WR.isOnline(devV) then
         			qacLimitW = (qacLimit * (qacMaxSetCmd / 100))
         			qacLimitW = tonumber(string.format("%.0f", qacLimitW))
         			WR.writeHexOpts(devV, qacLimitWrite, bit.tohex(qacLimitW,4),0x6)
                        end
                     end
                     logCsvZEU(fileNameZEU,"3.6.0"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQac..","..oldPacLimit..","..oldQacLimit..","..pacLimit..","..qacLimit..",".."")
                  else
                     case6ZEU = case6ZEU + 1
                     logCsvZEU(fileNameZEU,"3.6.1"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQac..","..oldPacLimit..","..oldQacLimit..","..pacLimit..","..qacLimit..",".."")
                  end
               elseif (zeUac < zeUMinLoad) and (maxQacLimit < 0) then
                  qacLimit = tonumber((maxQacLimit + quTuneStCmd))
                  if (case6ZEU >= caseReset) then
                     case6ZEU = 0
                     for devV in pairs(dgCtlDev) do
                        if WR.isOnline(devV) then
         			qacLimitW = (qacLimit * (qacMaxSetCmd / 100))
         			qacLimitW = tonumber(string.format("%.0f", qacLimitW))
         			WR.writeHexOpts(devV, qacLimitWrite, bit.tohex(qacLimitW,4),0x6)
                        end
                     end
                     logCsvZEU(fileNameZEU,"3.6.2"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQac..","..oldPacLimit..","..oldQacLimit..","..pacLimit..","..qacLimit..",".."")
                  else
                     case6ZEU = case6ZEU + 1
                     logCsvZEU(fileNameZEU,"3.6.3"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQac..","..oldPacLimit..","..oldQacLimit..","..pacLimit..","..qacLimit..",".."")
                  end
               else
                  case7ZEU = case7ZEU + 1
                  logCsvZEU(fileNameZEU,"3.6.4"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQac..","..oldPacLimit..","..oldQacLimit..","..pacLimit..","..qacLimit..",".."")
               end
    --case 4 : ZE meter > 0 & ZE meter < minload  no change
            elseif (((zePf < 0) and (zePf >= -zePfSetCmd)) or ((zePf > 0) and (zePf <= zePfSetCmd)))  then --and (zePac <= zeThreshold)) then

               if ((zePac > 0) and (uacOnOffCmd == 1)) then
                  if (zeUac < (0.99 * zeUMinLoad)) then qacMaxSet = (((pvQac + (0.3287 * zePac) + zeQac) / (totalQInverters * qacMaxSetCmd))*100) end
                  if (zeUac > (1.01 * zeUMinLoad)) then qacMaxSet = (((pvQac - (0.3287 * zePac) + zeQac) / (totalQInverters * qacMaxSetCmd))*100) end
                  if ((zeUac >= (0.99 * zeUMinLoad)) and (zeUac < (1.01 * zeUMinLoad))) then qacMaxSet = 0 end
               elseif ((zePac <= 0) and (uacOnOffCmd == 1)) then
                  qacMaxSet = 100
               end
               qacMaxSet = tonumber(string.format("%.1f", qacMaxSet))

               if ((zePf <= zePfMaxCmd) and (zePf >= -zePfMaxCmd)) and (((maxQacLimit < 0) and (zeUac > (zeUMinLoad + zeUThreshold))) or ((maxQacLimit < 0) and (zeUac < (zeUMinLoad - zeUThreshold))) or ((maxQacLimit < 0) and (zeUac > (zeUMinLoad - zeUThreshold)) and (zeUac < (zeUMinLoad + zeUThreshold)))) then
                  qacLimit = tonumber(maxQacLimit + quTuneStCmd)
                  if (qacLimit < -qacMaxSet) then qacLimit = -qacMaxSet end
                  if ((qacLimit < 0 and qacLimit > -1) or (qacLimit < 1 and qacLimit > 0)) then qacLimit = 0 end
                  if (case4ZEU >= caseReset) then
                     case4ZEU = 0
                     for devV in pairs(dgCtlDev) do
                        if WR.isOnline(devV) then
         			qacLimitW = (qacLimit * (qacMaxSetCmd / 100))
         			qacLimitW = tonumber(string.format("%.0f", qacLimitW))
         			WR.writeHexOpts(devV, qacLimitWrite, bit.tohex(qacLimitW,4),0x6)
                        end
                     end
                     logCsvZEU(fileNameZEU,"3.4.0"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQac..","..oldPacLimit..","..oldQacLimit..","..pacLimit..","..qacLimit..",".."")
                  else
                     case4ZEU = case4ZEU + 1
                     logCsvZEU(fileNameZEU,"3.4.1"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQac..","..oldPacLimit..","..oldQacLimit..","..pacLimit..","..qacLimit..",".."")
                  end
               elseif ((zePf <= zePfMaxCmd) and (zePf >= -zePfMaxCmd)) and (((maxQacLimit > 0) and (zeUac > (zeUMinLoad + zeUThreshold))) or ((maxQacLimit > 0) and (zeUac < (zeUMinLoad - zeUThreshold))) or ((maxQacLimit > 0) and (zeUac > (zeUMinLoad - zeUThreshold)) and (zeUac < (zeUMinLoad + zeUThreshold)))) then
                  qacLimit = tonumber(maxQacLimit - quTuneStCmd)
                  if (qacLimit > qacMaxSet) then qacLimit = qacMaxSet end
                  if ((qacLimit < 0 and qacLimit > -1) or (qacLimit < 1 and qacLimit > 0)) then qacLimit = 0 end
                  if (case4ZEU >= caseReset) then
                     case4ZEU = 0
                     for devV in pairs(dgCtlDev) do
                        if WR.isOnline(devV) then
         			qacLimitW = (qacLimit * (qacMaxSetCmd / 100))
         			qacLimitW = tonumber(string.format("%.0f", qacLimitW))
         			WR.writeHexOpts(devV, qacLimitWrite, bit.tohex(qacLimitW,4),0x6)
                        end
                     end
                     logCsvZEU(fileNameZEU,"3.4.2"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQac..","..oldPacLimit..","..oldQacLimit..","..pacLimit..","..qacLimit..",".."")
                  else
                     case4ZEU = case4ZEU + 1
                     logCsvZEU(fileNameZEU,"3.4.3"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQac..","..oldPacLimit..","..oldQacLimit..","..pacLimit..","..qacLimit..",".."")
                  end
               else
                  case4ZEU = case4ZEU + 1
                  logCsvZEU(fileNameZEU,"3.4.4"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQac..","..oldPacLimit..","..oldQacLimit..","..pacLimit..","..qacLimit..",".."")
               end
            else
               --case5ZEU = case5ZEU + 1
               case5ZEU = case5ZEU + 1
               logCsvZEU(fileNameZEU,"3.5.0"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQac..","..oldPacLimit..","..oldQacLimit..","..","..",".."")
            end
   end


---------------------- Inverter Automatic Closed Loop POWER LIMIT End -------------------------------

--------------------------------------------- Closed loop Freq Control----------------------------------------------------------------------
if ((not(is_nan(zeFac))) and (PowSelCmd == 1) and (totalInverters > 0) and (fOnOffCmd == 1) and (facOnOffCmd == 1)) then -- facOnOffCmd
            -- case 1 : Change in FAC 0.03 to 0.3 above 50Hz - Droop Control
            if ((zeFac > (zeFMinLoad + zeFThreshold)) and (zeFac <= (zeFMinLoad + zeFCriticalLoad)) and (maxPacLimit > 0) and (zeIac < zeIacSetCmd)) then
               --if ((zeFac > 50.03) and (zeFac <= 50.3) and (maxPacLimit > 0) and (zeIac < zeIacSetCmd)) then
        delF = zeFac - zeFMinLoad
       local diffdelF = delF - olddelF
        olddelF = delF
       if (diffdelF ~= 0) then
       pacLimit = ((pvPac + (((-1 * (delF) * blkPacMaxCmd) / ((zeFMinLoad * fDroopCmd)))*100)) / totalInverters) / ((100 - facGRSetCmd) / 100)
       else
       pacLimit = oldPacLimit
	   end
 -- pacLimit = ((((blkPacMaxCmd + (((-1 * (zeFac - zeFMinLoad)  / (zeFMinLoad ))* 100))/fDroopCmd)* blkPacMaxCmd)) / totalInverters) / ((100 - facGRSetCmd) / 100)
               --if ((zePac / totalInverters) < pacLimit) then pacLimit = (maxPacLimit) end -- Gain control line added
               if (pacLimit <= 0) then pacLimit = 0 end
               pacLimit = tonumber(string.format("%.0f", pacLimit))
               oldPacLimit = tonumber(string.format("%.0f", (maxPacLimit)))
               if (oldPacLimit <= pacLimit) then
                  pacLimitdel = oldPacLimit - tonumber(string.format("%.0f", (facDecConstCmd * pacMaxSetCmd / 1000)))
                  if (case1ZEF >= caseReset) then
                     case1ZEF = 0
                     for devV in pairs(dgCtlDev) do
                        if WR.isOnline(devV) then
                           if (pacLimitdel <= (pacLimit * ((100 - facGRSetCmd) / 100))) then 
						   pacLimit = (pacLimit * ((100 - facGRSetCmd) / 100)) 
						    else
								pacLimit = pacLimitdel
						   end
                           pacLimit = tonumber(string.format("%.0f", pacLimit))
                           WR.writeHexOpts(devV, pacLimitWrite, bit.tohex(pacLimit,4),0x6)
                        end
                     end
                     logCsvZEF(fileNameZEF,"4.1.0"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
                  else
                     case1ZEF = case1ZEF + 1
                     logCsvZEF(fileNameZEF,"4.1.1"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
                  end
               else
                  if (case1ZEF >= caseReset) then
                     case1ZEF = 0
                     for devV in pairs(dgCtlDev) do
                        if WR.isOnline(devV) then
                           if (pacLimit <= 0) then pacLimit = 0 end
                           pacLimit = tonumber(string.format("%.0f", pacLimit))
                           WR.writeHexOpts(devV, pacLimitWrite, bit.tohex(pacLimit,4),0x6)
                        end
                     end
                     logCsvZEF(fileNameZEF,"4.1.2"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
                  else
                     case1ZEF = case1ZEF + 1
                     logCsvZEF(fileNameZEF,"4.1.3"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
                  end
               end
               -- case 2 : Change in FAC 0.03 to 0.3 below 50Hz - Droop Control
            elseif ((zeFac < (zeFMinLoad - zeFThreshold)) and (zeFac >= (zeFMinLoad - zeFCriticalLoad)) and (minPacLimit <= pacMaxSetCmd) and (zeIac < zeIacSetCmd)) then
              olddelF = delF
							delF = zeFac - zeFMinLoad
							local diffdelF = delF - olddelF
							if (diffdelF ~= 0) then
								pacLimit = ((pvPac + (((-1 * (delF) * blkPacMaxCmd) / ((zeFMinLoad * fDroopCmd)))*100)) / totalInverters) / ((100 - facGRSetCmd) / 100)
                            else
                                pacLimit = oldPacLimit
							end
               --if ((zePac / totalInverters) > pacLimit) then pacLimit = (minPacLimit) end----Gain control line added
               if (pacLimit > pacMaxSetCmd) then pacLimit = pacMaxSetCmd end
               pacLimit = tonumber(string.format("%.0f", pacLimit))
               oldPacLimit = tonumber(string.format("%.0f", (minPacLimit)))
               if (oldPacLimit >= pacLimit) then
                  pacLimitdel = oldPacLimit + tonumber(string.format("%.0f", (facIncConstCmd * pacMaxSetCmd / 1000)))
                  if (case2ZEF >= caseReset) then
                     case2ZEF = 0
                     for devV in pairs(dgCtlDev) do
                        if WR.isOnline(devV) then
                           if (pacLimitdel >= (pacLimit / ((100 - facGRSetCmd) / 100))) then 
						       pacLimit = (pacLimit / ((100 - facGRSetCmd) / 100))
						   else
								pacLimit = pacLimitdel
						   end
                           pacLimit = tonumber(string.format("%.0f", pacLimit))
                           WR.writeHexOpts(devV, pacLimitWrite, bit.tohex(pacLimit,4),0x6)
                        end
                     end
                     logCsvZEF(fileNameZEF,"4.2.0"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
                  else
                     case2ZEF = case2ZEF + 1
                     logCsvZEF(fileNameZEF,"4.2.1"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
                  end
               else
                  if (case2ZEF >= caseReset) then
                     case2ZEF = 0
                     for devV in pairs(dgCtlDev) do
                        if WR.isOnline(devV) then
                           if (pacLimit <= 0) then pacLimit = 0 end
                           pacLimit = tonumber(string.format("%.0f", pacLimit))
                           WR.writeHexOpts(devV, pacLimitWrite, bit.tohex(pacLimit,4),0x6)
                        end
                     end
                     logCsvZEF(fileNameZEF,"4.2.2"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
                  else
                     case2ZEF = case2ZEF + 1
                     logCsvZEF(fileNameZEF,"4.2.3"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
                  end
               end
               -- case 3 : Change in FAC 0.3 to 2.5 below 50Hz - 10% to 100% PAC Increament
            elseif ((zeFac >= (zeFMinLoad - zeFLCriticalLoad)) and ((zeFac < (zeFMinLoad - zeFCriticalLoad)) and (maxPacLimit <= pacMaxSetCmd) and (zeIac < zeIacSetCmd))) then         ----less than changed to Greater than
                 olddelF = delF
				 delF = zeFac - zeFMinLoad
                 diffdelF = delF - olddelF
                 if (diffdelF ~= 0) then
                 pacLimit = tonumber(minPacLimit + (0.5 * pacMaxSetCmd))
                 else
                 pacLimit = oldPacLimit
                 end
                 pacLimit = tonumber(string.format("%.0f", pacLimit))
                 if (pacLimit >= pacMaxSetCmd) then pacLimit = pacMaxSetCmd end
                 if (case3ZEF >= caseReset) then
                    case3ZEF = 0
                    for devV in pairs(dgCtlDev) do
                       if WR.isOnline(devV) then
                          pacLimit = tonumber(string.format("%.0f", pacLimit))
                          WR.writeHexOpts(devV, pacLimitWrite, bit.tohex(pacLimit,4),0x6)
                       end
                    end
                    logCsvZEF(fileNameZEF,"4.3.0"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
                 else
                    case3ZEF = case3ZEF + 1
                    logCsvZEF(fileNameZEF,"4.3.1"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
                 end
               -- case 4 : Change in FAC 0.3 to 2 above 50Hz - 10% to 100% PAC decreament
            elseif ((zeFac <= (zeFMinLoad + zeFUCriticalLoad)) and ((zeFac > (zeFMinLoad + zeFCriticalLoad)) and (maxPacLimit <= pacMaxSetCmd) and (zeIac < zeIacSetCmd))) then         ----less than changed to Greater than
                 olddelF = delF
				 delF = zeFac - zeFMinLoad
                 diffdelF = delF - olddelF
                 if (diffdelF ~= 0) then
                 pacLimit = tonumber(minPacLimit - (0.5 * pacMaxSetCmd))
                 else
                 pacLimit = oldPacLimit
                 end
                 pacLimit = tonumber(string.format("%.0f", pacLimit))
                 if (pacLimit >= pacMaxSetCmd) then pacLimit = pacMaxSetCmd end
                 if (case3ZEF >= caseReset) then
                    case3ZEF = 0
                    for devV in pairs(dgCtlDev) do
                       if WR.isOnline(devV) then
                          pacLimit = tonumber(string.format("%.0f", pacLimit))
                          WR.writeHexOpts(devV, pacLimitWrite, bit.tohex(pacLimit,4),0x6)
                       end
                    end
                  logCsvZEF(fileNameZEF,"4.3.2"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
               else
                  case4ZEF = case4ZEF + 1
                  logCsvZEF(fileNameZEF,"4.3.3"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
               end
               -- case 5 : ZE meter > 0 & ZE meter < minload  no change
            elseif ((zeIac >= zeIacSetCmd) and (maxPacLimit < pacMaxSetCmd)) then
               if (zeIac > zeIacMaxCmd) then
                  pacLimit = tonumber(maxPacLimit - (facTuneStCmd * pacMaxSetCmd / 1000))
                  pacLimit = tonumber(string.format("%.0f", pacLimit))
                  if (case5ZEF >= caseReset) then
                     case5ZEF = 0
                     for devV in pairs(dgCtlDev) do
                        if WR.isOnline(devV) then
                           if (maxPacLimit <= 0) then pacLimit = 0 end
                           pacLimit = tonumber(string.format("%.0f", pacLimit))
                           WR.writeHexOpts(devV, pacLimitWrite, bit.tohex(pacLimit,4),0x6)
                        end
                     end
                     logCsvZEF(fileNameZEF,"4.4.0"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
                  else
                     case5ZEF = case5ZEF + 1
                     logCsvZEF(fileNameZEF,"4.4.1"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
                  end
               end
            elseif ((zeFac <= (zeFMinLoad + zeFThreshold)) and (zeFac >= (zeFMinLoad - zeFThreshold)) and (maxPacLimit <= pacMaxSetCmd) and (zeIac < zeIacSetCmd)) then         ----less than changed to Greater than
               pacLimit = tonumber(minPacLimit + (0.9 * pacMaxSetCmd))
               pacLimit = tonumber(string.format("%.0f", pacLimit))
               if (pacLimit >= pacMaxSetCmd) then pacLimit = pacMaxSetCmd end
               if (case6ZEF >= caseReset) then
                  case6ZEF = 0
                  for devV in pairs(dgCtlDev) do
                     if WR.isOnline(devV) then
                        pacLimit = tonumber(string.format("%.0f", pacLimit))
                        WR.writeHexOpts(devV, pacLimitWrite, bit.tohex(pacLimit,4),0x6)
                     end
                  end
                  logCsvZEF(fileNameZEF,"4.4.2"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
               else
                  case6ZEF = case6ZEF + 1
                  logCsvZEF(fileNameZEF,"4.4.3"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..pacLimit..","..qacLimitW..",".."")
               end
            else
               case7ZEF = case7ZEF + 1
               logCsvZEF(fileNameZEF,"4.5.0"..","..zePac..","..zeQac..","..zePf..","..zeUac..","..zeFac..","..pvPac..","..pvQacW..","..oldPacLimit..","..oldQacLimitW..","..","..",".."")
            end
         end
      end
	    -- add "FUH" function immediately:
  WR.addFieldUpdateHookFunction(dev, "ZE_PAC", ampZE01FUHF);

  -- and save for repeated registration on later call of "initialize":
  WR.addInitHookFunction(
    function (nExpected)
      WR.addFieldUpdateHookFunction(dev, "ZE_PAC", ampZE01FUHF);
    end
  )
 end
end

