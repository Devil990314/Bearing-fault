#include <math.h>
#include "mex.h"
#include "stdio.h"
#include "stdlib.h"

//---------------------------------------------------------------------------
// 定义输入参数
#define Y prhs[0]           // 起始点 (1 x 3 的矩阵)
#define H prhs[1]           // 积分时间步长
#define K prhs[2]           // 积分步数
#define SIGMA prhs[3]       // Rossler 方程参数 d
#define R prhs[4]           // Rossler 方程参数 e
#define B prhs[5]           // Rossler 方程参数 f

// 定义输出参数
#define Z plhs[0]           // Lorenz方程数值解序列 (k x 3 的矩阵)

// 声明 C 运算函数 (该函数名不能和本文件名重名)
void ROSSLER_DATA();
void grkt1f();
void grkt1();

//---------------------------------------------------------------------------
void 
mexFunction (int nlhs, mxArray *plhs[],			// 输出参数个数，及输出参数数组
			 int nrhs, const mxArray *prhs[])	// 输入参数个数，及输入参数数组
{
    double y[3], h, sigma, r, b, *pz;
    int k;

    // 取得输入参数
    memcpy(y,mxGetPr(Y),3*sizeof(double));  // 起始点 (1 x 3 的列向量)
	h = *mxGetPr(H);                        // 积分时间步长
	k = (int) *mxGetPr(K);                  // 积分步数
    
	sigma = *mxGetPr(SIGMA);            // Lorenz方程参数
    r = *mxGetPr(R);    
    b = *mxGetPr(B);	

    // 为输出变量分配内存空间
	Z = mxCreateDoubleMatrix(k,3,mxREAL); 
	
	// 取得输出参数指针
	pz = mxGetPr(Z);

    // 调用 C 运算函数 (该函数名不能和本文件名重名)
    ROSSLER_DATA(y,h,k,sigma,r,b,pz);    // y是一维数组的实参
	return;
}

//---------------------------------------------------------------------------
// 定义 C 运算函数
void ROSSLER_DATA( double y[],           // y[]是一维数组的形参
                  double h,
                  int k,
                  double sigma,
                  double r,
                  double b,
                  double *pz )
{
    int n=3;                            // 微分方程中方程个数
    double t=0;                         // 积分起始点
    
    // Matlab中数组是列向量，C中数组是行向量，都占用一块连续的内存
    grkt1(t,y,n,h,k,pz,sigma,r,b);      // pz是分配了内存的指针，做二维数组的实参
}

//---------------------------------------------------------------------------
void grkt1(t,y,n,h,k,z,sigma1,r1,b1)  // z[]是二维数组的形参
int n,k;
double t,h,y[],z[],sigma1,r1,b1;
{ 
    extern void grkt1f();
    int i,j,l;
    double a[4],tt,*b,*d;
    b=malloc(n*sizeof(double));
    d=malloc(n*sizeof(double));
    a[0]=h/2.0; a[1]=a[0];
    a[2]=h; a[3]=h;
    for (i=0; i<=n-1; i++) z[i*k]=y[i];
    for (l=1; l<=k-1; l++)
    {   grkt1f(t,y,n,d,sigma1,r1,b1);
        for (i=0; i<=n-1; i++) b[i]=y[i];
        for (j=0; j<=2; j++)
        {   for (i=0; i<=n-1; i++)
            {   y[i]=z[i*k+l-1]+a[j]*d[i];
                b[i]=b[i]+a[j+1]*d[i]/3.0;
            }
            tt=t+a[j];
            grkt1f(tt,y,n,d,sigma1,r1,b1);
        }
        for (i=0; i<=n-1; i++)
            y[i]=b[i]+h*d[i]/6.0;
        for (i=0; i<=n-1; i++)
            z[i*k+l]=y[i];
        t=t+h;
    }
    free(b); free(d);
	return;
}

//---------------------------------------------------------------------------
void grkt1f(t,y,n,d,sigma,r,b)
int n;
double t,y[],d[],sigma,r,b;
{ 
	t=t; 
	n=n;

	d[0] = -(y[1]+y[2]); 
	d[1] = y[0]+sigma*y[1]; 
	d[2] = r+y[2]*(y[0]-b);

    return;
  }