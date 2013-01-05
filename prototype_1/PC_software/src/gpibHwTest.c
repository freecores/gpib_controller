
#include <string.h>
#include <stdio.h>

#include <unistd.h>

#include "RegAccess.h"
#include "GpibHw.h"


int main(int argc, char* argv[])
{
	useconds_t sleep_time = 5000;

	struct RegAccess ra;
	struct GpibHw ghw;

	RegAccess_init(&ra);
	GpibHw_init(&ghw, &ra, 0);

	RegType reg;
	char *buf;
	char readBuf[1024];
	unsigned int i;

	// set T1 and address
	GpibHw_setReg(&ghw, REG_ADDR_SETTING_1, 0xfe1);

	usleep(sleep_time);

	GpibHw_getReg(&ghw, REG_ADDR_CONTROL, &reg);
	GpibHw_setBitValue(reg, MASK_CONTROL_rsc, 1);
	GpibHw_setReg(&ghw, REG_ADDR_CONTROL, reg);

	usleep(sleep_time);

	GpibHw_getReg(&ghw, REG_ADDR_CONTROL, &reg);
	GpibHw_setBitValue(reg, MASK_CONTROL_sic, 1);
	GpibHw_setReg(&ghw, REG_ADDR_CONTROL, reg);

	usleep(sleep_time);

	GpibHw_getReg(&ghw, REG_ADDR_CONTROL, &reg);
	GpibHw_setBitValue(reg, MASK_CONTROL_sic, 0);
	GpibHw_setReg(&ghw, REG_ADDR_CONTROL, reg);

	while(true)
	{
		usleep(sleep_time);

		GpibHw_setReg(&ghw, REG_ADDR_WRITER_CONTROL_0, 0x2);
		GpibHw_setReg(&ghw, REG_ADDR_WRITER_FIFO, 0x41);
		GpibHw_setReg(&ghw, REG_ADDR_WRITER_FIFO, 0x22);

		usleep(sleep_time);

		// gts
		GpibHw_getReg(&ghw, REG_ADDR_CONTROL, &reg);
		GpibHw_setBitValue(reg, MASK_CONTROL_gts, 1);
		GpibHw_setReg(&ghw, REG_ADDR_CONTROL, reg);

		usleep(sleep_time);

		GpibHw_setReg(&ghw, REG_ADDR_WRITER_CONTROL_0, 0);

		//buf = "BELl";
		//buf = "CLEARMenu";
		//buf = "APPMenu ACTivate";
		//buf = "*IDN?";
		//buf = "*LRN?";

		scanf("%s", readBuf);

		if(strlen(readBuf) == 1 && readBuf[0] == 'e')
		{
			break;
		}

		buf = readBuf;

		for(i=0; i<strlen(buf); i++)
		{
			GpibHw_setReg(&ghw, REG_ADDR_WRITER_FIFO, buf[i]);
		}

		GpibHw_setReg(&ghw, REG_ADDR_WRITER_FIFO, 0xa);

		usleep(sleep_time);

		// end of stream
		GpibHw_setReg(&ghw, REG_ADDR_WRITER_CONTROL_0, 4);

		usleep(sleep_time);

		// writer enable
		GpibHw_setReg(&ghw, REG_ADDR_WRITER_CONTROL_0, 6);

		usleep(sleep_time);

		// writer reset
		GpibHw_setReg(&ghw, REG_ADDR_WRITER_CONTROL_0, 8);

		// take control
		GpibHw_getReg(&ghw, REG_ADDR_CONTROL, &reg);
		GpibHw_setBitValue(reg, MASK_CONTROL_tca, 1);
		GpibHw_setBitValue(reg, MASK_CONTROL_gts, 0);
		GpibHw_setReg(&ghw, REG_ADDR_CONTROL, reg);

		usleep(sleep_time);

		GpibHw_getReg(&ghw, REG_ADDR_CONTROL, &reg);
		GpibHw_setBitValue(reg, MASK_CONTROL_tca, 0);
		GpibHw_setReg(&ghw, REG_ADDR_CONTROL, reg);

		usleep(sleep_time);

		GpibHw_setReg(&ghw, REG_ADDR_WRITER_CONTROL_0, 0x2);
		GpibHw_setReg(&ghw, REG_ADDR_WRITER_FIFO, 0x42);
		GpibHw_setReg(&ghw, REG_ADDR_WRITER_FIFO, 0x21);

		GpibHw_setReg(&ghw, REG_ADDR_READER_CONTROL_0, 8);

		usleep(sleep_time);

		// gts
		GpibHw_getReg(&ghw, REG_ADDR_CONTROL, &reg);
		GpibHw_setBitValue(reg, MASK_CONTROL_gts, 1);
		GpibHw_setReg(&ghw, REG_ADDR_CONTROL, reg);

		usleep(200000);

		unsigned int bufPos = 0;
		RegType len;

		do
		{
			GpibHw_getReg(&ghw, REG_ADDR_READER_CONTROL_1, &len);

			if(len > 0)
			{
				for(i=bufPos; i<len+bufPos; i++)
				{
					GpibHw_getReg(&ghw, REG_ADDR_READER_FIFO, &reg);
					readBuf[i] = reg;
				}

				bufPos += len;
			}
		}
		while(len > 0);

		readBuf[bufPos] = 0;

		printf("%s\n", readBuf);

		GpibHw_getReg(&ghw, REG_ADDR_CONTROL, &reg);
		GpibHw_setBitValue(reg, MASK_CONTROL_tca, 1);
		GpibHw_setBitValue(reg, MASK_CONTROL_gts, 0);
		GpibHw_setReg(&ghw, REG_ADDR_CONTROL, reg);

		usleep(sleep_time);

		GpibHw_getReg(&ghw, REG_ADDR_CONTROL, &reg);
		GpibHw_setBitValue(reg, MASK_CONTROL_tca, 0);
		GpibHw_setReg(&ghw, REG_ADDR_CONTROL, reg);
	}

	GpibHw_release(&ghw);
	RegAccess_release(&ra);

	return 0;
}
