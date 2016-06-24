//
//  FourViewController.m
//  SWSPractiseDemo
//
//  Created by 施文松 on 16/6/20.
//  Copyright © 2016年 shiwensong. All rights reserved.
//

#import "FourViewController.h"

@interface FourViewController ()

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    int array[] = {65, 2, 6, 1, 90, 78, 105, 67, 35, 23, 3, 88, -22};
    int size = sizeof(array) / sizeof(int);
    //
    mergeSort(array, size);
    print_array(array, size);
    
    
    // 快速排序算法
    int quickArray[] = {65, 2, 6, 1, 90, 78, 105, 67, 35, 23, 3, 88, -22};
    int quickSize = sizeof(array) / sizeof(int);
    quickSort(quickArray, quickSize);
    print_array(quickArray, quickSize);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
 一趟归并扫描子算法
 将参加排序的序列分成若干个长度为 t 的，且各自按值有序的子序列，然后多次调用归并子算法merge将所有两两相邻成对的子序列合并成若干个长度为2t 的，且各自按值有序的子序列。
 若某一趟归并扫描到最后，剩下的元素个数不足两个子序列的长度时：
 若剩下的元素个数大于一个子序列的长度 t 时，则再调用一次归并子算法 merge 将剩下的两个不等长的子序列合并成一个有序子序列；
 若剩下的元素个数小于或者等于一个子序列的长度 t 时，只须将剩下的元素依次复制到前一个子序列后面。
 */

/* X[0..n-1]表示参加排序的初始序列
 * t为某一趟归并时子序列的长度
 * 整型变量i指出当前归并的两个子序列中第1个子序列的第1个元素的位置
 * Y[0..n-1]表示这一趟归并后的结果
 */


void mergePass(int X[], int Y[], int n, int t)
{
    int i = 0, j;
    while( n - i >= 2 * t ) //将相邻的两个长度为t的各自有序的子序列合并成一个长度为2t的子序列
    {
        merge(X, Y, i, i + t - 1, i + 2 * t - 1);
        i = i + 2 * t;
    }
    
    if( n - i > t ) //若最后剩下的元素个数大于一个子序列的长度t时
        merge(X, Y, i, i + t - 1, n - 1);
    else //n-i <= t时，相当于只是把X[i..n-1]序列中的数据赋值给Y[i..n-1]
        for( j = i ; j < n ; ++j )
            Y[j] = X[j];
}
//二路归并排序算法
void mergeSort(int X[], int n)
{
    int t = 1;
    int *Y = (int *)malloc(sizeof(int) * n);
    while( t < n )
    {
        mergePass(X, Y, n, t);
        t *= 2;
        mergePass(Y, X, n, t);
        t *= 2;
    }
    free(Y);
}
void print_array( int array[], int n)
{
    int i;
    for( i = 0 ; i < n ; ++i )
        printf("%d ", array[i]);
    printf("\n");
}


//归并子算法
//将有序的X[s..u]和X[u+1..v]归并为有序的Z[s..v]
void merge(int X[], int Z[], int s, int u, int v)
{
    int i, j, q;
    i = s;
    j = u + 1;
    q = s;
    
    while( i <= u && j<= v )
    {
        if( X[i] <= X[j] )
            Z[q++] = X[i++];
        else
            Z[q++] = X[j++];
    }
    
    while( i <= u )   //将X中剩余元素X[i..u]复制到Z
        Z[q++] = X[i++];
    while( j <= v )   //将X中剩余元素X[j..v]复制到Z
        Z[q++] = X[j++];
}



/********************************************************************************************************/
/*
 
 2.2快速排序(quick sort)
 
 算法思路：通过一趟排序将要排序的数据分割成独立的两部分，其中一部分的所有数据比另外一部分的所有数据都要小，然后再按此方法对这两部分数据分别进行快速排序。整个排序过程可以递归实现，也可以非递归实现。
 
 c语言实现递归的快速排序的代码：
 

 */
//    从小到大排序
void quickSort(int a[],int numsize){
    int i=0,j=numsize-1;
    int val=a[0];//指定参考值val大小
    if (numsize>1) { //确保数组长度至少为2，否则无需排序
        while (i<j) {//循环结束条件
            //            从后向前搜索比val小的元素，找到后填到a［i］中并跳出循环
            for (; j>i; j--) {
                if (a[j]<val) {
                    a[i]=a[j];
                    break;
                }
            }
            //            从前向后搜索比val大的元素，找到后填到a［j］中并跳出循环
            for (; i<j; i++) {
                if (a[i]>val) {
                    a[j]=a[i];
                    break;
                }
            }
        }
        
        a[i]=val;//将保存再val中的数放到a［i］中
        quickSort(a, i);//递归，对前i个数排序
        quickSort(a+i+1, numsize-1-i);//对i＋1到numsize－1-i个数排序
    }
    
}


@end
