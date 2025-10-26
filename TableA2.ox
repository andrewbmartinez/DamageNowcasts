//Code to generate Table A2

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
	
	decl x=SelectGets("Data/Realtime",1,51);
	decl y=SelectGetsRobust("Data/Realtime",1,51);

	decl mult = unit(51);	
	mult[3][3] = .NaN;
	mult[4][4] = .NaN;
	mult[5][4] = 1;
	mult[12][12] = .NaN;
	mult[13][12] = 1;
	mult[24][24] =.NaN;
	mult[42][42] = .NaN;
	mult[43][42] = 1;

	decl list = loadsheet("Data/ActualDamages.xlsx");



	decl act = loadmat("Data/ActualDamages.xlsx")[][1]/1000000000;
	act = act[:rows(act)-1];

	decl w1A=constant(.NaN,47,1);
	decl w2A=constant(.NaN,47,1);

	decl mod, n;
	for(decl j=1; j<47; j++){
	if(j==1){ n=0; }
	for(decl i=n; i<64; i++){
	mod = loadsheet("Data/RealtimeCommercialNowcasts.xlsx",i);
 	if(list[j][1]==mod[2][0]){
//	println(list[j][1]);
	if(	isnull(mod[2][rows(mod[2])-1])==1){
	w1A[j]= .NaN;
	} else {
		w1A[j]=(round(meanr(deleter(mod[2][3:rows(mod[2])-2]))/100000000)/10);
	}
		w2A[j]=(round(meanr(deleter(mod[11][3:rows(mod[2])-2]))/100000000)/10);
//	println("success!!");	
	n=i;
	i=63;
	}
	}
	}

	decl e = act-(deleter(mult*x[1:][1])~deleter(mult*y[1:][1])~deleter(mult*x[1:][1]+mult*y[1:][1])/2~w1A[1:]~w2A[1:]);	
	
	decl table =   {" Gets "~" Extended "~" Average "~" 1 Day CAT Mod Ave "~" 10 Days CAT Mod Ave"};
	table = table |	{sprint("Average Error:"),(round(meanc(e[][0:2])*10)/10)~(round(meanc(deleter(e[][3]))*10)/10)~(round(meanc(e[][4])*10)/10)};
	table = table |	{sprint("RMSE:"),(round((meanc(e[][0:2].^2).^(1/2))*10)/10)~(round((meanc(deleter(e[][3]).^2).^(1/2))*10)/10)~(round((meanc(e[][4].^2).^(1/2))*10)/10)};
	table = table |	{sprint("MAE:"),(round(meanc(fabs(e[][0:2]))*10)/10)~(round(meanc(fabs(deleter(e[][3])))*10)/10)~(round(meanc(fabs(e[][4]))*10)/10)};
	table = table |	{sprint("MAPE (%):"),(round(meanc(fabs(e[][0:2])./act)*1000)/10)~(round(meanc(deleter(fabs(e[][3])./act))*1000)/10)~(round(meanc(fabs(e[][4])./act)*1000)/10)};

	println(table);
	
	
}
