#include <stdio.h>
int main()
{
	char st[1000500];
	int i = 0;
	int k = 0;
	for(k=1;k<1000000;k++)
	{
		if (i >= 1000001)
			break;
		char buf[15];
		sprintf(&buf,"%d",k);
		int j = 0;
		while(buf[j])
			st[i++]=buf[j++];
	}
	int prod=1;
	int c = 1;
	for(i=0;i<7;i++)
	{
		prod*=(st[c-1]-48);
		c*=10;
	}
	printf("%d\n",prod);
}
