#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>

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
    uint8_t x = rand() % 256;
    chksum1 += ranges(x);
  }
  gettimeofday(&endtime, NULL);
  t1 = (endtime.tv_sec * 1000000 + endtime.tv_usec) - (now.tv_sec * 1000000 + now.tv_usec);

  srand(seed);
  gettimeofday(&now, NULL);
  for (int i = 0; i < iters; i++)
  {
    uint8_t x = rand() % 256;
    chksum2 += ranges2(x);
  }
  gettimeofday(&endtime, NULL);
  t2 = (endtime.tv_sec * 1000000 + endtime.tv_usec) - (now.tv_sec * 1000000 + now.tv_usec);

  if (chksum1 != chksum2)
  {
    printf("%d != %d", chksum1, chksum2);
    //    exit(0);
  }
  printf("Compiler.............: %llu ms\n", t1);
  printf("Hand-crafted LLVMIR..: %llu ms (%f)\n", t2, (double)t2 / (double)t1 - 1.0);
  return 0;
}