// Search nearest neighbors in a given dataset
// either to some given reference indices (which point to vectors inside the data set)
// or to explicitly given reference vectors
// 
// Output of this program are the indices of the nearest neighbors.
// If a second output argument is specified, the distances to the neighbors are
// returned
//
// mex -I. -I.. fnearneigh.cpp -O      => compiles fast nearest neighbor searcher
// mex -I. -I.. fnearneigh.cpp -O -DBRUTE -output nn_brute.cpp 			=> compiles using brute force neighbor searcher

#include "mextools/mextools.h"

// this includes the code for the nearest neighbor searcher and the prediction routines
#include "NNSearcher/point_set.h"
#include "include.mex"

void mexFunction(int nlhs, mxArray  *plhs[], int nrhs, const mxArray  *prhs[])
{	
	int ref_or_direct = 1;			// ref_or_direct = 1 means interpret second input argument as reference indices
									// = 0 means interpret second input argument as reference vectors
	long past = 0;
	
	/* check input args */
	if (nrhs < 3)
	{
		mexErrMsgTxt("Fast nearest neighbour searcher : Data set of points (row vectors), reference indices or reference points \nand number of nearest neighbours must be given");
		return;
	}
	
	/* handle matrix I/O */
	
	const long N 		= mxGetM(prhs[0]);	
	const long dim  	= mxGetN(prhs[0]);
	const double* p 	= (double *)mxGetPr(prhs[0]);
	
	double* ref 	= (double *)mxGetPr(prhs[1]);
	long R; 										// number of query (reference) points
	
	const long NNR 	= (long) *((double *)mxGetPr(prhs[2]));
	
	if (N < 1) {
		mexErrMsgTxt("Data set must consist of at least two points (row vectors)");
		return;
	}		
	if (dim < 1) {
		mexErrMsgTxt("Data points must be at least of dimension one");
		return;
	}	
	if (NNR<1) {
		mexErrMsgTxt("At least one nearest neighbour must be requested");
		return;
	}	
	if ((mxGetN(prhs[1]) == 0) || (mxGetN(prhs[1]) == 0)) {
		mexErrMsgTxt("Wrong reference indices or reference points given");
		return;
	}	
	
	if (mxGetN(prhs[1]) == 1) {
		R = mxGetM(prhs[1]);
		ref_or_direct = 1;	
	} 
	else if ((mxGetM(prhs[1]) == 1) && (mxGetN(prhs[1]) != dim)) {
		R = mxGetN(prhs[1]);
		ref_or_direct = 1;	
	}
	else if (mxGetN(prhs[1]) == dim) {
		R = mxGetM(prhs[1]);
		ref_or_direct = 0;	
	} else  {
		mexErrMsgTxt("Cannot determine if second argument are reference indices or reference points");
		return;
	}	

	if (R < 1) {
		mexErrMsgTxt("At least one reference index or point must be given");
		return;
	}	

	if (ref_or_direct) {		// interpret second argument as list of indices into the data set given as first argument 
		if (nrhs < 4)
		{
#ifdef BRUTE		
			mexErrMsgTxt("Brute nearest neighbour searcher : Data set of points (row vectors), reference indices,\nnumber of nearest neighbours and past must be given");
#else
			mexErrMsgTxt("Fast nearest neighbour searcher : Data set of points (row vectors), reference indices,\nnumber of nearest neighbours and past must be given");
#endif
			return;
		}
		past = (long) *((double *)mxGetPr(prhs[3]));
		for (long i=0; i < R; i++) {
			if ((ref[i] < 1) || (ref[i]>N)) {
				mexErrMsgTxt("Reference indices out of range");
				return;
			}	
		}
		if ((N - (2*past)-1) < NNR)
		{
			mexErrMsgTxt("Fast nearest neighbour searcher : To many neighbors for each query point are requested");
			return;
		}		
		
	} 
	
#ifdef BRUTE
	point_set<squared_euclidian_distance> points(N,dim, p);		
	Brute< point_set<squared_euclidian_distance> > searcher(points);	
#else
	point_set<euclidian_distance> points(N,dim, p);	
	ATRIA< point_set<euclidian_distance> > searcher(points);	
#endif	
	
	if (searcher.geterr()) {
		mexErrMsgTxt("Error preparing searcher");
		return;
	}	 

	plhs[0] = mxCreateDoubleMatrix(R, NNR, mxREAL);
	double* nn = (double *) mxGetPr(plhs[0]);
	
	double* dists;
	
	if (nlhs > 1) {
		plhs[1] = mxCreateDoubleMatrix(R, NNR, mxREAL);
		dists = (double *) mxGetPr(plhs[1]);
	} else
		dists = new double[R*NNR];


	if (ref_or_direct) {
		for (long n=0; n < R; n++) { /* iterate over all reference points, given as index into the input point set */ 
			vector<neighbor> v;
			const long actual = (long) ref[n]-1;		/* Matlab to C means indices change from 1 to 0, 2 to 1, 3 to 2 ...*/
			
			searcher.search_k_neighbors(v, NNR, points.point_begin(actual), actual-past, actual+past);
			
			for (long k = 0; k < v.size(); k++) { 	// v is the sorted vector of neighbors
				nn[n+k*R] = v[k].index() + 1;	// convert indices back to Matlab (1..N) style 
#ifdef BRUTE
				dists[n+k*R] = sqrt(v[k].dist());
#else			
				dists[n+k*R] = v[k].dist();	
#endif	
			}	
		}
	} else {
		point_set<euclidian_distance> query_points(R, dim, ref);
		for (long n=0; n < R; n++) { 	/* iterate over all reference points, given explicitly */ 
			vector<neighbor> v;
			
			searcher.search_k_neighbors(v, NNR, query_points.point_begin(n), -1, -1);
			
			for (long k = 0; k < v.size(); k++) { 	// v is the sorted vector of neighbors
				nn[n+k*R] = v[k].index() + 1;	// convert indices back to Matlab (1..N) style 
#ifdef BRUTE
				dists[n+k*R] = sqrt(v[k].dist());
#else			
				dists[n+k*R] = v[k].dist();	
#endif				
			}	
		}
	}
		
	if (nlhs > 2) {
		plhs[2] = mxCreateDoubleMatrix(1, 1, mxREAL);
		*((double *) mxGetPr(plhs[2])) = searcher.search_efficiency();
	}
	
	if (!(nlhs > 1)) delete[] dists;
}	



