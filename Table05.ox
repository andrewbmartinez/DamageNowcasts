//Code to generate Table 5

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
	return (z-w)~z~(z+w);

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
	return (z-w)~z~(z+w);
	


	}	


main()
{
	
	decl x=SelectGets("Data/Realtime",47,51);
	decl y=SelectGetsRobust("Data/Realtime",47,51);

	decl v1={};
	decl v2=v1;

	decl act = loadmat("Data/ActualDamages.xlsx")[][1]/1000000000;
	act = act[rows(act)-5:rows(act)-1];

	decl w1={};
	decl w2=w1;
	decl w1A=constant(.NaN,5,1);
	decl w2A=constant(.NaN,5,1);

	decl mod;
	for(decl j=0; j<5; j++){
	mod = loadsheet("Data/RealtimeCommercialNowcasts.xlsx",58+j);

	v1=v1|{sprint( " (" ,round(x[1+j][0]*10)/10," - ",round(x[1+j][2]*10)/10,") ")};
	v2=v2|{sprint( " (" ,round(y[1+j][0]*10)/10," - ",round(y[1+j][2]*10)/10,") ")};
	
	w1A[j]=(round(meanr(deleter(mod[2][3:rows(mod[2])-2]))/100000000)/10);
	w1= w1|{sprint( " (" ,round(min(deleter(mod[2][3:rows(mod[2])-2]))/100000000)/10," - ",sprint(round(max(deleter(mod[2][3:rows(mod[2])-2]))/100000000)/10),") ")};
	w2A[j]=(round(meanr(deleter(mod[11][3:rows(mod[2])-2]))/100000000)/10);
	w2= w2|{sprint( " (" ,round(min(deleter(mod[11][3:rows(mod[2])-2]))/100000000)/10," - ",sprint(round(max(deleter(mod[11][3:rows(mod[2])-2]))/100000000)/10),") ")};
	}

	decl e = act-(x[1:][1]~y[1:][1]~w1A~w2A);	
	
	decl table =   {" Gets "~" Extended "~" 1 Day CAT Mod Ave "~" 10 Days CAT Mod Ave "~" Official NOAA"};
	table = table |{sprint("Beryl [July 5]"),round(x[1][1]*10)/10~round(y[1][1]*10)/10~w1A[0]~w2A[0]~round(act[0]*10)/10};
	table = table |	{v1[0]~v2[0]~w1[0]~w2[0]~" (5.4 - 8.8)"};
	table = table |	{sprint("Debby [August 5]"),round(x[2][1]*10)/10~round(y[2][1]*10)/10~w1A[1]~w2A[1]~round(act[1]*10)/10};
	table = table |	{v1[1]~v2[1]~w1[1]~w2[1]~" (1.7 - 3.1)"};
	table = table |	{sprint("Francine [September 11]"),round(x[3][1]*10)/10~round(y[3][1]*10)/10~w1A[2]~w2A[2]~round(act[2]*10)/10};
	table = table |	{v1[2]~v2[2]~w1[2]~w2[2]~" (1.0 - 1.7)"};
	table = table |	{sprint("Helene [September 26]"),round(x[4][1]*10)/10~round(y[4][1]*10)/10~w1A[3]~w2A[3]~round(act[3]*10)/10};
	table = table |	{v1[3]~v2[3]~w1[3]~w2[3]~" (63.0 - 94.4)"};
	table = table |	{sprint("Milton [October 9]"),round(x[5][1]*10)/10~round(y[5][1]*10)/10~w1A[4]~w2A[4]~round(act[4]*10)/10};
	table = table |	{v1[4]~v2[4]~w1[4]~w2[4]~" (25.8 - 44.4)"};
	table = table |	{sprint("Average Error:"),round(meanc(e)*10)/10};
	table = table |	{sprint("RMSE:"),round((meanc(e.^2).^(1/2))*10)/10};
	table = table |	{sprint("MAE:"),round(meanc(fabs(e))*10)/10};
	table = table |	{sprint("MAPE (%):"),round(meanc(fabs(e)./act)*1000)/10};

	println(table);
	
	
}
