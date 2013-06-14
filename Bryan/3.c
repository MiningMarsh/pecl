#include <stdio.h>
#include <sys/time.h>
struct timeval start;
struct timeval end;
int main()
{
	long long unsigned int num = 600851475143;
	long long unsigned int i = 1;
	long long unsigned int upb;
	long long unsigned int nums[10000];
	short index = 0;
	gettimeofday(&start,NULL);
	for(;;)
	{
		upb = sqrt(num);
		if(!(num % i))
		{
			nums[index++]=i;
			num /= i;
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
	printf("%lld\n",elapsed);
}
