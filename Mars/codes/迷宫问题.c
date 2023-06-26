#include<stdio.h>
int beginx,beginy,endx,endy,n,m;
int p[7][7];
int sum =0;
int legal(int x,int y);
void dfs(int x,int y);
int main() {
	int i,j;
	scanf("%d%d",&n,&m);
	for(i=0; i<n; i++) {
		for(j=0; j<m; j++) {
			scanf("%d",&p[i][j]);
		}
	}
	scanf("%d%d%d%d",&beginx,&beginy,&endx,&endy);
	dfs(beginx-1,beginy-1);
	printf("%d",sum);
	return 0;
}
int legal(int x,int y ){
	if(x < n && y < m && x >= 0 && y >= 0 && p[x][y] == 0) {
		return 1;
	}
	return 0;
}
void dfs(int x,int y) {
	p[x][y] = 1;
	if(x == endx-1 && y == endy-1) {
		sum++;
		return;
	} else {
		if(legal(x-1,y)) {
			dfs(x-1,y);
			p[x-1][y] = 0;
		}
		if(legal(x,y-1)) {
			dfs(x,y-1);
			p[x][y-1] = 0;
		}
		if(legal(x+1,y)) {
			dfs(x+1,y);
			p[x+1][y] = 0;
		}
		if(legal(x,y+1)) {
			dfs(x,y+1);
			p[x][y+1] = 0;
		}
	}
}
