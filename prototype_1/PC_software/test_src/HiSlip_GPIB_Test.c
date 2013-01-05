
#include <string.h>
#include <stdio.h>

#include <unistd.h>

#include "common_types.h"

#include "GpibRegAccess.h"
#include "GpibHwAdapter.h"
#include "GpibHw.h"

#include "HiSlipServer.h"



void deviceToWrite(struct GpibHw *gpib, struct GpibHwAdapter *ghw);
void deviceToRead(struct GpibHw *gpib, struct GpibHwAdapter *ghw);



void HiSlipTest_beginExclusiveAccess(HiSlipResource *resource);
void HiSlipTest_endExclusiveAccess(HiSlipResource *resource);
void HiSlipTest_writeData(HiSlipResource *resource,
	u8 *buf, u32 len, bool rmt, u32 msgId);
HiSlipIoResult HiSlipTest_waitDataAvailable(
	HiSlipResource *resource, u32 *lenHi, u32 *lenLo, bool *rmt);
HiSlipIoResult HiSlipTest_readData(HiSlipResource *resource,
		u32 maxLenHi, u32 maxLenLo, u8 **pBuf, u32 *len);


bool isDeviceToWrite, isDeviceToRead;
struct GpibHwAdapter ghw;
struct GpibHw gpib;
/** Exclusive access CS */
HiSlipCriticalSection accessCriticalSection;


int HiSlipGpibMain(int argc, char* argv[])
{
	HiSlipServer hSrv;
	HiSlipApplication app;
	HiSlipResourceRoutines routines;

	bool status;

	struct GpibRegAccess ra;


	RegType regVal;

	GpibRegAccess_init(&ra);
	GpibHwAdapter_init(&ghw, &ra, 0);
	GpibHw_init(&gpib, &ghw);

	struct GpibHwSettings gs;
	// set T1
	GpibHw_getSettings(&gpib, &gs);
	gs.T1 = 132;
	GpibHw_setSettings(&gpib, &gs);

	// request system control
	GpibHw_requestSystemControl(&gpib, 1);

	// go to standby
	GpibHw_goToStandby(&gpib, 0);
	GpibHw_takeControlAsynchronously(&gpib, 1);

	// system interface clear
	GpibHw_systemInterfaceClear(&gpib, 1);

	// remote enable
	GpibHw_sendRemoteEnable(&gpib, 1);

	do
	{
		GpibHwAdapter_getReg(&ghw, REG_ADDR_GPIB_STATUS, &regVal);
	}
	while(!GpibHwAdapter_getBitValue(regVal, MASK_GPIB_STATUS_cwrc));


	GpibHw_systemInterfaceClear(&gpib, 0);

	GpibHw_takeControlAsynchronously(&gpib, 0);

	do
	{
		GpibHwAdapter_getReg(&ghw, REG_ADDR_EVENT, &regVal);
	}
	while(GpibHwAdapter_getBitValue(regVal, MASK_EVENT_IFC));


	isDeviceToWrite = false;
	isDeviceToRead = false;

	// configure HiSlip

	status = HiSlipCriticalSection_init(&(accessCriticalSection));

	HiSlipApplication_init(&app);
	app.isOverlappedMode = false;
	app.vendorId = 0xBACD;
	app.waitForAsyncConnectionTimeout = 1000;
	app.readDataTimeout = 1000;
	app.maxMsgSizeHi = 0;
	app.maxMsgSizeLo = 1000;
	app.maxSessions = 3;

	// initialize routines
	memset(&routines, 0, sizeof(HiSlipResourceRoutines));
	routines.beginExclusiveAccess = HiSlipTest_beginExclusiveAccess;
	routines.endExclusiveAccess = HiSlipTest_endExclusiveAccess;
	routines.writeData = HiSlipTest_writeData;
	routines.waitDataAvailable = HiSlipTest_waitDataAvailable;
	routines.readData = HiSlipTest_readData;

	HiSlipApplication_registerResource(&app, "hislip0", &routines,
		1, NULL_PTR);

	status = HiSlipServer_init(&hSrv, &app);

	if(status)
	{
		status = HiSlipServer_start(&hSrv);
	}

	while(hSrv.started)
	{
		sleep(100);
	}

	// remote disable
	GpibHw_sendRemoteEnable(&gpib, 0);

	HiSlipApplication_release(&app);

	GpibHw_release(&gpib);
	GpibHwAdapter_release(&ghw);
	GpibRegAccess_release(&ra);

	return 0;
}

void deviceToRead(struct GpibHw *gpib, struct GpibHwAdapter *ghw)
{
	RegType regVal;
	char buf[10];
	u32 bytesWritten;
	// write command
	int cmdLen = 2;

	if(!isDeviceToRead)
	{
		GpibHw_takeControlAsynchronously(gpib, 1);

		do
		{
			GpibHwAdapter_getReg(ghw, REG_ADDR_GPIB_STATUS, &regVal);
		}
		while(!GpibHwAdapter_getBitValue(regVal, MASK_GPIB_STATUS_cwrc));

		GpibHw_takeControlAsynchronously(gpib, 0);

		buf[0] = 0x22;
		buf[1] = 0x41;

		bytesWritten = 0;

		do
		{
			GpibHw_write(gpib, buf + bytesWritten, cmdLen - bytesWritten,
					&bytesWritten, false);
		}
		while(bytesWritten < cmdLen);

		do
		{
			GpibHwAdapter_getReg(ghw, REG_ADDR_WRITER_CONTROL_1, &regVal);
		}
		while(GpibHwAdapter_getFieldValue(regVal, MASK_WRITER_CONTROL_1_bytesInFifo) > 0);


		// go to standby
		GpibHw_goToStandby(gpib, 1);

		do
		{
			GpibHwAdapter_getReg(ghw, REG_ADDR_GPIB_STATUS, &regVal);
		}
		while(!GpibHwAdapter_getBitValue(regVal, MASK_GPIB_STATUS_cwrd));

		GpibHw_goToStandby(gpib, 0);

		// clear input buffer


		isDeviceToRead = true;
		isDeviceToWrite = false;
	}
}

void deviceToWrite(struct GpibHw *gpib, struct GpibHwAdapter *ghw)
{
	RegType regVal;
	char buf[10];
	u32 bytesWritten;
	// write command
	int cmdLen = 2;

	if(!isDeviceToWrite)
	{
		GpibHw_takeControlAsynchronously(gpib, 1);

		do
		{
			GpibHwAdapter_getReg(ghw, REG_ADDR_GPIB_STATUS, &regVal);
		}
		while(!GpibHwAdapter_getBitValue(regVal, MASK_GPIB_STATUS_cwrc));

		GpibHw_takeControlAsynchronously(gpib, 0);

		buf[0] = 0x21;
		buf[1] = 0x42;

		bytesWritten = 0;

		do
		{
			GpibHw_write(gpib, buf + bytesWritten, cmdLen - bytesWritten,
					&bytesWritten, false);
		}
		while(bytesWritten < cmdLen);

		do
		{
			GpibHwAdapter_getReg(ghw, REG_ADDR_WRITER_CONTROL_1, &regVal);
		}
		while(GpibHwAdapter_getFieldValue(regVal, MASK_WRITER_CONTROL_1_bytesInFifo) > 0);


		// go to standby
		GpibHw_goToStandby(gpib, 1);

		do
		{
			GpibHwAdapter_getReg(ghw, REG_ADDR_GPIB_STATUS, &regVal);
		}
		while(!GpibHwAdapter_getBitValue(regVal, MASK_GPIB_STATUS_cwrd));

		GpibHw_goToStandby(gpib, 0);

		isDeviceToWrite = true;
		isDeviceToRead = false;
	}
}

void HiSlipTest_beginExclusiveAccess(HiSlipResource *resource)
{
	HiSlipCriticalSection_enter(&(accessCriticalSection));
}

void HiSlipTest_endExclusiveAccess(HiSlipResource *resource)
{
	HiSlipCriticalSection_leave(&(accessCriticalSection));
}

void HiSlipTest_writeData(HiSlipResource *resource,
	u8 *buf, u32 len, bool rmt, u32 msgId)
{
	SizeType bytesWritten;
	RegType regVal;

	deviceToRead(&gpib, &ghw);

	// write data
	bytesWritten = 0;
	u32 tmpBytesWritten;

	do
	{
		GpibHw_write(&gpib, (char*)buf + bytesWritten, len - bytesWritten,
				&tmpBytesWritten, rmt);
		bytesWritten += tmpBytesWritten;
	}
	while(bytesWritten < len);

	do
	{
		GpibHwAdapter_getReg(&ghw, REG_ADDR_WRITER_CONTROL_1, &regVal);
	}
	while(GpibHwAdapter_getFieldValue(regVal, MASK_WRITER_CONTROL_1_bytesInFifo) > 0);
}

char gpib_buf[2048];
u32 gpib_buf_cnt = 0;
u32 gpib_buf_offset = 0;
bool gpib_buf_endOfStream;
// TODO - not correct
HiSlipIoResult HiSlipTest_waitDataAvailable(
	HiSlipResource *resource, u32 *lenHi, u32 *lenLo, bool *rmt)
{
	SizeType bytesRead;
	bool endOfStream;

	deviceToWrite(&gpib, &ghw);

	int timeout = 0;
	const int TIMEOUT = 1000;
	bool timeoutOccured = false;

	if(gpib_buf_cnt > 0)
	{
		*lenHi = 0;
		*lenLo = gpib_buf_cnt;
		*rmt = gpib_buf_endOfStream;

		return HiSlipIoResult_OK;
	}

	// read data
	do
	{
		GpibHw_read(&gpib, gpib_buf, 2047, &bytesRead, &endOfStream);

		if(bytesRead > 0)
		{
			gpib_buf[bytesRead] = 0;
			timeout = 0;
		}

		timeout ++;

		if(bytesRead == 0)
		{
			usleep(10000);
		}

		if(timeout > TIMEOUT)
		{
			timeoutOccured = true;
			break;
		}
	}
	while(bytesRead == 0 && !timeoutOccured);

	*lenHi = 0;
	*lenLo = bytesRead;
	*rmt = endOfStream;
	gpib_buf_endOfStream = endOfStream;
	gpib_buf_cnt = bytesRead;
	gpib_buf_offset = 0;

	if(timeoutOccured)
	{
		return HiSlipIoResult_TIMEOUT;
	}
	else
	{
		return HiSlipIoResult_OK;
	}
}

// TODO - not correct
HiSlipIoResult HiSlipTest_readData(HiSlipResource *resource,
		u32 maxLenHi, u32 maxLenLo, u8 **pBuf, u32 *len)
{
	*pBuf = (u8*)gpib_buf + gpib_buf_offset;
	*len = maxLenLo;

	gpib_buf_offset += maxLenLo;
	gpib_buf_cnt -= maxLenLo;

	return HiSlipIoResult_OK;
}


