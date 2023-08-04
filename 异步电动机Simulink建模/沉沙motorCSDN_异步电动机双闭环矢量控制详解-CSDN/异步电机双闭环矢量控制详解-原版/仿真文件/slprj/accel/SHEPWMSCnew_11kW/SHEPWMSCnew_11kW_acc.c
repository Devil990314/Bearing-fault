#include "__cf_SHEPWMSCnew_11kW.h"
#include <math.h>
#include "SHEPWMSCnew_11kW_acc.h"
#include "SHEPWMSCnew_11kW_acc_private.h"
#include <stdio.h>
#include "slexec_vm_simstruct_bridge.h"
#include "slexec_vm_zc_functions.h"
#include "simstruc.h"
#include "fixedpoint.h"
#define CodeFormat S-Function
#define AccDefine1 Accelerator_S-Function
#include "simtarget/slAccSfcnBridge.h"
void gwoc4m5iet ( real_T prnfcxksqq , real_T oggfilq2s0 , real_T jnf5xpyacb ,
pxgyyrra55 * localB , h43l24ts0j * localDW ) { if ( prnfcxksqq > 0.0 ) {
localB -> i55zm41423 = ( jnf5xpyacb > oggfilq2s0 ) ; srUpdateBC ( localDW ->
nyjujslnwe ) ; } } void bxn3o4e1ts ( SimStruct * const S ) { } void
nkwnis514w ( real_T lq5rnnllge , real_T fuuolc14y5 , real_T aywnmzgera ,
g4uzr24220 * localB , plfko0ibxq * localDW ) { if ( lq5rnnllge > 0.0 ) {
localB -> eljo1sdjk1 = ( fuuolc14y5 > aywnmzgera ) ; srUpdateBC ( localDW ->
mgwyayiwsy ) ; } } void cgmagiuty2 ( SimStruct * const S ) { } void
lwigyqay0m ( const real_T k1l54bvy3k [ 2 ] , real_T nhtwbadqd4 , awyilyshqw *
localB , oxht5w115d * localP ) { localB -> lyzemzm0x5 = ( ( localP -> P_1 >
nhtwbadqd4 ) && ( 1.0 - k1l54bvy3k [ 0 ] <= nhtwbadqd4 ) && ( ( localP -> P_0
<= nhtwbadqd4 ) || ( k1l54bvy3k [ 1 ] > nhtwbadqd4 ) ) ) ; } void kfrdr1tise
( SimStruct * const S ) { } void c55vtga0tk ( const real_T gagqazvqgh [ 2 ] ,
real_T f5ftqxqdju , mdlfsugfav * localB , da5umdtok1 * localP ) { localB ->
axz5kld34t = ( ( localP -> P_0 <= f5ftqxqdju ) || ( gagqazvqgh [ 0 ] >
f5ftqxqdju ) || ( ( localP -> P_1 > f5ftqxqdju ) && ( 1.0 - gagqazvqgh [ 1 ]
<= f5ftqxqdju ) ) ) ; } void kgugdcho04 ( SimStruct * const S ) { } void
h3mhg504cx ( const real_T ftmrxfohhg [ 2 ] , real_T ou1hbx3ymn , gdt4hxgqdp *
localB , kzzrsq11s0 * localP ) { localB -> n0huo22hfh = ( ( 1.0 - ftmrxfohhg
[ 0 ] <= ou1hbx3ymn ) && ( localP -> P_0 > ou1hbx3ymn ) ) ; } void np3akvxkji
( SimStruct * const S ) { } void jrbxtvxt4p ( const real_T i5rgbbkiiz [ 2 ] ,
real_T lwakexopuj , bjdkajcvrm * localB , glikj0qocr * localP ) { localB ->
o1uz42lxj1 = ( ( localP -> P_0 <= lwakexopuj ) || ( i5rgbbkiiz [ 0 ] >
lwakexopuj ) ) ; } void cdk3yr5tl5 ( SimStruct * const S ) { } void
rt_invd4x4_snf ( const real_T u [ 16 ] , real_T y [ 16 ] ) { int8_T p [ 4 ] ;
real_T A [ 16 ] ; int8_T ipiv [ 4 ] ; int32_T jm1 ; int32_T jpiv_offset ;
int32_T idxmax ; int32_T ix ; real_T smax ; int32_T ijA ; int32_T pipk ;
int32_T jBcol ; int32_T kAcol ; real_T s ; for ( pipk = 0 ; pipk < 16 ; pipk
++ ) { y [ pipk ] = 0.0 ; A [ pipk ] = u [ pipk ] ; } ipiv [ 0 ] = 1 ; ipiv [
1 ] = 2 ; ipiv [ 2 ] = 3 ; for ( pipk = 0 ; pipk < 3 ; pipk ++ ) { jBcol =
pipk * 5 + 1 ; kAcol = pipk * 5 ; idxmax = 1 ; ix = jBcol - 1 ; smax =
muDoubleScalarAbs ( A [ kAcol ] ) ; for ( jpiv_offset = 2 ; jpiv_offset <= 4
- pipk ; jpiv_offset ++ ) { ix ++ ; s = muDoubleScalarAbs ( A [ ix ] ) ; if (
s > smax ) { idxmax = jpiv_offset ; smax = s ; } } jpiv_offset = idxmax - 1 ;
if ( A [ ( jBcol + jpiv_offset ) - 1 ] != 0.0 ) { if ( jpiv_offset != 0 ) {
ipiv [ pipk ] = ( int8_T ) ( ( pipk + jpiv_offset ) + 1 ) ; ix = 1 + pipk ;
jm1 = ( pipk + jpiv_offset ) + 1 ; s = A [ ix - 1 ] ; A [ ix - 1 ] = A [ jm1
- 1 ] ; A [ jm1 - 1 ] = s ; ix += 4 ; jm1 += 4 ; s = A [ ix - 1 ] ; A [ ix -
1 ] = A [ jm1 - 1 ] ; A [ jm1 - 1 ] = s ; ix += 4 ; jm1 += 4 ; s = A [ ix - 1
] ; A [ ix - 1 ] = A [ jm1 - 1 ] ; A [ jm1 - 1 ] = s ; ix += 4 ; jm1 += 4 ; s
= A [ ix - 1 ] ; A [ ix - 1 ] = A [ jm1 - 1 ] ; A [ jm1 - 1 ] = s ; }
jpiv_offset = jBcol - pipk ; for ( ix = jBcol + 1 ; ix <= jpiv_offset + 3 ;
ix ++ ) { A [ ix - 1 ] /= A [ kAcol ] ; } } jm1 = kAcol ; kAcol += 4 ; for (
idxmax = 1 ; idxmax <= 3 - pipk ; idxmax ++ ) { if ( A [ kAcol ] != 0.0 ) { s
= - A [ kAcol ] ; ix = jBcol ; jpiv_offset = jm1 - pipk ; for ( ijA = jm1 + 6
; ijA <= jpiv_offset + 8 ; ijA ++ ) { A [ ijA - 1 ] += A [ ( ix + 1 ) - 1 ] *
s ; ix ++ ; } } kAcol += 4 ; jm1 += 4 ; } } p [ 0 ] = 1 ; p [ 1 ] = 2 ; p [ 2
] = 3 ; p [ 3 ] = 4 ; if ( ipiv [ 0 ] > 1 ) { pipk = p [ ipiv [ 0 ] - 1 ] ; p
[ ipiv [ 0 ] - 1 ] = 1 ; p [ 0 ] = ( int8_T ) pipk ; } if ( ipiv [ 1 ] > 2 )
{ pipk = p [ ipiv [ 1 ] - 1 ] ; p [ ipiv [ 1 ] - 1 ] = p [ 1 ] ; p [ 1 ] = (
int8_T ) pipk ; } if ( ipiv [ 2 ] > 3 ) { pipk = p [ 3 ] ; p [ 3 ] = p [ 2 ]
; p [ 2 ] = ( int8_T ) pipk ; } jBcol = p [ 0 ] ; y [ ( p [ 0 ] - 1 ) << 2 ]
= 1.0 ; for ( pipk = 1 ; pipk < 5 ; pipk ++ ) { if ( y [ ( ( ( jBcol - 1 ) <<
2 ) + pipk ) - 1 ] != 0.0 ) { for ( ix = pipk + 1 ; ix < 5 ; ix ++ ) { y [ (
ix + ( ( jBcol - 1 ) << 2 ) ) - 1 ] -= y [ ( ( ( jBcol - 1 ) << 2 ) + pipk )
- 1 ] * A [ ( ( ( pipk - 1 ) << 2 ) + ix ) - 1 ] ; } } } jBcol = p [ 1 ] ; y
[ 1 + ( ( p [ 1 ] - 1 ) << 2 ) ] = 1.0 ; for ( pipk = 2 ; pipk < 5 ; pipk ++
) { if ( y [ ( ( ( jBcol - 1 ) << 2 ) + pipk ) - 1 ] != 0.0 ) { for ( ix =
pipk + 1 ; ix < 5 ; ix ++ ) { y [ ( ix + ( ( jBcol - 1 ) << 2 ) ) - 1 ] -= y
[ ( ( ( jBcol - 1 ) << 2 ) + pipk ) - 1 ] * A [ ( ( ( pipk - 1 ) << 2 ) + ix
) - 1 ] ; } } } jBcol = p [ 2 ] ; y [ 2 + ( ( p [ 2 ] - 1 ) << 2 ) ] = 1.0 ;
for ( pipk = 3 ; pipk < 5 ; pipk ++ ) { if ( y [ ( ( ( jBcol - 1 ) << 2 ) +
pipk ) - 1 ] != 0.0 ) { ix = pipk + 1 ; while ( ix < 5 ) { y [ ( ( jBcol - 1
) << 2 ) + 3 ] -= y [ ( ( ( jBcol - 1 ) << 2 ) + pipk ) - 1 ] * A [ ( ( pipk
- 1 ) << 2 ) + 3 ] ; ix = 5 ; } } } y [ 3 + ( ( p [ 3 ] - 1 ) << 2 ) ] = 1.0
; for ( pipk = 0 ; pipk < 4 ; pipk ++ ) { jBcol = pipk << 2 ; if ( y [ jBcol
+ 3 ] != 0.0 ) { y [ jBcol + 3 ] /= A [ 15 ] ; for ( ix = 1 ; ix < 4 ; ix ++
) { y [ ( ix + jBcol ) - 1 ] -= y [ jBcol + 3 ] * A [ ix + 11 ] ; } } if ( y
[ jBcol + 2 ] != 0.0 ) { y [ jBcol + 2 ] /= A [ 10 ] ; for ( ix = 1 ; ix < 3
; ix ++ ) { y [ ( ix + jBcol ) - 1 ] -= y [ jBcol + 2 ] * A [ ix + 7 ] ; } }
if ( y [ jBcol + 1 ] != 0.0 ) { y [ jBcol + 1 ] /= A [ 5 ] ; ix = 1 ; while (
ix <= 1 ) { y [ jBcol ] -= y [ jBcol + 1 ] * A [ 4 ] ; ix = 2 ; } } if ( y [
jBcol ] != 0.0 ) { y [ jBcol ] /= A [ 0 ] ; } } } static void mdlOutputs (
SimStruct * S , int_T tid ) { real_T ptahs0eh4q ; real_T enbn2wwko3 ; real_T
prqhvnbha0 ; real_T nkn0xd40ra ; real_T iexjb5pvme ; real_T kveud5uqhb ;
real_T jm05egcgqw ; boolean_T jxn3aafqxu ; boolean_T djud1xju4l ; boolean_T
dmn4ug0nez ; boolean_T iry3cdheo0 ; boolean_T jzh0jvxjmi ; boolean_T
e3blb333rs ; boolean_T jcz5w35jhj ; boolean_T ljvfec2xnv ; real_T * lastU ;
real_T tmp [ 4 ] ; real_T emmpw0nmca ; real_T nvra3kied3 ; real_T dotqdukedn
; real_T jjsaaxpmip ; real_T at0f5ztich ; ZCEventType zcEvent ; boolean_T
k5rrxb3wvw ; boolean_T phdegtrihx ; boolean_T j5wbjkynwt ; boolean_T
nywtefnm2z ; boolean_T b1cephvmoq ; boolean_T lr3psdtz0q ; real_T h0fbysnpir
; real_T ltzae3biwo ; real_T oa5gdo2ksv [ 4 ] ; creal_T bqesw0kw3i ; real_T
czahtqwgjp [ 16 ] ; real_T ckfygvafbr [ 16 ] ; int32_T i ; real_T fvgwbluoqv
[ 16 ] ; real_T hodzy2wu5w_p [ 19 ] ; int32_T i_p ; real_T tmp_p [ 4 ] ;
real_T ptruiulzxg [ 4 ] ; real_T hx0ttdnun1_idx_1 ; real_T hx0ttdnun1_idx_2 ;
real_T hx0ttdnun1_idx_3 ; real_T ivejv0gvvj_idx_1 ; real_T na02q54ej0_idx_1 ;
real_T na02q54ej0_idx_2 ; real_T na02q54ej0_idx_3 ; real_T na02q54ej0_idx_0 ;
real_T oooq3ntnjh_idx_0 ; jmhfl0vfej * _rtB ; pb0dk03pgo * _rtP ; nf0frcip0m
* _rtZCE ; msq0uno1m5 * _rtDW ; _rtDW = ( ( msq0uno1m5 * ) ssGetRootDWork ( S
) ) ; _rtZCE = ( ( nf0frcip0m * ) _ssGetPrevZCSigState ( S ) ) ; _rtP = ( (
pb0dk03pgo * ) ssGetDefaultParam ( S ) ) ; _rtB = ( ( jmhfl0vfej * )
_ssGetBlockIO ( S ) ) ; if ( ssIsContinuousTask ( S , tid ) ) {
hx0ttdnun1_idx_1 = ssGetTaskTime ( S , 0 ) ; if ( hx0ttdnun1_idx_1 < _rtP ->
P_102 ) { _rtB -> lx04hzpllx = _rtP -> P_103 ; } else { _rtB -> lx04hzpllx =
_rtP -> P_104 ; } } if ( ssIsSampleHit ( S , 1 , tid ) ) { for ( i = 0 ; i <
6 ; i ++ ) { _rtB -> j3gwaatudr [ i ] = _rtDW -> dewe4gvi5r [ i ] ; }
dotqdukedn = _rtDW -> fk1qpjfzc1 ; bqesw0kw3i = _rtDW -> mep1rokrtv ;
jjsaaxpmip = bqesw0kw3i . re ; at0f5ztich = bqesw0kw3i . im ; emmpw0nmca =
_rtP -> P_101 * _rtDW -> bxoxk4txlf ; hx0ttdnun1_idx_1 = ssGetTaskTime ( S ,
1 ) ; if ( hx0ttdnun1_idx_1 < _rtP -> P_105 ) { _rtB -> namgiqxzyp = _rtP ->
P_106 ; } else { _rtB -> namgiqxzyp = _rtP -> P_107 ; } if ( _rtB ->
namgiqxzyp > 0.0 ) { if ( ! _rtDW -> apyu1gfrng ) { ssCallAccelRunBlock ( S ,
12 , 0 , SS_CALL_RTW_GENERATED_ENABLE ) ; ssCallAccelRunBlock ( S , 14 , 0 ,
SS_CALL_RTW_GENERATED_ENABLE ) ; _rtDW -> apyu1gfrng = true ; } } else { if (
_rtDW -> apyu1gfrng ) { ssCallAccelRunBlock ( S , 12 , 0 ,
SS_CALL_RTW_GENERATED_DISABLE ) ; ssCallAccelRunBlock ( S , 14 , 0 ,
SS_CALL_RTW_GENERATED_DISABLE ) ; _rtDW -> apyu1gfrng = false ; } } } if (
_rtDW -> apyu1gfrng ) { if ( ssIsSampleHit ( S , 1 , tid ) ) { _rtB ->
opnzzri2lu = _rtDW -> gzu0zv51zr ; zcEvent = rt_ZCFcn ( RISING_ZERO_CROSSING
, & _rtZCE -> bpzjgpun43 , ( _rtB -> opnzzri2lu ) ) ; if ( zcEvent !=
NO_ZCEVENT ) { ssReadFromDataStoreWithPath ( S , _rtDW -> ams35kahtx ,
"SHEPWMSCnew_11kW/PWM/MPC/Data Store Read" , NULL ) ; _rtB -> bx4if5tw1y [ 0
] = ( real32_T ) _rtB -> lx04hzpllx ; _rtB -> bx4if5tw1y [ 1 ] = ( real32_T )
0.0 ; _rtB -> bx4if5tw1y [ 2 ] = ( real32_T ) _rtB -> iatkzgc1lw ; _rtB ->
bx4if5tw1y [ 3 ] = ( real32_T ) dotqdukedn ; _rtB -> bx4if5tw1y [ 4 ] = (
real32_T ) jjsaaxpmip ; _rtB -> bx4if5tw1y [ 5 ] = ( real32_T ) at0f5ztich ;
_rtB -> bx4if5tw1y [ 6 ] = ( real32_T ) emmpw0nmca ; for ( i = 0 ; i < 7 ; i
++ ) { _rtB -> bx4if5tw1y [ i + 7 ] = ( real32_T ) _rtB -> f1kxbsvkxh [ i ] ;
} _rtB -> bx4if5tw1y [ 14 ] = ( real32_T ) _rtDW -> oprzcoz2lj ; _rtB ->
bx4if5tw1y [ 15 ] = ( real32_T ) _rtB -> nmyvksrejv [ 0 ] ; _rtB ->
bx4if5tw1y [ 16 ] = ( real32_T ) _rtB -> nmyvksrejv [ 1 ] ;
ssCallAccelRunBlock ( S , 12 , 0 , SS_CALL_MDL_OUTPUTS ) ; for ( i = 0 ; i <
21 ; i ++ ) { _rtB -> hfxiqmdpwu [ i ] = _rtB -> ahahozbdkb [ i ] ; } _rtDW
-> oprzcoz2lj = _rtB -> hfxiqmdpwu [ 0 ] ; ssWriteToDataStoreWithPath ( S ,
_rtDW -> ams35kahtx , "SHEPWMSCnew_11kW/PWM/MPC/Data Store Write1" , NULL ) ;
ssCallAccelRunBlock ( S , 13 , 7 , SS_CALL_MDL_OUTPUTS ) ; _rtB -> aih0lxf2el
= _rtB -> hfxiqmdpwu [ 19 ] ; _rtB -> lmsd5pgfmg = _rtB -> hfxiqmdpwu [ 20 ]
; for ( i = 0 ; i < 10 ; i ++ ) { _rtB -> cxai5m0uqh [ i ] = _rtDW ->
dkkyujyobc [ i ] ; _rtDW -> dkkyujyobc [ i ] = _rtB -> hfxiqmdpwu [ i ] ; }
_rtDW -> b5zerdfrgu = 4 ; } ssCallAccelRunBlock ( S , 14 , 0 ,
SS_CALL_MDL_OUTPUTS ) ; switch ( ( int32_T ) _rtB -> cxai5m0uqh [ 7 ] ) {
case 0 : jrbxtvxt4p ( & _rtB -> cxai5m0uqh [ 1 ] , _rtB -> mslohgjvhk , &
_rtB -> jrbxtvxt4pj , ( glikj0qocr * ) & _rtP -> jrbxtvxt4pj ) ; _rtB ->
gss5lrj5rw = _rtB -> jrbxtvxt4pj . o1uz42lxj1 ; break ; case 1 : h3mhg504cx (
& _rtB -> cxai5m0uqh [ 1 ] , _rtB -> mslohgjvhk , & _rtB -> h3mhg504cxl , (
kzzrsq11s0 * ) & _rtP -> h3mhg504cxl ) ; _rtB -> gss5lrj5rw = _rtB ->
h3mhg504cxl . n0huo22hfh ; break ; case 2 : c55vtga0tk ( & _rtB -> cxai5m0uqh
[ 1 ] , _rtB -> mslohgjvhk , & _rtB -> c55vtga0tkv , ( da5umdtok1 * ) & _rtP
-> c55vtga0tkv ) ; _rtB -> gss5lrj5rw = _rtB -> c55vtga0tkv . axz5kld34t ;
break ; default : lwigyqay0m ( & _rtB -> cxai5m0uqh [ 1 ] , _rtB ->
mslohgjvhk , & _rtB -> lwigyqay0mx , ( oxht5w115d * ) & _rtP -> lwigyqay0mx )
; _rtB -> gss5lrj5rw = _rtB -> lwigyqay0mx . lyzemzm0x5 ; break ; } _rtB ->
p5vxd4zheq = _rtP -> P_68 * _rtB -> gss5lrj5rw ; switch ( ( int32_T ) _rtB ->
cxai5m0uqh [ 8 ] ) { case 0 : jrbxtvxt4p ( & _rtB -> cxai5m0uqh [ 3 ] , _rtB
-> mslohgjvhk , & _rtB -> nhfkbwggbl , ( glikj0qocr * ) & _rtP -> nhfkbwggbl
) ; _rtB -> auuslohtnj = _rtB -> nhfkbwggbl . o1uz42lxj1 ; break ; case 1 :
h3mhg504cx ( & _rtB -> cxai5m0uqh [ 3 ] , _rtB -> mslohgjvhk , & _rtB ->
fswakkxlgs , ( kzzrsq11s0 * ) & _rtP -> fswakkxlgs ) ; _rtB -> auuslohtnj =
_rtB -> fswakkxlgs . n0huo22hfh ; break ; case 2 : c55vtga0tk ( & _rtB ->
cxai5m0uqh [ 3 ] , _rtB -> mslohgjvhk , & _rtB -> lvzzdsjzbf , ( da5umdtok1 *
) & _rtP -> lvzzdsjzbf ) ; _rtB -> auuslohtnj = _rtB -> lvzzdsjzbf .
axz5kld34t ; break ; default : lwigyqay0m ( & _rtB -> cxai5m0uqh [ 3 ] , _rtB
-> mslohgjvhk , & _rtB -> pgsom134ka , ( oxht5w115d * ) & _rtP -> pgsom134ka
) ; _rtB -> auuslohtnj = _rtB -> pgsom134ka . lyzemzm0x5 ; break ; } switch (
( int32_T ) _rtB -> cxai5m0uqh [ 9 ] ) { case 0 : jrbxtvxt4p ( & _rtB ->
cxai5m0uqh [ 5 ] , _rtB -> mslohgjvhk , & _rtB -> lyupc34jlf , ( glikj0qocr *
) & _rtP -> lyupc34jlf ) ; _rtB -> ondv43ewih = _rtB -> lyupc34jlf .
o1uz42lxj1 ; break ; case 1 : h3mhg504cx ( & _rtB -> cxai5m0uqh [ 5 ] , _rtB
-> mslohgjvhk , & _rtB -> mgyywymmwa , ( kzzrsq11s0 * ) & _rtP -> mgyywymmwa
) ; _rtB -> ondv43ewih = _rtB -> mgyywymmwa . n0huo22hfh ; break ; case 2 :
c55vtga0tk ( & _rtB -> cxai5m0uqh [ 5 ] , _rtB -> mslohgjvhk , & _rtB ->
m5mlrqvmn4 , ( da5umdtok1 * ) & _rtP -> m5mlrqvmn4 ) ; _rtB -> ondv43ewih =
_rtB -> m5mlrqvmn4 . axz5kld34t ; break ; default : lwigyqay0m ( & _rtB ->
cxai5m0uqh [ 5 ] , _rtB -> mslohgjvhk , & _rtB -> fymqm5od3g , ( oxht5w115d *
) & _rtP -> fymqm5od3g ) ; _rtB -> ondv43ewih = _rtB -> fymqm5od3g .
lyzemzm0x5 ; break ; } _rtB -> ahn5vkjji2 = _rtP -> P_69 * _rtB -> ondv43ewih
; ssCallAccelRunBlock ( S , 54 , 21 , SS_CALL_MDL_OUTPUTS ) ; } if (
ssIsContinuousTask ( S , tid ) ) { kveud5uqhb = ssGetT ( S ) ; } if (
ssIsSampleHit ( S , 1 , tid ) ) { k5rrxb3wvw = ! _rtDW -> bp0rj2rogx ;
ptahs0eh4q = _rtDW -> gosx21togf ; switch ( ( int32_T ) _rtP -> P_71 ) { case
1 : _rtB -> npks1lvvfn [ 0 ] = _rtP -> P_55 [ 0 ] ; _rtB -> npks1lvvfn [ 1 ]
= _rtP -> P_55 [ 1 ] ; break ; case 2 : _rtB -> npks1lvvfn [ 0 ] = _rtP ->
P_54 [ 0 ] ; _rtB -> npks1lvvfn [ 1 ] = _rtP -> P_54 [ 1 ] ; break ; default
: _rtB -> npks1lvvfn [ 0 ] = _rtP -> P_53 [ 0 ] ; _rtB -> npks1lvvfn [ 1 ] =
_rtP -> P_53 [ 1 ] ; break ; } nkwnis514w ( _rtB -> npks1lvvfn [ 0 ] , _rtB
-> gss5lrj5rw , ptahs0eh4q , & _rtB -> nkwnis514w3 , & _rtDW -> nkwnis514w3 )
; gwoc4m5iet ( _rtB -> npks1lvvfn [ 1 ] , _rtB -> gss5lrj5rw , ptahs0eh4q , &
_rtB -> gwoc4m5ietm , & _rtDW -> gwoc4m5ietm ) ; _rtB -> jo53elpgxl = (
k5rrxb3wvw && ( _rtB -> nkwnis514w3 . eljo1sdjk1 || _rtB -> gwoc4m5ietm .
i55zm41423 ) ) ; _rtB -> czgrnhyagd = _rtDW -> aozr5000cf ; _rtB ->
cv2syxqcdg = _rtP -> P_73 ; } if ( ssIsContinuousTask ( S , tid ) ) { if (
_rtB -> jo53elpgxl ) { _rtB -> ihedzxs4yi = kveud5uqhb ; } else { _rtB ->
ihedzxs4yi = _rtB -> czgrnhyagd ; } } if ( ssIsSampleHit ( S , 1 , tid ) ) {
_rtB -> gdxj22reiw = ! ( _rtB -> gss5lrj5rw != 0.0 ) ; } if (
ssIsContinuousTask ( S , tid ) ) { _rtB -> bnzxyuzyuq = ( _rtB -> ihedzxs4yi
+ _rtB -> cv2syxqcdg > kveud5uqhb ) ; phdegtrihx = ! _rtB -> bnzxyuzyuq ;
j5wbjkynwt = ( phdegtrihx && ( _rtB -> gss5lrj5rw != 0.0 ) ) ; phdegtrihx = (
phdegtrihx && _rtB -> gdxj22reiw ) ; kveud5uqhb = ssGetT ( S ) ; } if (
ssIsSampleHit ( S , 1 , tid ) ) { k5rrxb3wvw = ! _rtDW -> pgmwr4vhd2 ;
enbn2wwko3 = _rtDW -> bwvycmcn3z ; switch ( ( int32_T ) _rtP -> P_75 ) { case
1 : _rtB -> etbpjjlysp [ 0 ] = _rtP -> P_58 [ 0 ] ; _rtB -> etbpjjlysp [ 1 ]
= _rtP -> P_58 [ 1 ] ; break ; case 2 : _rtB -> etbpjjlysp [ 0 ] = _rtP ->
P_57 [ 0 ] ; _rtB -> etbpjjlysp [ 1 ] = _rtP -> P_57 [ 1 ] ; break ; default
: _rtB -> etbpjjlysp [ 0 ] = _rtP -> P_56 [ 0 ] ; _rtB -> etbpjjlysp [ 1 ] =
_rtP -> P_56 [ 1 ] ; break ; } nkwnis514w ( _rtB -> etbpjjlysp [ 0 ] , _rtB
-> auuslohtnj , enbn2wwko3 , & _rtB -> hh324dgcms , & _rtDW -> hh324dgcms ) ;
gwoc4m5iet ( _rtB -> etbpjjlysp [ 1 ] , _rtB -> auuslohtnj , enbn2wwko3 , &
_rtB -> cdhbvmhztn , & _rtDW -> cdhbvmhztn ) ; _rtB -> gkp0eqh2e3 = (
k5rrxb3wvw && ( _rtB -> hh324dgcms . eljo1sdjk1 || _rtB -> cdhbvmhztn .
i55zm41423 ) ) ; _rtB -> fb5c3m0o4c = _rtDW -> e3f14xoesd ; _rtB ->
daohgyrezg = _rtP -> P_77 ; } if ( ssIsContinuousTask ( S , tid ) ) { if (
_rtB -> gkp0eqh2e3 ) { _rtB -> btrcgb5p2q = kveud5uqhb ; } else { _rtB ->
btrcgb5p2q = _rtB -> fb5c3m0o4c ; } } if ( ssIsSampleHit ( S , 1 , tid ) ) {
_rtB -> nvwst0a2bh = ! ( _rtB -> auuslohtnj != 0.0 ) ; } if (
ssIsContinuousTask ( S , tid ) ) { _rtB -> erfhz4u2ha = ( _rtB -> btrcgb5p2q
+ _rtB -> daohgyrezg > kveud5uqhb ) ; nywtefnm2z = ! _rtB -> erfhz4u2ha ;
b1cephvmoq = ( nywtefnm2z && ( _rtB -> auuslohtnj != 0.0 ) ) ; nywtefnm2z = (
nywtefnm2z && _rtB -> nvwst0a2bh ) ; kveud5uqhb = ssGetT ( S ) ; } if (
ssIsSampleHit ( S , 1 , tid ) ) { k5rrxb3wvw = ! _rtDW -> elvgq1j52h ;
prqhvnbha0 = _rtDW -> hpvt2c0ku5 ; switch ( ( int32_T ) _rtP -> P_79 ) { case
1 : _rtB -> aefpqulgy1 [ 0 ] = _rtP -> P_61 [ 0 ] ; _rtB -> aefpqulgy1 [ 1 ]
= _rtP -> P_61 [ 1 ] ; break ; case 2 : _rtB -> aefpqulgy1 [ 0 ] = _rtP ->
P_60 [ 0 ] ; _rtB -> aefpqulgy1 [ 1 ] = _rtP -> P_60 [ 1 ] ; break ; default
: _rtB -> aefpqulgy1 [ 0 ] = _rtP -> P_59 [ 0 ] ; _rtB -> aefpqulgy1 [ 1 ] =
_rtP -> P_59 [ 1 ] ; break ; } nkwnis514w ( _rtB -> aefpqulgy1 [ 0 ] , _rtB
-> ondv43ewih , prqhvnbha0 , & _rtB -> ij4wnkf1ue , & _rtDW -> ij4wnkf1ue ) ;
gwoc4m5iet ( _rtB -> aefpqulgy1 [ 1 ] , _rtB -> ondv43ewih , prqhvnbha0 , &
_rtB -> ancm1nm2si , & _rtDW -> ancm1nm2si ) ; _rtB -> dvvx5sdwdn = (
k5rrxb3wvw && ( _rtB -> ij4wnkf1ue . eljo1sdjk1 || _rtB -> ancm1nm2si .
i55zm41423 ) ) ; _rtB -> fqz4tk52b2 = _rtDW -> jpj3cab3oc ; _rtB ->
ilo4fnl2kc = _rtP -> P_81 ; } if ( ssIsContinuousTask ( S , tid ) ) { if (
_rtB -> dvvx5sdwdn ) { _rtB -> p0whqztos1 = kveud5uqhb ; } else { _rtB ->
p0whqztos1 = _rtB -> fqz4tk52b2 ; } } if ( ssIsSampleHit ( S , 1 , tid ) ) {
_rtB -> nsymn0eoxv = ! ( _rtB -> ondv43ewih != 0.0 ) ; } if (
ssIsContinuousTask ( S , tid ) ) { _rtB -> e22acsxkiv = ( _rtB -> p0whqztos1
+ _rtB -> ilo4fnl2kc > kveud5uqhb ) ; lr3psdtz0q = ! _rtB -> e22acsxkiv ;
k5rrxb3wvw = ( lr3psdtz0q && ( _rtB -> ondv43ewih != 0.0 ) ) ; lr3psdtz0q = (
lr3psdtz0q && _rtB -> nsymn0eoxv ) ; _rtB -> lpijl1o3bz [ 0 ] = j5wbjkynwt ;
_rtB -> lpijl1o3bz [ 1 ] = phdegtrihx ; _rtB -> lpijl1o3bz [ 2 ] = b1cephvmoq
; _rtB -> lpijl1o3bz [ 3 ] = nywtefnm2z ; _rtB -> lpijl1o3bz [ 4 ] =
k5rrxb3wvw ; _rtB -> lpijl1o3bz [ 5 ] = lr3psdtz0q ; } if ( ssIsSampleHit ( S
, 1 , tid ) ) { ssCallAccelRunBlock ( S , 54 , 89 , SS_CALL_MDL_OUTPUTS ) ;
ssCallAccelRunBlock ( S , 54 , 90 , SS_CALL_MDL_OUTPUTS ) ; } srUpdateBC (
_rtDW -> pwcaihzxxr ) ; } if ( ssIsSampleHit ( S , 1 , tid ) ) { if ( _rtB ->
khmzhv1ntc ) { if ( ! _rtDW -> i5y0nptmn2 ) { for ( i = 0 ; i < 6 ; i ++ ) {
_rtDW -> cj2qd1mnl4 [ i ] = _rtP -> P_86 ; _rtDW -> ek2sosv0fx [ i ] = 2 ;
_rtDW -> jq4yf1ps3x [ i ] = _rtP -> P_95 ; } _rtDW -> i5y0nptmn2 = true ; } }
else { if ( _rtDW -> i5y0nptmn2 ) { for ( i = 0 ; i < 6 ; i ++ ) { _rtDW ->
cj2qd1mnl4 [ i ] = _rtB -> galbyiq54c [ i ] ; } _rtDW -> i5y0nptmn2 = false ;
} } } if ( _rtDW -> i5y0nptmn2 ) { if ( ssIsSampleHit ( S , 1 , tid ) ) { for
( i = 0 ; i < 6 ; i ++ ) { if ( ( _rtB -> lpijl1o3bz [ i ] <= 0.0 ) && (
_rtDW -> ek2sosv0fx [ i ] == 1 ) ) { _rtDW -> cj2qd1mnl4 [ i ] = _rtP -> P_86
; } _rtB -> galbyiq54c [ i ] = _rtDW -> cj2qd1mnl4 [ i ] ; jjsaaxpmip = _rtP
-> P_88 * _rtB -> galbyiq54c [ i ] + _rtB -> ivv2jnhcpi ; dotqdukedn = ( _rtB
-> p1w0xi100e - _rtB -> galbyiq54c [ i ] ) * _rtP -> P_92 ; if ( jjsaaxpmip >
_rtP -> P_89 ) { jjsaaxpmip = _rtP -> P_89 ; } else { if ( jjsaaxpmip < _rtP
-> P_90 ) { jjsaaxpmip = _rtP -> P_90 ; } } if ( dotqdukedn > _rtP -> P_93 )
{ dotqdukedn = _rtP -> P_93 ; } else { if ( dotqdukedn < _rtP -> P_94 ) {
dotqdukedn = _rtP -> P_94 ; } } _rtB -> g5vchxe1br [ i ] = jjsaaxpmip +
dotqdukedn ; _rtB -> jaqhhc01c1 [ i ] = _rtDW -> jq4yf1ps3x [ i ] ; } } if (
ssIsContinuousTask ( S , tid ) ) { for ( i = 0 ; i < 6 ; i ++ ) { if ( _rtB
-> lpijl1o3bz [ i ] >= _rtP -> P_96 ) { _rtB -> et4o1kxcgm [ i ] = _rtB ->
j3gwaatudr [ i ] ; } else { _rtB -> et4o1kxcgm [ i ] = _rtB -> jaqhhc01c1 [ i
] ; } _rtB -> j5gfg55esl [ i ] = _rtB -> g5vchxe1br [ i ] * _rtB ->
et4o1kxcgm [ i ] * _rtB -> d2nn2dz4fd ; } } srUpdateBC ( _rtDW -> g4gjxdbtf4
) ; } if ( ssIsSampleHit ( S , 1 , tid ) ) { _rtB -> nea0ub3po4 [ 0 ] = _rtDW
-> bszocv0tyo [ 0 ] ; _rtB -> nea0ub3po4 [ 1 ] = _rtDW -> bszocv0tyo [ 1 ] ;
_rtB -> nea0ub3po4 [ 2 ] = _rtDW -> bszocv0tyo [ 2 ] ; _rtB -> nea0ub3po4 [ 3
] = _rtDW -> bszocv0tyo [ 3 ] ; if ( _rtB -> ic1qhk0fop > 0.0 ) { dotqdukedn
= 1.0 / ( ( 1.0 / _rtB -> pbt1aboirk [ 0 ] + 1.0 / _rtB -> pbt1aboirk [ 1 ] )
+ 1.0 / _rtDW -> gsu2qsejc5 ) ; jjsaaxpmip = _rtB -> kya5mnodh5 [ 0 ] *
dotqdukedn ; dotqdukedn *= _rtB -> kya5mnodh5 [ 1 ] ; at0f5ztich = ( _rtP ->
P_110 * _rtB -> nea0ub3po4 [ 0 ] - _rtDW -> ouueie1te2 [ 0 ] ) * jjsaaxpmip ;
jjsaaxpmip *= _rtP -> P_110 * _rtB -> nea0ub3po4 [ 1 ] - _rtDW -> ouueie1te2
[ 1 ] ; dotqdukedn = muDoubleScalarHypot ( ( _rtP -> P_110 * _rtB ->
nea0ub3po4 [ 2 ] - _rtDW -> ouueie1te2 [ 2 ] ) * dotqdukedn + at0f5ztich , (
_rtP -> P_110 * _rtB -> nea0ub3po4 [ 3 ] - _rtDW -> ouueie1te2 [ 3 ] ) *
dotqdukedn + jjsaaxpmip ) ; jjsaaxpmip = rt_Lookup ( _rtP -> P_7 , 2 ,
dotqdukedn , _rtP -> P_8 ) ; if ( jjsaaxpmip != 0.0 ) { _rtB -> km3tr3vhu1 =
dotqdukedn / jjsaaxpmip ; } else { _rtB -> km3tr3vhu1 = _rtB -> imtiszgtzp ;
} memcpy ( & czahtqwgjp [ 0 ] , & _rtB -> peh1rto3cb [ 0 ] , sizeof ( real_T
) << 4U ) ; czahtqwgjp [ 0 ] = _rtB -> km3tr3vhu1 ; czahtqwgjp [ 2 ] = _rtB
-> km3tr3vhu1 ; czahtqwgjp [ 8 ] = _rtB -> km3tr3vhu1 ; czahtqwgjp [ 10 ] =
_rtB -> km3tr3vhu1 ; czahtqwgjp [ 5 ] = _rtB -> km3tr3vhu1 ; czahtqwgjp [ 7 ]
= _rtB -> km3tr3vhu1 ; czahtqwgjp [ 13 ] = _rtB -> km3tr3vhu1 ; czahtqwgjp [
15 ] = _rtB -> km3tr3vhu1 ; for ( i = 0 ; i < 16 ; i ++ ) { fvgwbluoqv [ i ]
= czahtqwgjp [ i ] + _rtB -> izkabpihx5 [ i ] ; } rt_invd4x4_snf ( fvgwbluoqv
, _rtB -> cbhbyovptt ) ; for ( i = 0 ; i < 4 ; i ++ ) { for ( i_p = 0 ; i_p <
4 ; i_p ++ ) { _rtB -> k4jhmgh4zt [ i + ( i_p << 2 ) ] = 0.0 ; _rtB ->
k4jhmgh4zt [ i + ( i_p << 2 ) ] += _rtB -> cbhbyovptt [ i_p << 2 ] * _rtB ->
cjb3t1mtm1 [ i ] ; _rtB -> k4jhmgh4zt [ i + ( i_p << 2 ) ] += _rtB ->
cbhbyovptt [ ( i_p << 2 ) + 1 ] * _rtB -> cjb3t1mtm1 [ i + 4 ] ; _rtB ->
k4jhmgh4zt [ i + ( i_p << 2 ) ] += _rtB -> cbhbyovptt [ ( i_p << 2 ) + 2 ] *
_rtB -> cjb3t1mtm1 [ i + 8 ] ; _rtB -> k4jhmgh4zt [ i + ( i_p << 2 ) ] +=
_rtB -> cbhbyovptt [ ( i_p << 2 ) + 3 ] * _rtB -> cjb3t1mtm1 [ i + 12 ] ; } }
srUpdateBC ( _rtDW -> acymdtjqha ) ; } if ( _rtB -> juziei1xyn >= _rtP ->
P_115 ) { memcpy ( & fvgwbluoqv [ 0 ] , & _rtB -> cbhbyovptt [ 0 ] , sizeof (
real_T ) << 4U ) ; } else { memcpy ( & fvgwbluoqv [ 0 ] , & _rtB ->
owo3bzgu1j [ 0 ] , sizeof ( real_T ) << 4U ) ; } k5rrxb3wvw = ( _rtB ->
juziei1xyn >= _rtP -> P_115 ) ; for ( i = 0 ; i < 4 ; i ++ ) { if (
k5rrxb3wvw ) { czahtqwgjp [ i << 2 ] = _rtB -> cbhbyovptt [ i << 2 ] ;
czahtqwgjp [ 1 + ( i << 2 ) ] = _rtB -> cbhbyovptt [ ( i << 2 ) + 1 ] ;
czahtqwgjp [ 2 + ( i << 2 ) ] = _rtB -> cbhbyovptt [ ( i << 2 ) + 2 ] ;
czahtqwgjp [ 3 + ( i << 2 ) ] = _rtB -> cbhbyovptt [ ( i << 2 ) + 3 ] ; }
else { czahtqwgjp [ i << 2 ] = _rtB -> owo3bzgu1j [ i << 2 ] ; czahtqwgjp [ 1
+ ( i << 2 ) ] = _rtB -> owo3bzgu1j [ ( i << 2 ) + 1 ] ; czahtqwgjp [ 2 + ( i
<< 2 ) ] = _rtB -> owo3bzgu1j [ ( i << 2 ) + 2 ] ; czahtqwgjp [ 3 + ( i << 2
) ] = _rtB -> owo3bzgu1j [ ( i << 2 ) + 3 ] ; } h0fbysnpir = fvgwbluoqv [ i +
12 ] * _rtB -> nea0ub3po4 [ 3 ] + ( fvgwbluoqv [ i + 8 ] * _rtB -> nea0ub3po4
[ 2 ] + ( fvgwbluoqv [ i + 4 ] * _rtB -> nea0ub3po4 [ 1 ] + fvgwbluoqv [ i ]
* _rtB -> nea0ub3po4 [ 0 ] ) ) ; tmp [ i ] = h0fbysnpir ; } for ( i = 0 ; i <
4 ; i ++ ) { ltzae3biwo = czahtqwgjp [ i + 12 ] * _rtB -> nea0ub3po4 [ 3 ] +
( czahtqwgjp [ i + 8 ] * _rtB -> nea0ub3po4 [ 2 ] + ( czahtqwgjp [ i + 4 ] *
_rtB -> nea0ub3po4 [ 1 ] + czahtqwgjp [ i ] * _rtB -> nea0ub3po4 [ 0 ] ) ) ;
oa5gdo2ksv [ i ] = ltzae3biwo ; } h0fbysnpir = _rtDW -> cdtfqsi0l1 ; _rtB ->
b33xuvzasm = _rtDW -> kceslciih5 ; ltzae3biwo = _rtP -> P_120 * _rtB ->
b33xuvzasm - _rtDW -> ncjoabwnvn ; jxn3aafqxu = _rtP -> P_178 ; if (
ssIsSampleHit ( S , 1 , tid ) ) { if ( jxn3aafqxu ) { if ( ! _rtDW ->
gokc04mjjs ) { _rtDW -> gokc04mjjs = true ; } } else { if ( _rtDW ->
gokc04mjjs ) { _rtB -> exqugokhi0 = _rtP -> P_33 ; _rtB -> lj3miep0wk = _rtP
-> P_33 ; _rtB -> a2tb0bwypj [ 0 ] = _rtP -> P_33 ; _rtB -> a2tb0bwypj [ 1 ]
= _rtP -> P_33 ; for ( i = 0 ; i < 16 ; i ++ ) { _rtB -> i2ooc0u2f3 [ i ] =
_rtP -> P_34 ; } _rtDW -> gokc04mjjs = false ; } } } if ( _rtDW -> gokc04mjjs
) { _rtB -> a2tb0bwypj [ 0 ] = _rtP -> P_35 [ 0 ] ; _rtB -> a2tb0bwypj [ 1 ]
= _rtP -> P_35 [ 1 ] ; _rtB -> exqugokhi0 = muDoubleScalarSin ( _rtDW ->
cdtfqsi0l1 ) ; _rtB -> lj3miep0wk = muDoubleScalarCos ( _rtDW -> cdtfqsi0l1 )
; memcpy ( & czahtqwgjp [ 0 ] , & _rtB -> hik4td4f5a [ 0 ] , sizeof ( real_T
) << 4U ) ; czahtqwgjp [ 4 ] = ltzae3biwo ; memcpy ( & _rtB -> i2ooc0u2f3 [ 0
] , & czahtqwgjp [ 0 ] , sizeof ( real_T ) << 4U ) ; _rtB -> i2ooc0u2f3 [ 1 ]
= _rtP -> P_36 * ltzae3biwo ; srUpdateBC ( _rtDW -> lkapeddomn ) ; }
djud1xju4l = _rtP -> P_179 ; if ( ssIsSampleHit ( S , 1 , tid ) ) { if (
djud1xju4l ) { if ( ! _rtDW -> jxaswxbb5p ) { _rtDW -> jxaswxbb5p = true ; }
} else { if ( _rtDW -> jxaswxbb5p ) { _rtB -> cz4tq5c5tx = _rtP -> P_38 ;
_rtB -> njv1anfzvk = _rtP -> P_38 ; _rtB -> b22kcyc3wh [ 0 ] = _rtP -> P_38 ;
_rtB -> b22kcyc3wh [ 1 ] = _rtP -> P_38 ; _rtDW -> jxaswxbb5p = false ; } } }
if ( _rtDW -> jxaswxbb5p ) { _rtB -> b22kcyc3wh [ 0 ] = _rtP -> P_40 [ 0 ] ;
_rtB -> b22kcyc3wh [ 1 ] = _rtP -> P_40 [ 1 ] ; _rtB -> cz4tq5c5tx =
muDoubleScalarSin ( h0fbysnpir ) ; _rtB -> njv1anfzvk = muDoubleScalarCos (
h0fbysnpir ) ; memcpy ( & czahtqwgjp [ 0 ] , & _rtB -> bpfnj4sfof [ 0 ] ,
sizeof ( real_T ) << 4U ) ; czahtqwgjp [ 14 ] = _rtP -> P_41 * ltzae3biwo ;
memcpy ( & _rtB -> c4bq3snuog [ 0 ] , & czahtqwgjp [ 0 ] , sizeof ( real_T )
<< 4U ) ; _rtB -> c4bq3snuog [ 11 ] = ltzae3biwo ; srUpdateBC ( _rtDW ->
annpiv55ji ) ; } _rtB -> pgbvtjvjji = _rtP -> P_180 ; if ( _rtB -> pgbvtjvjji
) { iexjb5pvme = ssGetTaskTime ( S , 1 ) ; dotqdukedn = _rtP -> P_29 -
ltzae3biwo ; iexjb5pvme *= _rtP -> P_31 ; jjsaaxpmip = iexjb5pvme -
h0fbysnpir ; _rtB -> o0hba3wvz1 = muDoubleScalarSin ( iexjb5pvme ) ; _rtB ->
c0rehhbh0w = muDoubleScalarSin ( jjsaaxpmip ) ; _rtB -> d3cf3jnd4h =
muDoubleScalarCos ( jjsaaxpmip ) ; _rtB -> gofsmt25fs = muDoubleScalarCos (
iexjb5pvme ) ; memcpy ( & czahtqwgjp [ 0 ] , & _rtB -> lgbuh3irbe [ 0 ] ,
sizeof ( real_T ) << 4U ) ; czahtqwgjp [ 14 ] = dotqdukedn ; memcpy ( & _rtB
-> ndracdr2tc [ 0 ] , & czahtqwgjp [ 0 ] , sizeof ( real_T ) << 4U ) ; _rtB
-> ndracdr2tc [ 11 ] = _rtP -> P_30 * dotqdukedn ; srUpdateBC ( _rtDW ->
knoumelfng ) ; } switch ( ( int32_T ) _rtB -> ghgo3bvffu ) { case 1 :
emmpw0nmca = _rtB -> exqugokhi0 ; hx0ttdnun1_idx_1 = _rtB -> lj3miep0wk ;
hx0ttdnun1_idx_2 = _rtB -> a2tb0bwypj [ 0 ] ; hx0ttdnun1_idx_3 = _rtB ->
a2tb0bwypj [ 1 ] ; break ; case 2 : emmpw0nmca = _rtB -> cz4tq5c5tx ;
hx0ttdnun1_idx_1 = _rtB -> njv1anfzvk ; hx0ttdnun1_idx_2 = _rtB -> b22kcyc3wh
[ 0 ] ; hx0ttdnun1_idx_3 = _rtB -> b22kcyc3wh [ 1 ] ; break ; default :
emmpw0nmca = _rtB -> c0rehhbh0w ; hx0ttdnun1_idx_1 = _rtB -> d3cf3jnd4h ;
hx0ttdnun1_idx_2 = _rtB -> o0hba3wvz1 ; hx0ttdnun1_idx_3 = _rtB -> gofsmt25fs
; break ; } dmn4ug0nez = _rtP -> P_181 ; if ( dmn4ug0nez ) { if ( ! _rtDW ->
ezmbiybclp ) { _rtDW -> ezmbiybclp = true ; } _rtB -> agnrm4wpm2 = tmp [ 2 ]
; _rtB -> djabm4ddg5 = - ( 1.7320508075688772 * tmp [ 3 ] + tmp [ 2 ] ) / 2.0
; _rtB -> dm4ckq23zy = hx0ttdnun1_idx_1 * tmp [ 0 ] + emmpw0nmca * tmp [ 1 ]
; _rtB -> edj2fdsgsh = ( ( 1.7320508075688772 * emmpw0nmca + -
hx0ttdnun1_idx_1 ) * tmp [ 0 ] + ( - 1.7320508075688772 * hx0ttdnun1_idx_1 -
emmpw0nmca ) * tmp [ 1 ] ) / 2.0 ; srUpdateBC ( _rtDW -> bxlw3ktkwg ) ; }
else { if ( _rtDW -> ezmbiybclp ) { _rtB -> agnrm4wpm2 = _rtP -> P_21 ; _rtB
-> djabm4ddg5 = _rtP -> P_21 ; _rtB -> dm4ckq23zy = _rtP -> P_22 ; _rtB ->
edj2fdsgsh = _rtP -> P_22 ; _rtDW -> ezmbiybclp = false ; } } iry3cdheo0 =
_rtP -> P_182 ; if ( iry3cdheo0 ) { if ( ! _rtDW -> p2os3mgan1 ) { _rtDW ->
p2os3mgan1 = true ; } _rtB -> ar3d44t0mw = hx0ttdnun1_idx_1 * tmp [ 2 ] -
emmpw0nmca * tmp [ 3 ] ; _rtB -> exjvqbk2yx = ( ( - hx0ttdnun1_idx_1 -
1.7320508075688772 * emmpw0nmca ) * tmp [ 2 ] + ( emmpw0nmca -
1.7320508075688772 * hx0ttdnun1_idx_1 ) * tmp [ 3 ] ) / 2.0 ; _rtB ->
or3vn0c2sx = tmp [ 0 ] ; _rtB -> hhfvbop5gc = - ( 1.7320508075688772 * tmp [
1 ] + tmp [ 0 ] ) / 2.0 ; srUpdateBC ( _rtDW -> agggnp0k0g ) ; } else { if (
_rtDW -> p2os3mgan1 ) { _rtB -> ar3d44t0mw = _rtP -> P_23 ; _rtB ->
exjvqbk2yx = _rtP -> P_23 ; _rtB -> or3vn0c2sx = _rtP -> P_24 ; _rtB ->
hhfvbop5gc = _rtP -> P_24 ; _rtDW -> p2os3mgan1 = false ; } } jzh0jvxjmi =
_rtP -> P_183 ; if ( jzh0jvxjmi ) { if ( ! _rtDW -> kgmnbly2rm ) { _rtDW ->
kgmnbly2rm = true ; } _rtB -> h3t5dx531i = hx0ttdnun1_idx_1 * tmp [ 2 ] +
emmpw0nmca * tmp [ 3 ] ; _rtB -> iht5xnejg2 = ( ( 1.7320508075688772 *
emmpw0nmca + - hx0ttdnun1_idx_1 ) * tmp [ 2 ] + ( - 1.7320508075688772 *
hx0ttdnun1_idx_1 - emmpw0nmca ) * tmp [ 3 ] ) / 2.0 ; _rtB -> gpfbpupqnm =
hx0ttdnun1_idx_3 * tmp [ 0 ] + hx0ttdnun1_idx_2 * tmp [ 1 ] ; _rtB ->
cgvbl5megu = ( ( 1.7320508075688772 * hx0ttdnun1_idx_2 + - hx0ttdnun1_idx_3 )
* tmp [ 0 ] + ( - 1.7320508075688772 * hx0ttdnun1_idx_3 - hx0ttdnun1_idx_2 )
* tmp [ 1 ] ) / 2.0 ; srUpdateBC ( _rtDW -> ce2siojray ) ; } else { if (
_rtDW -> kgmnbly2rm ) { _rtB -> h3t5dx531i = _rtP -> P_25 ; _rtB ->
iht5xnejg2 = _rtP -> P_25 ; _rtB -> gpfbpupqnm = _rtP -> P_26 ; _rtB ->
cgvbl5megu = _rtP -> P_26 ; _rtDW -> kgmnbly2rm = false ; } } switch ( (
int32_T ) _rtB -> fxcjfqn45x ) { case 1 : jjsaaxpmip = _rtB -> agnrm4wpm2 ;
dotqdukedn = _rtB -> djabm4ddg5 ; break ; case 2 : jjsaaxpmip = _rtB ->
ar3d44t0mw ; dotqdukedn = _rtB -> exjvqbk2yx ; break ; default : jjsaaxpmip =
_rtB -> h3t5dx531i ; dotqdukedn = _rtB -> iht5xnejg2 ; break ; } switch ( (
int32_T ) _rtB -> bvgt3f4ra0 ) { case 1 : at0f5ztich = _rtB -> dm4ckq23zy ;
ivejv0gvvj_idx_1 = _rtB -> edj2fdsgsh ; break ; case 2 : at0f5ztich = _rtB ->
or3vn0c2sx ; ivejv0gvvj_idx_1 = _rtB -> hhfvbop5gc ; break ; default :
at0f5ztich = _rtB -> gpfbpupqnm ; ivejv0gvvj_idx_1 = _rtB -> cgvbl5megu ;
break ; } _rtB -> be3sn2ksyl [ 0 ] = _rtP -> P_123 * jjsaaxpmip ; _rtB ->
be3sn2ksyl [ 2 ] = _rtP -> P_123 * at0f5ztich ; _rtB -> be3sn2ksyl [ 1 ] =
_rtP -> P_123 * dotqdukedn ; _rtB -> be3sn2ksyl [ 3 ] = _rtP -> P_123 *
ivejv0gvvj_idx_1 ; ssCallAccelRunBlock ( S , 57 , 46 , SS_CALL_MDL_OUTPUTS )
; na02q54ej0_idx_0 = _rtP -> P_127 * _rtB -> dkhxjchsqi [ 0 ] ;
na02q54ej0_idx_2 = _rtP -> P_127 * _rtB -> mgec5i0prc [ 6 ] ;
na02q54ej0_idx_1 = _rtP -> P_127 * _rtB -> dkhxjchsqi [ 1 ] ;
na02q54ej0_idx_3 = _rtP -> P_127 * _rtB -> mgec5i0prc [ 7 ] ; e3blb333rs =
_rtP -> P_184 ; if ( e3blb333rs ) { if ( ! _rtDW -> iligozqyuj ) { _rtDW ->
iligozqyuj = true ; } _rtB -> d3w3qs14my = - 0.57735026918962573 *
na02q54ej0_idx_1 ; _rtB -> ib4s3q0qwg = ( ( emmpw0nmca - 1.7320508075688772 *
hx0ttdnun1_idx_1 ) * na02q54ej0_idx_3 + 2.0 * emmpw0nmca * na02q54ej0_idx_2 )
* 0.33333333333333331 ; _rtB -> pnykkovok2 = ( 2.0 * na02q54ej0_idx_0 +
na02q54ej0_idx_1 ) * 0.33333333333333331 ; _rtB -> itsgac2mwd = ( (
1.7320508075688772 * emmpw0nmca + hx0ttdnun1_idx_1 ) * na02q54ej0_idx_3 + 2.0
* hx0ttdnun1_idx_1 * na02q54ej0_idx_2 ) * 0.33333333333333331 ; srUpdateBC (
_rtDW -> nzaztfr003 ) ; } else { if ( _rtDW -> iligozqyuj ) { _rtB ->
pnykkovok2 = _rtP -> P_15 ; _rtB -> d3w3qs14my = _rtP -> P_15 ; _rtB ->
itsgac2mwd = _rtP -> P_16 ; _rtB -> ib4s3q0qwg = _rtP -> P_16 ; _rtDW ->
iligozqyuj = false ; } } jcz5w35jhj = _rtP -> P_185 ; if ( jcz5w35jhj ) { if
( ! _rtDW -> nt1wtowpvf ) { _rtDW -> nt1wtowpvf = true ; } _rtB -> ed5d34x1ak
= ( ( - emmpw0nmca - 1.7320508075688772 * hx0ttdnun1_idx_1 ) *
na02q54ej0_idx_1 + - 2.0 * emmpw0nmca * na02q54ej0_idx_0 ) *
0.33333333333333331 ; _rtB -> ipcem2dstn = - 0.57735026918962573 *
na02q54ej0_idx_3 ; _rtB -> lgwjwlxwns = ( ( hx0ttdnun1_idx_1 -
1.7320508075688772 * emmpw0nmca ) * na02q54ej0_idx_1 + 2.0 * hx0ttdnun1_idx_1
* na02q54ej0_idx_0 ) * 0.33333333333333331 ; _rtB -> nwjwmdqcj1 = ( 2.0 *
na02q54ej0_idx_2 + na02q54ej0_idx_3 ) * 0.33333333333333331 ; srUpdateBC (
_rtDW -> ittuqihwmh ) ; } else { if ( _rtDW -> nt1wtowpvf ) { _rtB ->
lgwjwlxwns = _rtP -> P_17 ; _rtB -> ed5d34x1ak = _rtP -> P_17 ; _rtB ->
nwjwmdqcj1 = _rtP -> P_18 ; _rtB -> ipcem2dstn = _rtP -> P_18 ; _rtDW ->
nt1wtowpvf = false ; } } ljvfec2xnv = _rtP -> P_186 ; if ( ljvfec2xnv ) { if
( ! _rtDW -> gbjgc4fwuh ) { _rtDW -> gbjgc4fwuh = true ; } _rtB -> g4xazbyidf
= ( ( emmpw0nmca - 1.7320508075688772 * hx0ttdnun1_idx_1 ) * na02q54ej0_idx_1
+ 2.0 * emmpw0nmca * na02q54ej0_idx_0 ) / 3.0 ; _rtB -> lslndk0wz4 = ( (
hx0ttdnun1_idx_2 - 1.7320508075688772 * hx0ttdnun1_idx_3 ) * na02q54ej0_idx_3
+ 2.0 * hx0ttdnun1_idx_2 * na02q54ej0_idx_2 ) / 3.0 ; _rtB -> egj514vrnw = (
( 1.7320508075688772 * emmpw0nmca + hx0ttdnun1_idx_1 ) * na02q54ej0_idx_1 +
2.0 * hx0ttdnun1_idx_1 * na02q54ej0_idx_0 ) / 3.0 ; _rtB -> ahpbplehws = ( (
1.7320508075688772 * hx0ttdnun1_idx_2 + hx0ttdnun1_idx_3 ) * na02q54ej0_idx_3
+ 2.0 * hx0ttdnun1_idx_3 * na02q54ej0_idx_2 ) / 3.0 ; srUpdateBC ( _rtDW ->
a4beromfz1 ) ; } else { if ( _rtDW -> gbjgc4fwuh ) { _rtB -> egj514vrnw =
_rtP -> P_19 ; _rtB -> g4xazbyidf = _rtP -> P_19 ; _rtB -> ahpbplehws = _rtP
-> P_20 ; _rtB -> lslndk0wz4 = _rtP -> P_20 ; _rtDW -> gbjgc4fwuh = false ; }
} switch ( ( int32_T ) _rtB -> balzupoiv5 ) { case 1 : _rtB -> pprqyj24tg [ 0
] = _rtB -> pnykkovok2 ; _rtB -> pprqyj24tg [ 1 ] = _rtB -> d3w3qs14my ;
break ; case 2 : _rtB -> pprqyj24tg [ 0 ] = _rtB -> lgwjwlxwns ; _rtB ->
pprqyj24tg [ 1 ] = _rtB -> ed5d34x1ak ; break ; default : _rtB -> pprqyj24tg
[ 0 ] = _rtB -> egj514vrnw ; _rtB -> pprqyj24tg [ 1 ] = _rtB -> g4xazbyidf ;
break ; } switch ( ( int32_T ) _rtB -> ap4u2yd03u ) { case 1 : _rtB ->
msixc3clly [ 0 ] = _rtB -> itsgac2mwd ; _rtB -> msixc3clly [ 1 ] = _rtB ->
ib4s3q0qwg ; break ; case 2 : _rtB -> msixc3clly [ 0 ] = _rtB -> nwjwmdqcj1 ;
_rtB -> msixc3clly [ 1 ] = _rtB -> ipcem2dstn ; break ; default : _rtB ->
msixc3clly [ 0 ] = _rtB -> ahpbplehws ; _rtB -> msixc3clly [ 1 ] = _rtB ->
lslndk0wz4 ; break ; } if ( _rtB -> bq0y2ocaux >= _rtP -> P_131 ) {
jm05egcgqw = _rtB -> km3tr3vhu1 ; } else { jm05egcgqw = _rtB -> ar1cxc4uvb ;
} hodzy2wu5w_p [ 2 ] = ( 0.0 - jjsaaxpmip ) - dotqdukedn ; hodzy2wu5w_p [ 11
] = ( 0.0 - at0f5ztich ) - ivejv0gvvj_idx_1 ; hodzy2wu5w_p [ 0 ] = jjsaaxpmip
; hodzy2wu5w_p [ 3 ] = tmp [ 2 ] ; hodzy2wu5w_p [ 5 ] = _rtB -> nea0ub3po4 [
2 ] ; hodzy2wu5w_p [ 7 ] = _rtB -> pprqyj24tg [ 0 ] ; hodzy2wu5w_p [ 9 ] =
at0f5ztich ; hodzy2wu5w_p [ 12 ] = tmp [ 0 ] ; hodzy2wu5w_p [ 14 ] = _rtB ->
nea0ub3po4 [ 0 ] ; hodzy2wu5w_p [ 16 ] = _rtB -> msixc3clly [ 0 ] ;
hodzy2wu5w_p [ 1 ] = dotqdukedn ; hodzy2wu5w_p [ 4 ] = tmp [ 3 ] ;
hodzy2wu5w_p [ 6 ] = _rtB -> nea0ub3po4 [ 3 ] ; hodzy2wu5w_p [ 8 ] = _rtB ->
pprqyj24tg [ 1 ] ; hodzy2wu5w_p [ 10 ] = ivejv0gvvj_idx_1 ; hodzy2wu5w_p [ 13
] = tmp [ 1 ] ; hodzy2wu5w_p [ 15 ] = _rtB -> nea0ub3po4 [ 1 ] ; hodzy2wu5w_p
[ 17 ] = _rtB -> msixc3clly [ 1 ] ; hodzy2wu5w_p [ 18 ] = jm05egcgqw ; for (
i = 0 ; i < 19 ; i ++ ) { _rtB -> ajnavdmum5 [ i ] = _rtP -> P_132 [ i ] *
hodzy2wu5w_p [ i ] ; } bqesw0kw3i . re = _rtB -> ajnavdmum5 [ 13 ] ;
bqesw0kw3i . im = _rtB -> ajnavdmum5 [ 12 ] ; _rtB -> droxlmzoaq . re = _rtP
-> P_171 . re * bqesw0kw3i . re - _rtP -> P_171 . im * bqesw0kw3i . im ; _rtB
-> droxlmzoaq . im = _rtP -> P_171 . re * bqesw0kw3i . im + _rtP -> P_171 .
im * bqesw0kw3i . re ; if ( ssIsSpecialSampleHit ( S , 2 , 1 , tid ) ) { _rtB
-> fg3o0jidy0 = _rtB -> droxlmzoaq ; } _rtB -> ju5zje34v5 = _rtP -> P_133 [ 0
] * oa5gdo2ksv [ 0 ] * _rtB -> nea0ub3po4 [ 1 ] + _rtP -> P_133 [ 1 ] *
oa5gdo2ksv [ 1 ] * _rtB -> nea0ub3po4 [ 0 ] ; jm05egcgqw = _rtP -> P_134 *
h0fbysnpir ; oooq3ntnjh_idx_0 = _rtP -> P_135 [ 0 ] * ltzae3biwo ; _rtB ->
lif2ujrjlb = _rtP -> P_135 [ 1 ] * _rtB -> ju5zje34v5 * _rtP -> P_136 ; if (
ssIsSpecialSampleHit ( S , 2 , 1 , tid ) ) { _rtB -> g5vtwqshjs = _rtB ->
lif2ujrjlb ; } } if ( ssIsSampleHit ( S , 2 , tid ) ) { _rtB -> coqafup3bn =
_rtB -> fg3o0jidy0 . re ; ssCallAccelRunBlock ( S , 55 , 0 ,
SS_CALL_MDL_OUTPUTS ) ; ssCallAccelRunBlock ( S , 57 , 77 ,
SS_CALL_MDL_OUTPUTS ) ; } if ( ssIsSampleHit ( S , 1 , tid ) ) { jm05egcgqw =
_rtP -> P_137 ; for ( i = 0 ; i < 6 ; i ++ ) { if ( _rtB -> g0512whzvs [ i ]
>= _rtP -> P_139 ) { jjsaaxpmip = _rtP -> P_138 * _rtB -> mgec5i0prc [ i ] ;
} else { jjsaaxpmip = jm05egcgqw ; } if ( jjsaaxpmip > _rtP -> P_140 ) { _rtB
-> heoonygn34 [ i ] = _rtP -> P_140 ; } else if ( jjsaaxpmip < _rtP -> P_141
) { _rtB -> heoonygn34 [ i ] = _rtP -> P_141 ; } else { _rtB -> heoonygn34 [
i ] = jjsaaxpmip ; } } _rtB -> px2wrt4bzq = _rtP -> P_142 * oooq3ntnjh_idx_0
; if ( ssIsSpecialSampleHit ( S , 2 , 1 , tid ) ) { memcpy ( & _rtB ->
hiahhbcu2n [ 0 ] , & _rtB -> hfxiqmdpwu [ 10 ] , 9U * sizeof ( real_T ) ) ;
_rtB -> gngfgwgcex = _rtB -> px2wrt4bzq ; } bqesw0kw3i . re = _rtB ->
ajnavdmum5 [ 6 ] ; bqesw0kw3i . im = _rtB -> ajnavdmum5 [ 5 ] ;
oooq3ntnjh_idx_0 = _rtP -> P_172 . re * bqesw0kw3i . im + _rtP -> P_172 . im
* bqesw0kw3i . re ; bqesw0kw3i . re = _rtP -> P_172 . re * bqesw0kw3i . re -
_rtP -> P_172 . im * bqesw0kw3i . im ; bqesw0kw3i . im = oooq3ntnjh_idx_0 ;
if ( ssIsSpecialSampleHit ( S , 2 , 1 , tid ) ) { _rtB -> lg313mbgzy =
bqesw0kw3i ; } } if ( ssIsSampleHit ( S , 2 , tid ) ) { _rtB -> irzaljp23x =
_rtP -> P_143 * _rtB -> gngfgwgcex ; _rtB -> khpkum21sg = _rtB -> lg313mbgzy
. re ; _rtB -> hrqudmouex = _rtB -> lg313mbgzy . im ; ssCallAccelRunBlock ( S
, 57 , 96 , SS_CALL_MDL_OUTPUTS ) ; ssCallAccelRunBlock ( S , 57 , 97 ,
SS_CALL_MDL_OUTPUTS ) ; _rtB -> hrqudmouex = _rtP -> P_144 * _rtB ->
hiahhbcu2n [ 4 ] ; ssCallAccelRunBlock ( S , 57 , 99 , SS_CALL_MDL_OUTPUTS )
; } if ( ssIsSampleHit ( S , 1 , tid ) ) { _rtB -> ju4hmz0xd5 = _rtP -> P_145
* _rtB -> ajnavdmum5 [ 15 ] ; ssCallAccelRunBlock ( S , 57 , 101 ,
SS_CALL_MDL_OUTPUTS ) ; jm05egcgqw = _rtP -> P_146 * _rtB -> mgec5i0prc [ 9 ]
; _rtB -> ozvkjjrhef [ 0 ] = _rtP -> P_149 * jm05egcgqw ; _rtB -> ozvkjjrhef
[ 1 ] = _rtP -> P_147 * _rtB -> mgec5i0prc [ 10 ] * _rtP -> P_149 ; _rtB ->
ozvkjjrhef [ 2 ] = _rtP -> P_148 * _rtB -> mgec5i0prc [ 11 ] * _rtP -> P_149
; jm05egcgqw = _rtP -> P_150 * _rtB -> mgec5i0prc [ 12 ] ; _rtB -> eq5isdhr3e
[ 0 ] = _rtP -> P_153 * jm05egcgqw ; _rtB -> eq5isdhr3e [ 1 ] = _rtP -> P_151
* _rtB -> mgec5i0prc [ 13 ] * _rtP -> P_153 ; _rtB -> eq5isdhr3e [ 2 ] = _rtP
-> P_152 * _rtB -> mgec5i0prc [ 14 ] * _rtP -> P_153 ; ssCallAccelRunBlock (
S , 57 , 110 , SS_CALL_MDL_OUTPUTS ) ; oa5gdo2ksv [ 0 ] = _rtDW -> gvzeb4nlpb
[ 0 ] ; oa5gdo2ksv [ 1 ] = _rtDW -> gvzeb4nlpb [ 1 ] ; oa5gdo2ksv [ 2 ] =
_rtDW -> gvzeb4nlpb [ 2 ] ; oa5gdo2ksv [ 3 ] = _rtDW -> gvzeb4nlpb [ 3 ] ;
jm05egcgqw = ssGetTaskTime ( S , 1 ) ; if ( jm05egcgqw >= _rtP -> P_159 ) {
switch ( ( int32_T ) _rtB -> glodq2hqqo ) { case 1 : memcpy ( & czahtqwgjp [
0 ] , & _rtB -> i2ooc0u2f3 [ 0 ] , sizeof ( real_T ) << 4U ) ; break ; case 2
: memcpy ( & czahtqwgjp [ 0 ] , & _rtB -> c4bq3snuog [ 0 ] , sizeof ( real_T
) << 4U ) ; break ; default : memcpy ( & czahtqwgjp [ 0 ] , & _rtB ->
ndracdr2tc [ 0 ] , sizeof ( real_T ) << 4U ) ; break ; } k5rrxb3wvw = ( _rtB
-> m34j5lish0 >= _rtP -> P_12 ) ; for ( i = 0 ; i < 16 ; i ++ ) { if (
k5rrxb3wvw ) { h0fbysnpir = _rtB -> k4jhmgh4zt [ i ] ; } else { h0fbysnpir =
_rtB -> llus0uca25 [ i ] ; } oooq3ntnjh_idx_0 = ( ( 0.0 - czahtqwgjp [ i ] )
- h0fbysnpir ) * _rtP -> P_13 ; fvgwbluoqv [ i ] = _rtB -> a1chqz1hpu [ i ] -
oooq3ntnjh_idx_0 ; oooq3ntnjh_idx_0 += _rtB -> a1chqz1hpu [ i ] ; czahtqwgjp
[ i ] = oooq3ntnjh_idx_0 ; } rt_invd4x4_snf ( fvgwbluoqv , ckfygvafbr ) ; for
( i = 0 ; i < 4 ; i ++ ) { for ( i_p = 0 ; i_p < 4 ; i_p ++ ) { fvgwbluoqv [
i + ( i_p << 2 ) ] = 0.0 ; fvgwbluoqv [ i + ( i_p << 2 ) ] += czahtqwgjp [
i_p << 2 ] * ckfygvafbr [ i ] ; fvgwbluoqv [ i + ( i_p << 2 ) ] += czahtqwgjp
[ ( i_p << 2 ) + 1 ] * ckfygvafbr [ i + 4 ] ; fvgwbluoqv [ i + ( i_p << 2 ) ]
+= czahtqwgjp [ ( i_p << 2 ) + 2 ] * ckfygvafbr [ i + 8 ] ; fvgwbluoqv [ i +
( i_p << 2 ) ] += czahtqwgjp [ ( i_p << 2 ) + 3 ] * ckfygvafbr [ i + 12 ] ; }
} tmp_p [ 0 ] = _rtB -> msixc3clly [ 0 ] ; tmp_p [ 2 ] = _rtB -> pprqyj24tg [
0 ] ; tmp_p [ 1 ] = _rtB -> msixc3clly [ 1 ] ; tmp_p [ 3 ] = _rtB ->
pprqyj24tg [ 1 ] ; for ( i = 0 ; i < 4 ; i ++ ) { tmp [ i ] = tmp_p [ i ] +
oa5gdo2ksv [ i ] ; oooq3ntnjh_idx_0 = fvgwbluoqv [ i + 12 ] * _rtB ->
nea0ub3po4 [ 3 ] + ( fvgwbluoqv [ i + 8 ] * _rtB -> nea0ub3po4 [ 2 ] + (
fvgwbluoqv [ i + 4 ] * _rtB -> nea0ub3po4 [ 1 ] + fvgwbluoqv [ i ] * _rtB ->
nea0ub3po4 [ 0 ] ) ) ; ptruiulzxg [ i ] = oooq3ntnjh_idx_0 ; } for ( i = 0 ;
i < 4 ; i ++ ) { h0fbysnpir = ckfygvafbr [ i + 12 ] * _rtP -> P_14 * tmp [ 3
] + ( ckfygvafbr [ i + 8 ] * _rtP -> P_14 * tmp [ 2 ] + ( ckfygvafbr [ i + 4
] * _rtP -> P_14 * tmp [ 1 ] + _rtP -> P_14 * ckfygvafbr [ i ] * tmp [ 0 ] )
) ; _rtB -> p4cn11yydt [ i ] = ptruiulzxg [ i ] + h0fbysnpir ; } } else {
_rtB -> p4cn11yydt [ 0 ] = _rtB -> nea0ub3po4 [ 0 ] ; _rtB -> p4cn11yydt [ 1
] = _rtB -> nea0ub3po4 [ 1 ] ; _rtB -> p4cn11yydt [ 2 ] = _rtB -> nea0ub3po4
[ 2 ] ; _rtB -> p4cn11yydt [ 3 ] = _rtB -> nea0ub3po4 [ 3 ] ; } } if (
ssIsContinuousTask ( S , tid ) ) { nkn0xd40ra = ssGetT ( S ) ; _rtB ->
dirihi4d1f = rt_Lookup ( _rtP -> P_160 , 7 , nkn0xd40ra , _rtP -> P_161 ) ;
nvra3kied3 = _rtP -> P_162 * _rtB -> dirihi4d1f ; } if ( ssIsSampleHit ( S ,
1 , tid ) ) { _rtB -> j5uqnv4wrs = _rtP -> P_163 * ltzae3biwo ; } if (
ssIsContinuousTask ( S , tid ) ) { _rtB -> ar1qhylpb2 = ( ( _rtB ->
ju5zje34v5 - nvra3kied3 ) - _rtB -> j5uqnv4wrs ) * _rtP -> P_164 ; } if (
ssIsSampleHit ( S , 1 , tid ) ) { if ( _rtDW -> i43q2xnv5j != 0 ) { _rtB ->
hsrdaalytc = _rtDW -> mnsh4qcssa ; } else { _rtB -> hsrdaalytc = _rtP ->
P_165 * _rtB -> ar1qhylpb2 + _rtDW -> mnsh4qcssa ; } _rtB -> gjbljg3km3 =
_rtP -> P_167 * ltzae3biwo ; ssCallAccelRunBlock ( S , 57 , 132 ,
SS_CALL_MDL_OUTPUTS ) ; jm05egcgqw = muDoubleScalarAtan2 ( bqesw0kw3i . im ,
bqesw0kw3i . re ) ; nvra3kied3 = _rtP -> P_173 . im * jm05egcgqw ; ltzae3biwo
= muDoubleScalarExp ( _rtP -> P_173 . re * jm05egcgqw ) ; if ( nvra3kied3 ==
0.0 ) { oooq3ntnjh_idx_0 = ltzae3biwo ; nvra3kied3 = 0.0 ; } else {
oooq3ntnjh_idx_0 = ltzae3biwo * muDoubleScalarCos ( nvra3kied3 ) ; nvra3kied3
= ltzae3biwo * muDoubleScalarSin ( nvra3kied3 ) ; } _rtB -> oo2ave1pfv . re =
bqesw0kw3i . re * oooq3ntnjh_idx_0 - bqesw0kw3i . im * nvra3kied3 ; _rtB ->
oo2ave1pfv . im = bqesw0kw3i . re * nvra3kied3 + bqesw0kw3i . im *
oooq3ntnjh_idx_0 ; ssCallAccelRunBlock ( S , 57 , 137 , SS_CALL_MDL_OUTPUTS )
; } if ( ssIsContinuousTask ( S , tid ) ) { if ( ( _rtDW -> ipuephsfr2 >=
ssGetT ( S ) ) && ( _rtDW -> mum3ya2p14 >= ssGetT ( S ) ) ) { _rtB ->
i2pzgsxk4x = 0.0 ; } else { nvra3kied3 = _rtDW -> ipuephsfr2 ; lastU = &
_rtDW -> ciiwswlqrh ; if ( _rtDW -> ipuephsfr2 < _rtDW -> mum3ya2p14 ) { if (
_rtDW -> mum3ya2p14 < ssGetT ( S ) ) { nvra3kied3 = _rtDW -> mum3ya2p14 ;
lastU = & _rtDW -> kzh4nj2v3e ; } } else { if ( _rtDW -> ipuephsfr2 >= ssGetT
( S ) ) { nvra3kied3 = _rtDW -> mum3ya2p14 ; lastU = & _rtDW -> kzh4nj2v3e ;
} } _rtB -> i2pzgsxk4x = ( _rtB -> dirihi4d1f - * lastU ) / ( ssGetT ( S ) -
nvra3kied3 ) ; } } if ( ssIsSampleHit ( S , 1 , tid ) ) { _rtB -> oo2cxneq23
= _rtP -> P_169 * _rtB -> mgec5i0prc [ 8 ] ; ssCallAccelRunBlock ( S , 57 ,
177 , SS_CALL_MDL_OUTPUTS ) ; } UNUSED_PARAMETER ( tid ) ; } static void
mdlOutputsTID3 ( SimStruct * S , int_T tid ) { int32_T i ; jmhfl0vfej * _rtB
; pb0dk03pgo * _rtP ; msq0uno1m5 * _rtDW ; _rtDW = ( ( msq0uno1m5 * )
ssGetRootDWork ( S ) ) ; _rtP = ( ( pb0dk03pgo * ) ssGetDefaultParam ( S ) )
; _rtB = ( ( jmhfl0vfej * ) _ssGetBlockIO ( S ) ) ; _rtB -> iatkzgc1lw = _rtP
-> P_66 ; for ( i = 0 ; i < 7 ; i ++ ) { _rtB -> f1kxbsvkxh [ i ] = _rtP ->
P_48 [ i ] ; } _rtB -> nmyvksrejv [ 0 ] = _rtP -> P_49 [ 0 ] ; _rtB ->
nmyvksrejv [ 1 ] = _rtP -> P_49 [ 1 ] ; srUpdateBC ( _rtDW -> pwcaihzxxr ) ;
_rtB -> khmzhv1ntc = _rtP -> P_177 ; _rtB -> gejvoi40cj = _rtP -> P_83 ; _rtB
-> d2nn2dz4fd = _rtP -> P_84 ; _rtB -> ivv2jnhcpi = _rtP -> P_87 ; _rtB ->
p1w0xi100e = _rtP -> P_91 ; srUpdateBC ( _rtDW -> g4gjxdbtf4 ) ; _rtB ->
fxcjfqn45x = _rtP -> P_108 ; _rtB -> ic1qhk0fop = _rtP -> P_112 ; _rtB ->
imtiszgtzp = _rtP -> P_3 ; _rtB -> pbt1aboirk [ 0 ] = _rtP -> P_5 [ 0 ] ;
_rtB -> kya5mnodh5 [ 0 ] = _rtP -> P_6 [ 0 ] ; _rtB -> pbt1aboirk [ 1 ] =
_rtP -> P_5 [ 1 ] ; _rtB -> kya5mnodh5 [ 1 ] = _rtP -> P_6 [ 1 ] ; _rtB ->
juziei1xyn = _rtP -> P_113 ; _rtB -> ghgo3bvffu = _rtP -> P_116 ; memcpy ( &
_rtB -> peh1rto3cb [ 0 ] , & _rtP -> P_9 [ 0 ] , sizeof ( real_T ) << 4U ) ;
memcpy ( & _rtB -> izkabpihx5 [ 0 ] , & _rtP -> P_10 [ 0 ] , sizeof ( real_T
) << 4U ) ; memcpy ( & _rtB -> cjb3t1mtm1 [ 0 ] , & _rtP -> P_11 [ 0 ] ,
sizeof ( real_T ) << 4U ) ; memcpy ( & _rtB -> owo3bzgu1j [ 0 ] , & _rtP ->
P_114 [ 0 ] , sizeof ( real_T ) << 4U ) ; memcpy ( & _rtB -> hik4td4f5a [ 0 ]
, & _rtP -> P_37 [ 0 ] , sizeof ( real_T ) << 4U ) ; srUpdateBC ( _rtDW ->
lkapeddomn ) ; memcpy ( & _rtB -> bpfnj4sfof [ 0 ] , & _rtP -> P_42 [ 0 ] ,
sizeof ( real_T ) << 4U ) ; srUpdateBC ( _rtDW -> annpiv55ji ) ; _rtB ->
bvgt3f4ra0 = _rtP -> P_122 ; _rtB -> o1hs3tzdts = _rtP -> P_124 ; _rtB ->
balzupoiv5 = _rtP -> P_125 ; _rtB -> dkhxjchsqi [ 0 ] = _rtP -> P_126 [ 0 ] ;
_rtB -> dkhxjchsqi [ 1 ] = _rtP -> P_126 [ 1 ] ; _rtB -> ap4u2yd03u = _rtP ->
P_128 ; _rtB -> bq0y2ocaux = _rtP -> P_129 ; _rtB -> ar1cxc4uvb = _rtP ->
P_130 ; _rtB -> m34j5lish0 = _rtP -> P_154 ; _rtB -> glodq2hqqo = _rtP ->
P_156 ; memcpy ( & _rtB -> lgbuh3irbe [ 0 ] , & _rtP -> P_32 [ 0 ] , sizeof (
real_T ) << 4U ) ; memcpy ( & _rtB -> llus0uca25 [ 0 ] , & _rtP -> P_155 [ 0
] , sizeof ( real_T ) << 4U ) ; memcpy ( & _rtB -> a1chqz1hpu [ 0 ] , & _rtP
-> P_157 [ 0 ] , sizeof ( real_T ) << 4U ) ; UNUSED_PARAMETER ( tid ) ; }
#define MDL_UPDATE
static void mdlUpdate ( SimStruct * S , int_T tid ) { real_T * lastU ;
int32_T i ; real_T tmp ; jmhfl0vfej * _rtB ; pb0dk03pgo * _rtP ; msq0uno1m5 *
_rtDW ; _rtDW = ( ( msq0uno1m5 * ) ssGetRootDWork ( S ) ) ; _rtP = ( (
pb0dk03pgo * ) ssGetDefaultParam ( S ) ) ; _rtB = ( ( jmhfl0vfej * )
_ssGetBlockIO ( S ) ) ; if ( ssIsSampleHit ( S , 1 , tid ) ) { for ( i = 0 ;
i < 6 ; i ++ ) { _rtDW -> dewe4gvi5r [ i ] = _rtB -> heoonygn34 [ i ] ; }
_rtDW -> fk1qpjfzc1 = _rtB -> oo2cxneq23 ; _rtDW -> mep1rokrtv = _rtB ->
droxlmzoaq ; _rtDW -> bxoxk4txlf = _rtB -> px2wrt4bzq ; } if ( _rtDW ->
apyu1gfrng && ssIsSampleHit ( S , 1 , tid ) ) { _rtDW -> gzu0zv51zr = _rtB ->
h2rrvk0jst ; _rtDW -> bp0rj2rogx = _rtB -> bnzxyuzyuq ; _rtDW -> gosx21togf =
_rtB -> gss5lrj5rw ; _rtDW -> aozr5000cf = _rtB -> ihedzxs4yi ; _rtDW ->
pgmwr4vhd2 = _rtB -> erfhz4u2ha ; _rtDW -> bwvycmcn3z = _rtB -> auuslohtnj ;
_rtDW -> e3f14xoesd = _rtB -> btrcgb5p2q ; _rtDW -> elvgq1j52h = _rtB ->
e22acsxkiv ; _rtDW -> hpvt2c0ku5 = _rtB -> ondv43ewih ; _rtDW -> jpj3cab3oc =
_rtB -> p0whqztos1 ; } if ( _rtDW -> i5y0nptmn2 && ssIsSampleHit ( S , 1 ,
tid ) ) { tmp = _rtP -> P_85 * _rtB -> gejvoi40cj ; for ( i = 0 ; i < 6 ; i
++ ) { _rtDW -> cj2qd1mnl4 [ i ] += tmp ; if ( _rtB -> lpijl1o3bz [ i ] > 0.0
) { _rtDW -> ek2sosv0fx [ i ] = 1 ; } else if ( _rtB -> lpijl1o3bz [ i ] <
0.0 ) { _rtDW -> ek2sosv0fx [ i ] = - 1 ; } else if ( _rtB -> lpijl1o3bz [ i
] == 0.0 ) { _rtDW -> ek2sosv0fx [ i ] = 0 ; } else { _rtDW -> ek2sosv0fx [ i
] = 2 ; } _rtDW -> jq4yf1ps3x [ i ] = _rtB -> et4o1kxcgm [ i ] ; } } if (
ssIsSampleHit ( S , 1 , tid ) ) { _rtDW -> bszocv0tyo [ 0 ] = _rtB ->
p4cn11yydt [ 0 ] ; _rtDW -> ouueie1te2 [ 0 ] = _rtB -> nea0ub3po4 [ 0 ] ;
_rtDW -> bszocv0tyo [ 1 ] = _rtB -> p4cn11yydt [ 1 ] ; _rtDW -> ouueie1te2 [
1 ] = _rtB -> nea0ub3po4 [ 1 ] ; _rtDW -> bszocv0tyo [ 2 ] = _rtB ->
p4cn11yydt [ 2 ] ; _rtDW -> ouueie1te2 [ 2 ] = _rtB -> nea0ub3po4 [ 2 ] ;
_rtDW -> bszocv0tyo [ 3 ] = _rtB -> p4cn11yydt [ 3 ] ; _rtDW -> ouueie1te2 [
3 ] = _rtB -> nea0ub3po4 [ 3 ] ; if ( _rtB -> ic1qhk0fop > 0.0 ) { _rtDW ->
gsu2qsejc5 = _rtB -> km3tr3vhu1 ; } _rtDW -> cdtfqsi0l1 += _rtP -> P_117 *
_rtB -> gjbljg3km3 ; _rtDW -> kceslciih5 = _rtB -> hsrdaalytc ; _rtDW ->
ncjoabwnvn = _rtB -> b33xuvzasm ; ssCallAccelRunBlock ( S , 57 , 46 ,
SS_CALL_MDL_UPDATE ) ; _rtDW -> gvzeb4nlpb [ 0 ] = _rtB -> msixc3clly [ 0 ] ;
_rtDW -> gvzeb4nlpb [ 2 ] = _rtB -> pprqyj24tg [ 0 ] ; _rtDW -> gvzeb4nlpb [
1 ] = _rtB -> msixc3clly [ 1 ] ; _rtDW -> gvzeb4nlpb [ 3 ] = _rtB ->
pprqyj24tg [ 1 ] ; _rtDW -> i43q2xnv5j = 0U ; _rtDW -> mnsh4qcssa = _rtP ->
P_165 * _rtB -> ar1qhylpb2 + _rtB -> hsrdaalytc ; } if ( ssIsContinuousTask (
S , tid ) ) { if ( _rtDW -> ipuephsfr2 == ( rtInf ) ) { _rtDW -> ipuephsfr2 =
ssGetT ( S ) ; lastU = & _rtDW -> ciiwswlqrh ; } else if ( _rtDW ->
mum3ya2p14 == ( rtInf ) ) { _rtDW -> mum3ya2p14 = ssGetT ( S ) ; lastU = &
_rtDW -> kzh4nj2v3e ; } else if ( _rtDW -> ipuephsfr2 < _rtDW -> mum3ya2p14 )
{ _rtDW -> ipuephsfr2 = ssGetT ( S ) ; lastU = & _rtDW -> ciiwswlqrh ; } else
{ _rtDW -> mum3ya2p14 = ssGetT ( S ) ; lastU = & _rtDW -> kzh4nj2v3e ; } *
lastU = _rtB -> dirihi4d1f ; } UNUSED_PARAMETER ( tid ) ; }
#define MDL_UPDATE
static void mdlUpdateTID3 ( SimStruct * S , int_T tid ) { UNUSED_PARAMETER (
tid ) ; } static void mdlInitializeSizes ( SimStruct * S ) { ssSetChecksumVal
( S , 0 , 2784373480U ) ; ssSetChecksumVal ( S , 1 , 1321102987U ) ;
ssSetChecksumVal ( S , 2 , 4168324721U ) ; ssSetChecksumVal ( S , 3 ,
3918760168U ) ; { mxArray * slVerStructMat = NULL ; mxArray * slStrMat =
mxCreateString ( "simulink" ) ; char slVerChar [ 10 ] ; int status =
mexCallMATLAB ( 1 , & slVerStructMat , 1 , & slStrMat , "ver" ) ; if ( status
== 0 ) { mxArray * slVerMat = mxGetField ( slVerStructMat , 0 , "Version" ) ;
if ( slVerMat == NULL ) { status = 1 ; } else { status = mxGetString (
slVerMat , slVerChar , 10 ) ; } } mxDestroyArray ( slStrMat ) ;
mxDestroyArray ( slVerStructMat ) ; if ( ( status == 1 ) || ( strcmp (
slVerChar , "8.6" ) != 0 ) ) { return ; } } ssSetOptions ( S ,
SS_OPTION_EXCEPTION_FREE_CODE ) ; if ( ssGetSizeofDWork ( S ) != sizeof (
msq0uno1m5 ) ) { ssSetErrorStatus ( S ,
"Unexpected error: Internal DWork sizes do "
"not match for accelerator mex file." ) ; } if ( ssGetSizeofGlobalBlockIO ( S
) != sizeof ( jmhfl0vfej ) ) { ssSetErrorStatus ( S ,
"Unexpected error: Internal BlockIO sizes do "
"not match for accelerator mex file." ) ; } { int ssSizeofParams ;
ssGetSizeofParams ( S , & ssSizeofParams ) ; if ( ssSizeofParams != sizeof (
pb0dk03pgo ) ) { static char msg [ 256 ] ; sprintf ( msg ,
"Unexpected error: Internal Parameters sizes do "
"not match for accelerator mex file." ) ; } } _ssSetDefaultParam ( S , (
real_T * ) & o0dimtychd ) ; rt_InitInfAndNaN ( sizeof ( real_T ) ) ; ( (
pb0dk03pgo * ) ssGetDefaultParam ( S ) ) -> P_140 = rtInf ; } static void
mdlInitializeSampleTimes ( SimStruct * S ) { { SimStruct * childS ;
SysOutputFcn * callSysFcns ; childS = ssGetSFunction ( S , 0 ) ; callSysFcns
= ssGetCallSystemOutputFcnList ( childS ) ; callSysFcns [ 3 + 0 ] = (
SysOutputFcn ) ( NULL ) ; childS = ssGetSFunction ( S , 1 ) ; callSysFcns =
ssGetCallSystemOutputFcnList ( childS ) ; callSysFcns [ 3 + 0 ] = (
SysOutputFcn ) ( NULL ) ; childS = ssGetSFunction ( S , 2 ) ; callSysFcns =
ssGetCallSystemOutputFcnList ( childS ) ; callSysFcns [ 3 + 0 ] = (
SysOutputFcn ) ( NULL ) ; } slAccRegPrmChangeFcn ( S , mdlOutputsTID3 ) ; }
static void mdlTerminate ( SimStruct * S ) { }
#include "simulink.c"
