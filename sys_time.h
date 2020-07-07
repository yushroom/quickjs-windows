#ifndef SYS_TIME_H
#define SYS_TIME_H

typedef struct timeval {
    long tv_sec;
    long tv_usec;
} timeval;

struct timezone {
	int tz_minuteswest;     /* minutes west of Greenwich */
	int tz_dsttime;         /* type of DST correction */
};

int gettimeofday(struct timeval *tv, struct timezone *tz);

#endif