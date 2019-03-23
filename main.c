#include <stdio.h>
#include <mach/mach_time.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>

static uint64_t freq_num = 0;
static uint64_t freq_denom = 0;

void init_clock_frequency()
{
  mach_timebase_info_data_t tb;

  if (mach_timebase_info(&tb) == KERN_SUCCESS && tb.denom != 0)
  {
    freq_num = (uint64_t)tb.numer;
    freq_denom = (uint64_t)tb.denom;
  }
}
static int
ranges(uint8_t x)
{
  int y = 0;
  if (
      (x >= 3 && x <= 8) ||
      (x >= 11 && x <= 17) ||
      (x >= 19 && x <= 21) ||
      (x >= 22 && x <= 29) ||
      (x >= 31 && x <= 33) ||
      (x >= 47 && x <= 51) ||
      (x >= 59 && x <= 61) ||
      (x >= 68 && x <= 81) ||
      (x >= 84 && x <= 93) ||
      (x >= 95 && x <= 97) ||
      (x >= 99 && x <= 117) ||
      (x >= 124 && x <= 133) ||
      (x >= 142 && x <= 167) ||
      (x >= 189 && x <= 199) ||
      (x >= 211 && x <= 243) ||
      (x >= 245 && x <= 251))
  {
    y = 1;
  }
  return y;
}

static int
ranges2(uint8_t x)
{
  int y = 0;
  if (
      (x >= 3 && x <= 8) ||
      (x >= 11 && x <= 17) ||
      (x >= 19 && x <= 21) ||
      (x >= 22 && x <= 29) ||
      (x >= 31 && x <= 33) ||
      (x >= 47 && x <= 51) ||
      (x >= 59 && x <= 61) ||
      (x >= 68 && x <= 81) ||
      (x >= 84 && x <= 93) ||
      (x >= 95 && x <= 97) ||
      (x >= 99 && x <= 117) ||
      (x >= 124 && x <= 133) ||
      (x >= 142 && x <= 167) ||
      (x >= 189 && x <= 199) ||
      (x >= 211 && x <= 243) ||
      (x >= 245 && x <= 251))
  {
    y = 1;
  }
  return y;
}

int main(int argc, char **argv)
{
  init_clock_frequency();
  unsigned int seed = (unsigned int)atoi(argv[1]);
  int iters = atoi(argv[2]);
  srand(seed);
  int sum1 = 0;
  int sum2 = 0;
  uint64_t t1 = 0;
  uint64_t t2 = 0;
  uint64_t t0 = 0;
  for (int i = 0; i < iters; i++)
  {
    uint8_t x = rand() % 256;

    t0 = mach_absolute_time();
    sum1 += ranges(x);
    t1 += mach_absolute_time() - t0;

    t0 = mach_absolute_time();
    sum2 += ranges2(x);
    t2 += mach_absolute_time() - t0;
  }
  printf("sum1=%d t1=%llu\n", sum1, t1);
  printf("sum2=%d t2=%llu %f\n", sum2, t2, (double)t2 / (double)t1 - 1.0);
  return 0;
}