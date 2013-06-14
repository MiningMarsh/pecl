#include <stdio.h>
#include <math.h>
#include <sys/time.h>
struct timeval start;
struct timeval end;
int main()
{
	long long unsigned int num = 600851475143;
	long long unsigned int i = 1;
	long long unsigned int upb= sqrt(num);
	long long unsigned int nums[10000];
	short index = 0;
	gettimeofday(&start,NULL);
	for(;;)
	{
		if(!(num % i))
		{
			upb = sqrt(num);
			nums[index++]=i;
			num /= i;
			i=1;
		}
		if (i > upb)
		{
			nums[index++]=num;
			break;
		}
		i++;
	}
	long long unsigned int max = 0;
	for(i=0;i<index;i++)
	{
		if(nums[i]>max)
			max=nums[i];
	}
	printf("%llu\n",max);
	gettimeofday(&end,NULL);
	long long elapsed = -1000000 * start.tv_sec - start.tv_usec + 1000000*end.tv_sec + end.tv_usec;
	printf("Microseconds elapsed: %lld\n",elapsed);
}
