#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>

static int
ranges(uint16_t x)
{
  int y = 0;
  if (
      (x >= 300 && x <= 800) ||
      (x >= 1100 && x <= 1700) ||
      (x >= 1900 && x <= 2100) ||
      (x >= 2200 && x <= 2900) ||
      (x >= 3100 && x <= 3300) ||
      (x >= 4700 && x <= 5100) ||
      (x >= 5900 && x <= 6100) ||
      (x >= 6800 && x <= 8100) ||
      (x >= 8400 && x <= 9300) ||
      (x >= 9500 && x <= 9700) ||
      (x >= 9900 && x <= 11700) ||
      (x >= 12400 && x <= 13300) ||
      (x >= 14200 && x <= 16700) ||
      (x >= 18900 && x <= 19900) ||
      (x >= 21100 && x <= 24300) ||
      (x >= 24500 && x <= 25100))
  {
    y = 1;
  }
  return y;
}

static int
ranges2(uint16_t x)
{
  int y = 0;
  if (
      (x >= 300 && x <= 800) ||
      (x >= 1100 && x <= 1700) ||
      (x >= 1900 && x <= 2100) ||
      (x >= 2200 && x <= 2900) ||
      (x >= 3100 && x <= 3300) ||
      (x >= 4700 && x <= 5100) ||
      (x >= 5900 && x <= 6100) ||
      (x >= 6800 && x <= 8100) ||
      (x >= 8400 && x <= 9300) ||
      (x >= 9500 && x <= 9700) ||
      (x >= 9900 && x <= 11700) ||
      (x >= 12400 && x <= 13300) ||
      (x >= 14200 && x <= 16700) ||
      (x >= 18900 && x <= 19900) ||
      (x >= 21100 && x <= 24300) ||
      (x >= 24500 && x <= 25100))
  {
    y = 1;
  }
  return y;
}

int main(int argc, char **argv)
{
  unsigned int seed = (unsigned int)atoi(argv[1]);
  int iters = atoi(argv[2]);
  int chksum1 = 0;
  int chksum2 = 0;
  uint64_t t1 = 0;
  uint64_t t2 = 0;
  struct timeval now, endtime;

  srand(seed);
  gettimeofday(&now, NULL);
  for (int i = 0; i < iters; i++)
  {
    uint16_t x = (uint16_t)rand();
    chksum1 += ranges(x);
  }
  gettimeofday(&endtime, NULL);
  t1 = (endtime.tv_sec * 1000000 + endtime.tv_usec) - (now.tv_sec * 1000000 + now.tv_usec);

  srand(seed);
  gettimeofday(&now, NULL);
  for (int i = 0; i < iters; i++)
  {
    uint16_t x = (uint16_t)rand();
    chksum2 += ranges2(x);
  }
  gettimeofday(&endtime, NULL);
  t2 = (endtime.tv_sec * 1000000 + endtime.tv_usec) - (now.tv_sec * 1000000 + now.tv_usec);

  if (chksum1 != chksum2)
  {
    printf("Bug! %d != %d\n", chksum1, chksum2);
    exit(0);
  }
  printf("Compiler.............: %llu ms\n", t1);
  printf("Hand-crafted LLVMIR..: %llu ms (%f)\n", t2, (double)t2 / (double)t1 - 1.0);
  return 0;
}