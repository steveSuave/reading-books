#include <stdio.h>

#define MAX 10
int a[MAX];
struct STUDENT {
    int age;
    char grade;
    char name[];
} S[MAX];
void selection_sort(struct STUDENT r[], int n);

int main(){
    int i;
    for (i = 0; i < MAX; i++){
        printf("%s\n", "Give an age");
        scanf("%d", &S[i].age);
        printf("%s\n", "Give a name");
        scanf("%s", S[i].name);
    }

    selection_sort(S, i);
    for (i = 0; i < MAX; i++)
        printf("%d -> ", S[i].age);
    printf("\n");
}


void selection_sort(struct STUDENT ar[], int n){
    int small, temp;
    for (int i = 0; i < n; i++){
        small=i;
        for (int j = i+1; j < n; j++)
            if (ar[j].age<ar[small].age)
                small=j;
        temp=ar[small].age;
        ar[small].age=ar[i].age;
        ar[i].age=temp;
    }
}

