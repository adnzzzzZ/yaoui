
--proc/comdlg: common dialogs
--Written by Cosmin Apreutesei. Public Domain.

local yui_path = (...):match('(.-)[^%.]+$')
setfenv(1, require(yui_path:sub(1, -2)))
require(yui_path .. 'winuser')

comdlg = ffi.load'comdlg32'

COMMDLG_ERROR_NAMES = constants{
	CDERR_DIALOGFAILURE     = 0xFFFF,
	CDERR_GENERALCODES      = 0x0000,
	CDERR_STRUCTSIZE        = 0x0001,
	CDERR_INITIALIZATION    = 0x0002,
	CDERR_NOTEMPLATE        = 0x0003,
	CDERR_NOHINSTANCE       = 0x0004,
	CDERR_LOADSTRFAILURE    = 0x0005,
	CDERR_FINDRESFAILURE    = 0x0006,
	CDERR_LOADRESFAILURE    = 0x0007,
	CDERR_LOCKRESFAILURE    = 0x0008,
	CDERR_MEMALLOCFAILURE   = 0x0009,
	CDERR_MEMLOCKFAILURE    = 0x000A,
	CDERR_NOHOOK            = 0x000B,
	CDERR_REGISTERMSGFAIL   = 0x000C,
	PDERR_PRINTERCODES      = 0x1000,
	PDERR_SETUPFAILURE      = 0x1001,
	PDERR_PARSEFAILURE      = 0x1002,
	PDERR_RETDEFFAILURE     = 0x1003,
	PDERR_LOADDRVFAILURE    = 0x1004,
	PDERR_GETDEVMODEFAIL    = 0x1005,
	PDERR_INITFAILURE       = 0x1006,
	PDERR_NODEVICES         = 0x1007,
	PDERR_NODEFAULTPRN      = 0x1008,
	PDERR_DNDMMISMATCH      = 0x1009,
	PDERR_CREATEICFAILURE   = 0x100A,
	PDERR_PRINTERNOTFOUND   = 0x100B,
	PDERR_DEFAULTDIFFERENT  = 0x100C,
	CFERR_CHOOSEFONTCODES   = 0x2000,
	CFERR_NOFONTS           = 0x2001,
	CFERR_MAXLESSTHANMIN    = 0x2002,
	FNERR_FILENAMECODES     = 0x3000,
	FNERR_SUBCLASSFAILURE   = 0x3001,
	FNERR_INVALIDFILENAME   = 0x3002,
	FNERR_BUFFERTOOSMALL    = 0x3003,
	FRERR_FINDREPLACECODES  = 0x4000,
	FRERR_BUFFERLENGTHZERO  = 0x4001,
	CCERR_CHOOSECOLORCODES  = 0x5000,
}

ffi.cdef[[
DWORD  CommDlgExtendedError(void);
]]

CommDlgExtendedError = comdlg.CommDlgExtendedError

function checkcomdlg(ret)
	if ret == 0 then
		local err = CommDlgExtendedError()
		assert(err == 0, 'comdlg32 error: %s', COMMDLG_ERROR_NAMES[err])
		return false --user canceled
	end
	return true
end

