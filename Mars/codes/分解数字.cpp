#include<stdio.h>
int sum = 0,res = 0;
int num = 0;
int a[1000];
void dfs(int a){
	if(sum == res){
		int i;
		printf("%d = ",res);
		for(i = 0;i < num;i++){
			printf("%d ",a[i]);
			if(i != num - 1)
			printf("+");
			else
			printf("\n");
		}
	}else if(sum < res){
		int x;
		for(x = a;x < res - sum;x++){
			a[num++] = x;
			sum += x;
			dfs(x);
			num--;
			sum -= x; 
		}
	}
}
int main(){
	scanf("%d",&res);
	dfs(1);
	return 0;
} 
