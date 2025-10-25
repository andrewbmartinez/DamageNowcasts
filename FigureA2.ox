// This code generates Figure A2 in the paper

#include <oxstd.oxh>
#include <oxfloat.oxh>
#import <maximize>
#import <maxsqp>
#include <oxdraw.h>
#import <packages/PcGive/pcgive_ects>


gets(final)
{
decl x=0;
decl i, model;
oxprintlevel(-1);
// This program requires a licenced version of PcGive Professional.
for(decl j=1; j<final+1; j++){
	model = new PcGive();
	model.Load(sprint("Data/Realtime/Storm",j,".csv"));
	model.Deterministic(-1);
	model.Select(Y_VAR, {"lncost", 0, 0});
	model.Select(U_VAR, {"lnhd", 0, 0});	
	model.Select(U_VAR, {"clnih", 0, 0});
	model.Select(U_VAR, {"lnrain", 0, 0});
	model.Select(U_VAR, {"lnsurge", 0, 0});
	model.Select(U_VAR, {"lnpress", 0, 0});
	model.Select(U_VAR, {"lneTK12", 0, 0});
	model.Select(U_VAR, {"Constant", 0, 0});	
	model.Select(U_VAR,	{"low1", 0, 0});
	model.Select(X_VAR, {"low2", 0, 0});	
	model.SetSelSample(1, 1, 72+j, 1); // 1955	
	model.SetMethod(M_OLS);
	model.Estimate();
	i=j-(rows(model.GetY())-72);
	model.SetDerivedForecasts("exp(lncost)/1000000000");	
	x=x|(model.Forecast(1+i, 1, 1, 0, 0)[0][i][1]);
}
	oxprintlevel(1);	
	delete model;
	return x;
	
}

getsr(final)
{
decl z=0;
decl i, calc, q, r, s,a, model;
oxprintlevel(-1);
// This program requires a licenced version of PcGive Professional.
for(decl j=1; j<final+1; j++){
	model = new PcGive();
	model.Load(sprint("Data/Realtime/Storm",j,".csv"));
	model.Deterministic(-1);
	model.Select(Y_VAR, {"lncost", 0, 0});
	model.Select(U_VAR, {"lnhd", 0, 0});	
	model.Select(U_VAR, {"clnih", 0, 0});
	model.Select(U_VAR, {"lnrain", 0, 0});
	model.Select(U_VAR, {"lnsurge", 0, 0});
	model.Select(U_VAR, {"lnpress", 0, 0});
	model.Select(U_VAR, {"lneTK12", 0, 0});
	model.Select(U_VAR,	{"low1", 0, 0});
	model.Select(U_VAR,	{"low2", 0, 0});
	model.Select(U_VAR, {"clnih2", 0, 0});
	model.Select(U_VAR, {"Constant", 0, 0});
	model.SetSelSample(1, 1, 72+j, 1); // 1955	
	model.SetMethod(M_OLS);
	model.Estimate();
	i=j-(rows(model.GetY())-72);
	model.SetDerivedForecasts("exp(lncost)");
	z=z|(model.Forecast(1+i,1,1,0,0)[0][i][1])/1000000000; 
}
oxprintlevel(1);		
	delete model;
	return z;	

	}

bmp(final)
{
decl x=0;
decl i, model;
oxprintlevel(-1);
// This program requires a licenced version of PcGive Professional.
for(decl j=1; j<final+1; j++){	
	model = new PcGive();
	model.Load(sprint("Data/Realtime/Storm",j,".csv"));
	model.Deterministic(-1);
	model.Select(Y_VAR, {"lncost", 0, 0});
	model.Select(X_VAR, {"nh", 0, 0});
	model.Select(X_VAR, {"ma", 0, 0});
	model.Select(X_VAR, {"ri", 0, 0});
	model.Select(X_VAR, {"ny", 0, 0});
	model.Select(X_VAR, {"nj", 0, 0});
	model.Select(X_VAR, {"md", 0, 0});
	model.Select(X_VAR, {"va", 0, 0});
	model.Select(X_VAR, {"nc", 0, 0});
	model.Select(X_VAR, {"sc", 0, 0});
	model.Select(X_VAR, {"ga", 0, 0});
	model.Select(X_VAR, {"fl", 0, 0});
	model.Select(X_VAR, {"al", 0, 0});
	model.Select(X_VAR, {"ms", 0, 0});
	model.Select(X_VAR, {"la", 0, 0});
	model.Select(X_VAR, {"tx", 0, 0});
	model.Select(X_VAR, {"lnih", 0, 0});
	model.Select(X_VAR, {"lnhd", 0, 0});
	model.Select(X_VAR, {"lnpress", 0, 0});
	model.Select(U_VAR, {"Constant", 0, 0});
	model.Select(U_VAR, {"low1", 0, 0});
	model.Select(U_VAR, {"low2", 0, 0});
	model.SetSelSample(1, 1, 72+j, 1); // 1955	
	model.SetMethod(M_OLS);
	model.Estimate();
	model.TestSummary();
	i=j-(rows(model.GetY())-72);
	model.SetDerivedForecasts("exp(lncost)");	
	x=x|(model.Forecast(1+i, 1, 1, 0, 0)[0][i][1])/1000000000;
	}
	oxprintlevel(1);	
	delete model;
	return x;
}

kem(final)
{
decl x=0;
decl i;
decl model;
oxprintlevel(-1);
// This program requires a licenced version of PcGive Professional.
for(decl j=1; j<final+1; j++){	
	model = new PcGive();
	model.Load(sprint("Data/Realtime/Storm",j,".csv"));
	model.Select(Y_VAR, {"lncost", 0, 0});
	model.Select(X_VAR, {"lninc", 0, 0});	  
	model.Select(X_VAR, {"vwind", 0, 0});
	model.Select(X_VAR, {"low1", 0, 0});
	model.Select(X_VAR, {"low2", 0, 0});
	model.SetModelClass(PcGive::MC_SYSTEM);
	model.SetCFIMLCode("&0=1;");
	model.SetEquation("lncost", {"lninc",0,0,"vwind",0,0,"low1",0,0,"low2",0,0});
	model.SetSelSample(1, 1, 72+j, 1); // 1955	
	model.SetMethod(M_CFIML);
	model.Estimate();
	model.TestSummary();
	i=j-(rows(model.GetY())-72);
	model.SetDerivedForecasts("exp(lncost)");	
	x=x|(model.Forecast(1+i, 1, 1, 0, 0)[0][i][1])/1000000000;
	}
	oxprintlevel(1);	
	delete model;
	return x;
}

nsp(final)
{
decl x=0;
decl i, model;
oxprintlevel(-1);
// This program requires a licenced version of PcGive Professional.
for(decl j=1; j<final+1; j++){	
	model = new PcGive();
	model.Load(sprint("Data/Realtime/Storm",j,".csv"));
	model.Select(Y_VAR, {"lncost", 0, 0});
	model.Select(X_VAR, {"lninc", 0, 0});	  
	model.Select(X_VAR, {"lnpress", 0, 0});
	model.Select(X_VAR, {"low1", 0, 0});
	model.Select(X_VAR, {"low2", 0, 0});
	model.SetModelClass(PcGive::MC_SYSTEM);
	model.SetCFIMLCode("&0=1;");
	model.SetEquation("lncost", {"lninc",0,0,"lnpress",0,0,"low1",0,0,"low2",0,0});
	model.SetSelSample(1, 1, 72+j, 1); // 1955	
	model.SetMethod(M_CFIML);
	model.Estimate();
	model.TestSummary();
	i=j-(rows(model.GetY())-72);
	model.SetDerivedForecasts("exp(lncost)");	
	x=x|(model.Forecast(1+i, 1, 1, 0, 0)[0][i][1])/1000000000;
	}
	oxprintlevel(1);	
	delete model;
	return x;
}


// global data
decl g_mX;
decl g_vY;

// function constraining the weights to sum to 1

cfunc_eq0(const avF, const vP)		 
{
	avF[0] = sumc(vP)-1;
	return 1;	// indicates success
}

// maximization function

flogScore(const vP, const adFunc, const avScore, const amHessian)	 
{
	adFunc[0] = -1*double(meanc(sumr(((g_mX)*vP-(g_vY)).^2)));	
	return 1;	 // indicates success
}

weightingfunc(const data, const ROLL){
	decl M, vp, vplo, vphi, ir, dfunc, mE, wMSE, weights;
	weights=constant(.NaN,(rows(data)+1)-21,columns(data)-1);
	for(decl r=21; r<(rows(data)+1); r++){
		if(ROLL==TRUE){
			g_mX=data[r-21:r-1][1:columns(data)-1];		   //rolling window
			g_vY=data[r-21:r-1][0];			   //rolling window
		} else {
		g_mX=data[:r-1][1:columns(data)-1];			   //expanding window
		g_vY=data[:r-1][0];				   //expanding window
		}
		mE = meanc((g_vY-g_mX).^2).^(-1);
		wMSE =  (mE/sumr(mE))';			// inverse MSE weights
		M=columns(g_mX);
		// Initial values
			vp = wMSE;			
			vplo=vp*0;				   
			vphi=vp*0+1;

		MaxControl(1e5,0);
		ir = MaxSQP(flogScore,&vp,&dfunc,0,TRUE,0,cfunc_eq0,vplo,vphi);  // constrained maximization forcing sum of weights to be 1 and each weight to be positive.
		weights[r-21][]=vp';
	}
		return weights;
	}


main()
{

	decl final = 46;					  // only analyzing pre-2024 storms here
	decl ns = nsp(final)[1:];	
	decl ke = kem(final)[1:];
	decl bm = bmp(final)[1:];
	decl ge = gets(final)[1:];
	decl gr = getsr(final)[1:];

	decl mult = unit(final);

	// Combining storms with multiple strikes and dropping storms with no commercial damage nowcasts
	
	mult[3][3] = .NaN;
	mult[4][4] = .NaN;
	mult[5][4] = 1;
	mult[12][12] = .NaN;
	mult[13][12] = 1;
	mult[24][24] =.NaN;
	mult[42][42] = .NaN;
	mult[43][42] = 1;	

	mult = mult*(bm~ns~gr~ke);
	
	decl act = loadmat("Data/ActualDamages.xlsx")[][1]/1000000000;		 // bringing in actual damages
	decl data = act[:40]~deleter(mult);	

	//Estimated weights for both rolling and expanding windows
	
	decl w1	=  weightingfunc(data,TRUE);
	decl w2	=  weightingfunc(data,FALSE);

	println(columns(w1));
	

	// generating Figure with weights
	 data = {
		"x1":<1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21>,
		"y1":w2[][2]',
		"x3":<1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21>,
		"y3":w2[][3]',
		"x2":<1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21>,
		"y2":w2[][0]',
		"x4":<1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21>,
		"y4":w2[][1]',
		"x5":<1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21>,
		"y5":w1[][0]',
		"x6":<1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21>,
		"y6":w1[][1]',
		"x7":<1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21>,
		"y7":w1[][2]',
		"x8":<1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21>,
		"y8":w1[][3]',
		"end": <>
	};
	
	DrawAdjust(ADJ_PAPERSCALE, 50);
	DrawAdjust(ADJ_AREAMATRIX, -1, -1, 0, 640);
	DrawAxis(0,1,0,1,21,1,3,1,0,0);
	DrawAdjust(ADJ_AXISLABEL, -1, 0, 60);
	DrawAxis(0,0,1,0,0.7,0,0.1,0.1,0,0);
	DrawLegend(0,42,-182,0);
	DrawAdjust(ADJ_LEGEND, 0, 4, 350, 1, 0);
	DrawXMatrix(0,data["y1"],"Martinez (2020)",data["x1"],"",0,4);
	DrawAdjust(ADJ_COLOR, -1, 12);
	DrawXMatrix(0,data["y2"],"Bakkensen and Mendelsohn (2016)",data["x2"],"",0,2);
	DrawAdjust(ADJ_COLOR, -1, 12);
	DrawXMatrix(0,data["y3"],"Emanuel (2011)",data["x3"],"",0,5);
	DrawAdjust(ADJ_COLOR, -1, 7);
	DrawPText(0,"A. Expanding Window",2379,4300,0,330,0,0);
	DrawPText(0,"2012",470,173,0,330,0,0);
	DrawPText(0,"2012",7647,173,0,330,0,0);
	DrawPText(0,"2017",1383,173,0,330,0,0);
	DrawPText(0,"2018",2351,173,0,330,0,0);
	DrawPText(0,"2019",3297,173,0,330,0,0);
	DrawPText(0,"2020",4274,173,0,330,0,0);
	DrawPText(0,"2020",5241,173,0,330,0,0);
	DrawPText(0,"2022",6198,173,0,330,0,0);
	DrawXMatrix(0,data["y4"],"Nordhaus (2010)",data["x4"],"",0,3);
	DrawAdjust(ADJ_COLOR, -1, 10);
	DrawXMatrix(1,data["y5"],"BMP",data["x5"],"",0,2);
	DrawAdjust(ADJ_COLOR, -1, 12);
	DrawXMatrix(1,data["y6"],"NSP",data["x6"],"",0,3);
	DrawAdjust(ADJ_COLOR, -1, 10);
	DrawXMatrix(1,data["y7"],"GetsR",data["x7"],"",0,4);
	DrawAdjust(ADJ_COLOR, -1, 12);
	DrawXMatrix(1,data["y8"],"KEM",data["x8"],"",0,5);
	DrawAdjust(ADJ_COLOR, -1, 7);
	DrawAxis(1,1,0,1,21,1,3,1,0,0);
	DrawAdjust(ADJ_AXISLABEL, -1, 0, 60);
	DrawAxis(1,0,1,0,0.7,0,0.1,0.1,0,0);
	DrawLegend(1,20,20,1);
	DrawPText(1,"B. Rolling Window (20 Storms)",9241,4300,0,330,0,0);
	DrawPText(1,"2017",8593,173,0,330,0,0);
	DrawPText(1,"2018",9571,173,0,330,0,0);
	DrawPText(1,"2019",10541,173,0,330,0,0);
	DrawPText(1,"2020",11486,173,0,330,0,0);
	DrawPText(1,"2020",12385,173,0,330,0,0);
	DrawPText(1,"2022",13375,173,0,330,0,0);
	DrawAdjust(ADJ_AREAMATRIX, 1, 2);
	ShowDrawWindow();
	SaveDrawWindow("FigureA2.pdf");		
}
