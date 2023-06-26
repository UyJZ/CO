#include<stdio.h>
int sum = 0,res = 0;
int num = 0;
int ans[1000];
void dfs(int a) {
	if(a != 0) {
		ans[num++] = a;
		sum += a;
	}
	if(sum == res) {
		int i;
		printf("%d = ",res);
		for(i = 0; i < num; i++) {
			printf("%d ",ans[i]);
			if(i != num - 1)
				printf("+ ");
			else
				printf("\n");
		}
	} else if(sum < res) {
		int x;
		for(x = a; x <= res - sum; x++) {
			if(x!=0) {
				dfs(x);
				num--;
				sum -= x;
			}
		}
	}
}
int main() {
	scanf("%d",&res);
	dfs(0);
	return 0;
}
