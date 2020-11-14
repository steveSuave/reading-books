#include <stdio.h>

#define MAX 10
int a[MAX];
struct STUDENT {
    int age;
    char grade;
    char name[];
} S[MAX], *C[MAX];
void selection_sort(struct STUDENT *r[], int n);

int main(){
    int i;
    for (i = 0; i < MAX; i++){
        printf("%s\n", "Give an age");
        scanf("%d", &S[i].age);
        C[i]=&S[i];
    }

    selection_sort(C, i);
    printf("%s\n", "orig");
    for (i = 0; i < MAX; i++)
        printf("%d -> ",  S[i].age);
    printf("\n%s\n", "pointer");
    for (i = 0; i < MAX; i++)
        printf("%d -> ", C[i]->age);
    
    printf("\n");
}


void selection_sort(struct STUDENT *ar[], int n){
    int small;
    struct STUDENT *temp;
    for (int i = 0; i < n; i++){
        small=i;
        for (int j = i+1; j < n; j++)
            if (ar[j]->age < ar[small]->age)
                small=j;
        temp=ar[small];
        ar[small]=ar[i];
        ar[i]=temp;
    }
}

