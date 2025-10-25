//Code to generate alternative real-time and quasi-real-time forecasts to assess sensitivity to information

#include <oxstd.oxh>
#import <packages/PcGive/pcgive_ects>

SelectGets(const Source, const Max)
{
decl x=0;
decl y=0;
decl z=0;
decl w=0;
decl i, calc, q, r, s,a, model;
oxprintlevel(-1);
// This program requires a licenced version of PcGive Professional.
for(decl j=1; j<Max+1; j++){
	model = new PcGive();
	model.Load(sprint(Source,"/Storm",j,".csv"));
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
	model.Select(U_VAR, {"Constant", 0, 0});
	model.SetSelSample(1, 1, 72+j, 1); // 1955	
	model.SetMethod(M_OLS);
	model.Estimate();
	model.TestSummary();

	r=model.GetCovar();
	s=model.GetResVar();
	a= loadmat(sprint(Source,"/Storm",j,".csv"));
	q =(loadmat(sprint(Source,"/Storm",j,".csv"))[][2:3]~loadmat(sprint(Source,"/Storm",j,".csv"))[][9]~loadmat(sprint(Source,"/Storm",j,".csv"))[][10:14]~(1));//~1): 
	
	i=j-(rows(model.GetY())-72);
	calc= diagonal( sqrt(s+q[72+j-i:][]*r*q[72+j-i:][]' ) )'[i] ;
	y=y|i;
	model.SetDerivedForecasts("exp(lncost)");
	x=x|(model.Forecast(1+i,1+i,1,0,0)[1][i][1])/1000000000;
	z=z|(model.Forecast(1+i,0,1,0,0)[0][i][1])/1000000000; 
	w=w|(calc*(exp(meanc(model.Forecast(1+i,0,1,0,0)[0][i][0])))/1000000000); 
}
oxprintlevel(1);
	delete model;
	return z;

	}

SelectGetsRobust(const Source,const Max)
{
decl x=0;
decl y=0;
decl z=0;
decl w=0;
decl i, calc, q, r, s,a, model;
oxprintlevel(-1);
// This program requires a licenced version of PcGive Professional.
for(decl j=1; j<Max+1; j++){
	model = new PcGive();
	model.Load(sprint(Source,"/Storm",j,".csv"));
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
	model.TestSummary();

	r=model.GetCovar();
	s=model.GetResVar();
	a= loadmat(sprint(Source,"/Storm",j,".csv"));
	q =(loadmat(sprint(Source,"/Storm",j,".csv"))[][2:3]~loadmat(sprint(Source,"/Storm",j,".csv"))[][9]~loadmat(sprint(Source,"/Storm",j,".csv"))[][10:14]~loadmat(sprint(Source,"/Storm",j,".csv"))[][5]~(1));//~1): 
	
	i=j-(rows(model.GetY())-72);
	calc= diagonal( sqrt(s+q[72+j-i:][]*r*q[72+j-i:][]' ) )'[i] ;
	y=y|i;
	model.SetDerivedForecasts("exp(lncost)");
	x=x|(model.Forecast(1+i,1+i,1,0,0)[1][i][1])/1000000000;
	z=z|(model.Forecast(1+i,0,1,0,0)[0][i][1])/1000000000; 
	w=w|(calc*(exp(meanc(model.Forecast(1+i,0,1,0,0)[0][i][0])))/1000000000); 
}
oxprintlevel(1);
	delete model;
	return z;
	


	}	


main()
{
	decl x=SelectGets("Realtime",46);
	for(decl j=1; j<8; j++){
	x = x~SelectGets(sprint("Realtime/QRT",j),46);
	}

	// Combining storms with multiple strikes and dropping storms with no commercial damage nowcasts
	decl mult = unit(46);	
	mult[3][3] = .NaN;
	mult[4][4] = .NaN;
	mult[5][4] = 1;
	mult[12][12] = .NaN;
	mult[13][12] = 1;
	mult[24][24] =.NaN;
	mult[42][42] = .NaN;
	mult[43][42] = 1;
	
	savemat("RTmodpred.csv",deleter((mult*x[1:][])*1000000000));
}
