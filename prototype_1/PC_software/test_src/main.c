#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "GpibRegAccess.h"


#define CHECK(x) if(!(x)) goto error;

extern int gpibExplorerMain(int argc, char* argv[]);
extern int rawRegAccessMain(int argc, char* argv[]);
extern int listenOnlyMain(int argc, char* argv[]);
extern int HiSlipGpibMain(int argc, char* argv[]);


int main(int argc, char *argv[]) {

	if(argc == 2)
	{
		if(strstr(argv[1], "ge"))
		{
			return gpibExplorerMain(argc, argv);
		} else if(strstr(argv[1], "rra"))
		{
			return rawRegAccessMain(argc, argv);
		} else if(strstr(argv[1], "lo"))
		{
			return listenOnlyMain(argc, argv);
		} else if(strstr(argv[1], "hsrv"))
		{
			return HiSlipGpibMain(argc, argv);
		}
	}

	return 1;
}
