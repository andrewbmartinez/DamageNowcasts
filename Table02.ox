// This code generates the results for Table 2. It starts by estimating each of the models from the real-time data and then computes the accuracy and relative accuracy statistics

#include <oxstd.oxh>
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

	mult = mult*(bm~ns~ge~gr~ke);
	decl act = loadmat("Data/ActualDamages.xlsx")[][1]/1000000000;		 // bringing in actual damages
	decl data = act[:40]~0~deleter(mult);
	
	decl ACT=data[][0];
	decl PVL=constant(.NaN,4,2);
	decl PVB=constant(.NaN,4,3);	
	
	decl e2BMP=data[][0]-data[][2];
	decl e2NSP=data[][0]-data[][3];
	decl e2GET=data[][0]-data[][5];
	decl e2FIN=data[][0]-data[][4];
	decl e2KEM=data[][0]-data[][6];

	decl eBMP=log(data[][0]./data[][2]);
	decl eNSP=log(data[][0]./data[][3]);
	decl eGET=log(data[][0]./data[][5]);
	decl eFIN=log(data[][0]./data[][4]);
	decl eKEM=log(data[][0]./data[][6]);
	
	decl sBMP = eBMP.^2;
	decl sNSP = eNSP.^2;	
	decl sGET = eGET.^2;
	decl sFIN = eFIN.^2;
	decl sKEM = eKEM.^2;

	decl s2BMP = e2BMP.^2;
	decl s2NSP = e2NSP.^2;	
	decl s2GET = e2GET.^2;
	decl s2FIN = e2FIN.^2;
	decl s2KEM = e2KEM.^2;
	
	decl aBMP = fabs(eBMP);
	decl aNSP = fabs(eNSP);
	decl aGET = fabs(eGET);
	decl aFIN = fabs(eFIN);
	decl aKEM = fabs(eKEM);

	decl a2BMP = fabs(e2BMP);
	decl a2NSP = fabs(e2NSP);
	decl a2GET = fabs(e2GET);
	decl a2FIN = fabs(e2FIN);
	decl a2KEM = fabs(e2KEM);	

	decl rmsBMP = sqrt(meanc(sBMP));
	decl rmsNSP = sqrt(meanc(sNSP));
	decl rmsGET = sqrt(meanc(sGET));	
	decl rmsFIN = sqrt(meanc(sFIN));
	decl rmsKEM = sqrt(meanc(sKEM));

	decl rms2BMP = sqrt(meanc(s2BMP));
	decl rms2NSP = sqrt(meanc(s2NSP));
	decl rms2GET = sqrt(meanc(s2GET));	
	decl rms2FIN = sqrt(meanc(s2FIN));
	decl rms2KEM = sqrt(meanc(s2KEM));
	
	decl dsBMP = sGET-sBMP;
	decl dsNSP = sGET-sNSP;
	decl dsFIN = sGET-sFIN;
	decl dsKEM = sGET-sKEM;

	decl ds2BMP = s2GET-s2BMP;
	decl ds2NSP = s2GET-s2NSP;
	decl ds2FIN = s2GET-s2FIN;
	decl ds2KEM = s2GET-s2KEM;	
	
	decl maBMP = meanc(aBMP);
	decl maNSP = meanc(aNSP);
	decl maGET = meanc(aGET);
	decl maFIN = meanc(aFIN);
	decl maKEM = meanc(aKEM);

	decl ma2BMP = meanc(a2BMP);
	decl ma2NSP = meanc(a2NSP);
	decl ma2GET = meanc(a2GET);
	decl ma2FIN = meanc(a2FIN);
	decl ma2KEM = meanc(a2KEM);	
	
	decl daBMP = aGET-aBMP;
	decl daNSP = aGET-aNSP;
	decl daFIN = aGET-aFIN;
	decl daKEM = aGET-aKEM;

	decl da2BMP = a2GET-a2BMP;
	decl da2NSP = a2GET-a2NSP;
	decl da2FIN = a2GET-a2FIN;
	decl da2KEM = a2GET-a2KEM;
	
	decl mapBMP = meanc((a2BMP)./ACT)*100;
	decl mapNSP = meanc((a2NSP)./ACT)*100;
	decl mapGET = meanc((a2GET)./ACT)*100;
	decl mapFIN = meanc((a2FIN)./ACT)*100;
	decl mapKEM = meanc((a2KEM)./ACT)*100;

	decl dpBMP = a2GET./ACT-a2BMP./ACT;
	decl dpNSP = a2GET./ACT-a2NSP./ACT;
	decl dpFIN = a2GET./ACT-a2FIN./ACT;
	decl dpKEM = a2GET./ACT-a2KEM./ACT;	

	decl rell = constant(.NaN,2,5);
	decl relb = constant(.NaN,3,5);


	rell[0][0] = (rmsFIN);
	rell[1][0] =(maFIN);
					  
	rell[0][1] = (rmsGET/rmsFIN);
	rell[1][1] = (maGET/maFIN);

	
	rell[0][2] =(rmsBMP/rmsFIN);
	rell[1][2] =(maBMP/maFIN);

	rell[0][3] =(rmsKEM/rmsFIN);
	rell[1][3] =(maKEM/maFIN);


	rell[0][4] =(rmsNSP/rmsFIN);
	rell[1][4] =(maNSP/maFIN);

	relb[0][0] = (rms2FIN);
	relb[1][0] =(ma2FIN);
	relb[2][0] =(mapFIN);	
					  
	relb[0][1] = (rms2GET/rms2FIN);
	relb[1][1] = (ma2GET/ma2FIN);
	relb[2][1] = mapGET/mapFIN;
	
	relb[0][2] =(rms2BMP/rms2FIN);
	relb[1][2] =(ma2BMP/ma2FIN);
	relb[2][2] = mapBMP/mapFIN;	

	relb[0][3] =(rms2KEM/rms2FIN);
	relb[1][3] =(ma2KEM/ma2FIN);
	relb[2][3] = mapKEM/mapFIN;

	relb[0][4] =(rms2NSP/rms2FIN);
	relb[1][4] =(ma2NSP/ma2FIN);	
	relb[2][4] = mapNSP/mapFIN;

oxprintlevel(-1);
	decl model;
	model = new PcGive();
	model.Create(1, 1, 1,rows(dsBMP), 1);
	model.Append(dsBMP,{"v1"});
	model.Deterministic(-1);
	model.Select("Y", {sprint("v",1), 0, 0});
	model.Select("X", {"Constant", 0, 0});
	model.SetRobustSEType(2);
	model.SetSelSample(1, 1, rows(dsBMP), 1);
	model.SetMethod("OLS");
	model.Estimate();
	PVL[1][0]= model.TestRestrictions(<1>)[1][1];
	delete model;

	model = new PcGive();
	model.Create(1, 1, 1,rows(ds2BMP), 1);
	model.Append(ds2BMP,{"v1"});
	model.Deterministic(-1);
	model.Select("Y", {sprint("v",1), 0, 0});
	model.Select("X", {"Constant", 0, 0});
	model.SetRobustSEType(2);
	model.SetSelSample(1, 1, rows(ds2BMP), 1);
	model.SetMethod("OLS");
	model.Estimate();
	PVB[1][0]= model.TestRestrictions(<1>)[1][1];
	delete model;
	
	model = new PcGive();
	model.Create(1, 1, 1,rows(dsNSP), 1);
	model.Append(dsNSP,{"v1"});
	model.Deterministic(-1);
	model.Select("Y", {sprint("v",1), 0, 0});
	model.Select("X", {"Constant", 0, 0});
	model.SetRobustSEType(2);
	model.SetSelSample(1, 1, rows(dsNSP), 1);
	model.SetMethod("OLS");
	model.Estimate();
	PVL[3][0]= model.TestRestrictions(<1>)[1][1];
	delete model;

	model = new PcGive();
	model.Create(1, 1, 1,rows(ds2NSP), 1);
	model.Append(ds2NSP,{"v1"});
	model.Deterministic(-1);
	model.Select("Y", {sprint("v",1), 0, 0});
	model.Select("X", {"Constant", 0, 0});
	model.SetRobustSEType(2);
	model.SetSelSample(1, 1, rows(ds2NSP), 1);
	model.SetMethod("OLS");
	model.Estimate();
	PVB[3][0]= model.TestRestrictions(<1>)[1][1];
	delete model;	

	model = new PcGive();
	model.Create(1, 1, 1,rows(dsFIN), 1);
	model.Append(dsFIN,{"v1"});
	model.Deterministic(-1);
	model.Select("Y", {sprint("v",1), 0, 0});
	model.Select("X", {"Constant", 0, 0});
	model.SetRobustSEType(2);
	model.SetSelSample(1, 1, rows(dsFIN), 1);
	model.SetMethod("OLS");
	model.Estimate();
	PVL[0][0]= model.TestRestrictions(<1>)[1][1];
	delete model;

	model = new PcGive();
	model.Create(1, 1, 1,rows(ds2FIN), 1);
	model.Append(ds2FIN,{"v1"});
	model.Deterministic(-1);
	model.Select("Y", {sprint("v",1), 0, 0});
	model.Select("X", {"Constant", 0, 0});
	model.SetRobustSEType(2);
	model.SetSelSample(1, 1, rows(ds2FIN), 1);
	model.SetMethod("OLS");
	model.Estimate();
	PVB[0][0]= model.TestRestrictions(<1>)[1][1];
	delete model;	

	model = new PcGive();
	model.Create(1, 1, 1,rows(dsKEM), 1);
	model.Append(dsKEM,{"v1"});
	model.Deterministic(-1);
	model.Select("Y", {sprint("v",1), 0, 0});
	model.Select("X", {"Constant", 0, 0});
	model.SetRobustSEType(2);
	model.SetSelSample(1, 1, rows(dsKEM), 1);
	model.SetMethod("OLS");
	model.Estimate();
	PVL[2][0]= model.TestRestrictions(<1>)[1][1];
	delete model;

	model = new PcGive();
	model.Create(1, 1, 1,rows(ds2KEM), 1);
	model.Append(ds2KEM,{"v1"});
	model.Deterministic(-1);
	model.Select("Y", {sprint("v",1), 0, 0});
	model.Select("X", {"Constant", 0, 0});
	model.SetRobustSEType(2);
	model.SetSelSample(1, 1, rows(ds2KEM), 1);
	model.SetMethod("OLS");
	model.Estimate();
	PVB[2][0]= model.TestRestrictions(<1>)[1][1];
	delete model;	

	model = new PcGive();
	model.Create(1, 1, 1,rows(daBMP), 1);
	model.Append(daBMP,{"v1"});
	model.Deterministic(-1);
	model.Select("Y", {sprint("v",1), 0, 0});
	model.Select("X", {"Constant", 0, 0});
	model.SetRobustSEType(2);
	model.SetSelSample(1, 1, rows(daBMP), 1);
	model.SetMethod("OLS");
	model.Estimate();
	PVL[1][1]= model.TestRestrictions(<1>)[1][1];
	delete model;

	model = new PcGive();
	model.Create(1, 1, 1,rows(da2BMP), 1);
	model.Append(da2BMP,{"v1"});
	model.Deterministic(-1);
	model.Select("Y", {sprint("v",1), 0, 0});
	model.Select("X", {"Constant", 0, 0});
	model.SetRobustSEType(2);
	model.SetSelSample(1, 1, rows(da2BMP), 1);
	model.SetMethod("OLS");
	model.Estimate();
	PVB[1][1]= model.TestRestrictions(<1>)[1][1];
	delete model;	

	model = new PcGive();
	model.Create(1, 1, 1,rows(daNSP), 1);
	model.Append(daNSP,{"v1"});
	model.Deterministic(-1);
	model.Select("Y", {sprint("v",1), 0, 0});
	model.Select("X", {"Constant", 0, 0});
	model.SetRobustSEType(2);
	model.SetSelSample(1, 1, rows(daNSP), 1);
	model.SetMethod("OLS");
	model.Estimate();
	PVL[3][1]= model.TestRestrictions(<1>)[1][1];
	delete model;

	model = new PcGive();
	model.Create(1, 1, 1,rows(da2NSP), 1);
	model.Append(da2NSP,{"v1"});
	model.Deterministic(-1);
	model.Select("Y", {sprint("v",1), 0, 0});
	model.Select("X", {"Constant", 0, 0});
	model.SetRobustSEType(2);
	model.SetSelSample(1, 1, rows(da2NSP), 1);
	model.SetMethod("OLS");
	model.Estimate();
	PVB[3][1]= model.TestRestrictions(<1>)[1][1];
	delete model;
	
	model = new PcGive();
	model.Create(1, 1, 1,rows(daFIN), 1);
	model.Append(daFIN,{"v1"});
	model.Deterministic(-1);
	model.Select("Y", {sprint("v",1), 0, 0});
	model.Select("X", {"Constant", 0, 0});
	model.SetRobustSEType(2);
	model.SetSelSample(1, 1, rows(daFIN), 1);
	model.SetMethod("OLS");
	model.Estimate();
	PVL[0][1]= model.TestRestrictions(<1>)[1][1];
	delete model;

	model = new PcGive();
	model.Create(1, 1, 1,rows(da2FIN), 1);
	model.Append(da2FIN,{"v1"});
	model.Deterministic(-1);
	model.Select("Y", {sprint("v",1), 0, 0});
	model.Select("X", {"Constant", 0, 0});
	model.SetRobustSEType(2);
	model.SetSelSample(1, 1, rows(da2FIN), 1);
	model.SetMethod("OLS");
	model.Estimate();
	PVB[0][1]= model.TestRestrictions(<1>)[1][1];
	delete model;
	
	model = new PcGive();
	model.Create(1, 1, 1,rows(daKEM), 1);
	model.Append(daKEM,{"v1"});
	model.Deterministic(-1);
	model.Select("Y", {sprint("v",1), 0, 0});
	model.Select("X", {"Constant", 0, 0});
	model.SetRobustSEType(2);
	model.SetSelSample(1, 1, rows(daKEM), 1);
	model.SetMethod("OLS");
	model.Estimate();
	PVL[2][1]= model.TestRestrictions(<1>)[1][1];
	delete model;

	model = new PcGive();
	model.Create(1, 1, 1,rows(da2KEM), 1);
	model.Append(da2KEM,{"v1"});
	model.Deterministic(-1);
	model.Select("Y", {sprint("v",1), 0, 0});
	model.Select("X", {"Constant", 0, 0});
	model.SetRobustSEType(2);
	model.SetSelSample(1, 1, rows(da2KEM), 1);
	model.SetMethod("OLS");
	model.Estimate();
	PVB[2][1]= model.TestRestrictions(<1>)[1][1];
	delete model;	

	model = new PcGive();
	model.Create(1, 1, 1,rows(dpBMP), 1);
	model.Append(dpBMP,{"v1"});
	model.Deterministic(-1);
	model.Select("Y", {sprint("v",1), 0, 0});
	model.Select("X", {"Constant", 0, 0});
	model.SetRobustSEType(2);
	model.SetSelSample(1, 1, rows(dpBMP), 1);
	model.SetMethod("OLS");
	model.Estimate();
	PVB[1][2]= model.TestRestrictions(<1>)[1][1];
	delete model;

	model = new PcGive();
	model.Create(1, 1, 1,rows(dpNSP), 1);
	model.Append(dpNSP,{"v1"});
	model.Deterministic(-1);
	model.Select("Y", {sprint("v",1), 0, 0});
	model.Select("X", {"Constant", 0, 0});
	model.SetRobustSEType(2);
	model.SetSelSample(1, 1, rows(dpNSP), 1);
	model.SetMethod("OLS");
	model.Estimate();
	PVB[3][2]= model.TestRestrictions(<1>)[1][1];
	delete model;

	model = new PcGive();
	model.Create(1, 1, 1,rows(dpFIN), 1);
	model.Append(dpFIN,{"v1"});
	model.Deterministic(-1);
	model.Select("Y", {sprint("v",1), 0, 0});
	model.Select("X", {"Constant", 0, 0});
	model.SetRobustSEType(2);
	model.SetSelSample(1, 1, rows(dpFIN), 1);
	model.SetMethod("OLS");
	model.Estimate();
	PVB[0][2]= model.TestRestrictions(<1>)[1][1];
	delete model;

	model = new PcGive();
	model.Create(1, 1, 1,rows(dpKEM), 1);
	model.Append(dpKEM,{"v1"});
	model.Deterministic(-1);
	model.Select("Y", {sprint("v",1), 0, 0});
	model.Select("X", {"Constant", 0, 0});
	model.SetRobustSEType(2);
	model.SetSelSample(1, 1, rows(dpKEM), 1);
	model.SetMethod("OLS");
	model.Estimate();
	PVB[2][2]= model.TestRestrictions(<1>)[1][1];
	delete model;
oxprintlevel(1);

println("Rankings for Billions or dollars:");

println(round(relb*100)/100);


println("p-values for DM tests in Billions of dollars:");
println((constant(.NaN,1,3)|PVB)');

println("Rankings for Logs:");


println(round(rell*100)/100);

println("p-values for DM tests in Logs:");
println((constant(.NaN,1,2)|PVL)');

}
