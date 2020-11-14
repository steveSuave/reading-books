#include <stdio.h>

#define MAX 10
void selection_sort(int ar[], int n);
int a[MAX];

int main(){
    int i;
    printf("%s\n", "Give ten numbers");
    for (i = 0; i < MAX && scanf("%d", &a[i]) != EOF; i++)
        ;

    selection_sort(a, i);
    for (i = 0; i < MAX; i++)
        printf("%d -> ", a[i]);
    printf("\n");
}


void selection_sort(int ar[], int n){
    int small, temp;
    for (int i = 0; i < n; i++){
        small=i;
        for (int j = i+1; j < n; j++)
            if (ar[j]<ar[small])
                small=j;
        temp=ar[small];
        ar[small]=ar[i];
        ar[i]=temp;
    }
}

