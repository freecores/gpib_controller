/*
 * GpibRegAccess.h
 *
 *  Created on: 2012-01-28
 *      Author: Andrzej Paluch
 */

#ifndef GPIB_REGACCESS_H_
#define GPIB_REGACCESS_H_

#include "GpibTypes.h"

/** Register access structure. */
struct GpibRegAccess
{
	HandleType portHandle;
	bool isBurstMode;
};

/** Initializes register access. */
bool GpibRegAccess_init(struct GpibRegAccess *ra);

/** Releases register access. */
void GpibRegAccess_release(struct GpibRegAccess *ra);

/** Reads register. */
bool GpibRegAccess_readReg(struct GpibRegAccess *ra, SizeType addr, RegType *pValue);

/** Reads register repeatedly. */
bool GpibRegAccess_repeatedlyRead(struct GpibRegAccess *ra, SizeType addr,
		char *buf, SizeType bufLen);

/** Writes register. */
bool GpibRegAccess_writeReg(struct GpibRegAccess *ra, SizeType addr, RegType value);

/** Writes register repeatedly. */
bool GpibRegAccess_repeatedlyWrite(struct GpibRegAccess *ra, SizeType addr,
		char *buf, SizeType bufLen);

#endif /* GPIB_REGACCESS_H_ */
