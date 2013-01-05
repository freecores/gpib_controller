/*
 * GpibHwAdapter.c
 *
 *  Created on: 2012-01-29
 *      Author: Andrzej Paluch
 */

#include "GpibHwAdapter.h"


bool GpibHwAdapter_init(struct GpibHwAdapter *ghwa,
		struct GpibRegAccess *regAccess, AddrType baseAddr)
{
	ghwa->regAccess = regAccess;
	ghwa->baseAddr = baseAddr;

	return true;
}

void GpibHwAdapter_release(struct GpibHwAdapter *ghwa)
{
	// do nothing
}






