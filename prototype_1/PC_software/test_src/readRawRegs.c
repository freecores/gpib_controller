/*
 ============================================================================
 Name        : GPIB_access.c
 Author      : apaluch
 Version     :
 Copyright   : Your copyright notice
 Description : Hello World in C, Ansi-style
 ============================================================================
 */

#include <stdio.h>
#include <stdlib.h>

#include "GpibRegAccess.h"

#define CHECK(x) if(!(x)) goto error;

int rawRegAccessMain(int argc, char* argv[]) {

	printf("start\n");

	struct GpibRegAccess ra;

	CHECK(GpibRegAccess_init(&ra));

	RegType value, value1;
	unsigned int tempInt;
	SizeType regAddr = 1;

	char chr;

	do
	{
		chr = getchar();

		value = 0;
		value1 = 0;

		if(chr != 'e')
		{
			if(chr == 'r')
			{
				scanf("%u", &regAddr);
				CHECK(GpibRegAccess_readReg(&ra, regAddr, &value));
				printf("\n%x\n", value);
			}
			else if(chr == 'w')
			{
				scanf("%u", &regAddr);
				scanf("%x", &tempInt);

				value = tempInt;

				//printf("\n%u %u\n", regAddr, value);

				CHECK(GpibRegAccess_writeReg(&ra, regAddr, value));
			}
			else if(chr == 'a')
			{
				scanf("%u", &regAddr);
				scanf("%x", &tempInt);

				value = tempInt;

				//printf("\n%u %u\n", regAddr, value);

				CHECK(GpibRegAccess_readReg(&ra, regAddr, &value1));
				CHECK(GpibRegAccess_writeReg(&ra, regAddr, value & value1));
			}
			else if(chr == 'o')
			{
				scanf("%u", &regAddr);
				scanf("%x", &tempInt);

				value = tempInt;

				//printf("\n%u %u\n", regAddr, value);

				CHECK(GpibRegAccess_readReg(&ra, regAddr, &value1));
				CHECK(GpibRegAccess_writeReg(&ra, regAddr, value | value1));
			}
		}
		else
		{
			break;
		}
	}
	while(true);

	GpibRegAccess_release(&ra);

	printf("end\n");

	return 0;

	error:
		printf("error");
		GpibRegAccess_release(&ra);
		return -1;
}
