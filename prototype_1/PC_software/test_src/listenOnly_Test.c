
#include <string.h>
#include <stdio.h>
#include <time.h>

#include <unistd.h>

#include "GpibRegAccess.h"
#include "GpibHwAdapter.h"
#include "GpibHw.h"


int listenOnlyMain(int argc, char* argv[])
{
	struct GpibRegAccess ra;
	struct GpibHwAdapter ghw;
	struct GpibHw gpib;

	time_t rawtime;
	struct tm * timeinfo;

	GpibRegAccess_init(&ra);
	GpibHwAdapter_init(&ghw, &ra, 0);
	GpibHw_init(&gpib, &ghw);

	struct GpibHwSettings gs;
	// set listen only
	// set T1
	GpibHw_getSettings(&gpib, &gs);
	gs.T1 = 132;
	gs.listenOnly = true;
	GpibHw_setSettings(&gpib, &gs);

	char buf[2048];
	SizeType bytesRead;
	bool endOfStream;
	int i;
	char fileName[1024];
	bool fileAllocated;
	FILE *file;


	while(true){
		sprintf(fileName, "/home/andrzej/Downloads/TDS420/img%u.tiff", i);
		fileAllocated = false;

		do
		{
			GpibHw_read(&gpib, buf, 2048, &bytesRead, &endOfStream);

			if(bytesRead > 0)
			{
				if(!fileAllocated)
				{
					file = fopen(fileName, "wb");
					fileAllocated = true;
					rawtime = time (0);
					timeinfo = localtime ( &rawtime );
					printf ( "Start time: %s\n", asctime (timeinfo) );
				}

				fwrite(buf, 1, bytesRead, file);
			}
		}
		while(!endOfStream);

		rawtime = time (0);
		timeinfo = localtime ( &rawtime );
		printf ( "Stop time: %s\n", asctime (timeinfo) );

		fclose(file);
		i++;
	}

	GpibHw_release(&gpib);
	GpibHwAdapter_release(&ghw);
	GpibRegAccess_release(&ra);

	return 0;
}
