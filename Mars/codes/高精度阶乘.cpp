#include<stdio.h>
int ans[1000000] = {0};
int main() {
	int n;
	int sum = 0;
	int t;
	scanf("%d",&t);
	while(t--) {
		scanf("%d",&n);
		ans[0] = 1;
		int i =0 ;
		int num = 1;
		int temp = 0,carry = 0;
		for(i = 1; i <= n; i++) {
			int j = 0;
			for(j = 0; j < num; j++) {
				sum = sum +4;
				temp = ans[j] * i + temp;
				ans[j] = temp %10;
				temp = temp /10;
			}
			while(temp) {
				sum += 4;
				ans[j++] = temp % 10;
				temp /= 10;
			}
			num = j;
		}
		int digt;
		for(i = 0; i < num; i++) {
			if(ans[i] != 0) {
				digt = i;
				break;
			}
		}
		for(i = num- 1;i>=0;i--){
			printf("%d",ans[i]);
		}
	}
	return 0;
}
