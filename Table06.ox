//Code to Replicate Table 6

#include <oxstd.oxh>
#import <packages/PcGive/pcgive_ects>

SelectGets(const Source, const Min, const Max)
{
decl x=0;
decl y=0;
decl z=0;
decl w=0;
decl i, calc, q, r, s,a, model;
oxprintlevel(-1);
// This program requires a licenced version of PcGive Professional.
for(decl j=Min; j<Max+1; j++){
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

SelectGetsRobust(const Source,const Min, const Max)
{
decl x=0;
decl y=0;
decl z=0;
decl w=0;
decl i, calc, q, r, s,a, model;
oxprintlevel(-1);
// This program requires a licenced version of PcGive Professional.
for(decl j=Min; j<Max+1; j++){
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
	decl x=SelectGets("Data/Realtime",47,51);
	x=  x~SelectGetsRobust("Data/Realtime",47,51);
	x = x~SelectGets(sprint("Data/Realtime/COCO"),47,51);
	x = x~SelectGetsRobust(sprint("Data/Realtime/COCO"),47,51);	
	x = x~SelectGets(sprint("Data/Realtime/ACT"),47,51);
	x = x~SelectGetsRobust(sprint("Data/Realtime/ACT"),47,51);


	
	decl act = loadmat("Data/ActualDamages.xlsx")[][1]/1000000000;
	x = x[1:][]~act[rows(act)-5:rows(act)-1];

	println(round(x*10)/10);

	decl e=x[][columns(x)-1]-x[][:columns(x)-2];

	println(round(meanc(e)*10)/10);
	println(round(meanc(e.^2).^(1/2)*10)/10);
	println(round(meanc(fabs(e))*10)/10);

	println(round(meanc(fabs(e)./x[][columns(x)-1])*1000)/10);
	
}
