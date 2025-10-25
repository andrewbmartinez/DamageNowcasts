// Code to replicate equation 5 in paper

#include <oxstd.oxh>
#import <packages/PcGive/pcgive_ects>

main()
{

decl model;
// This program requires a licenced version of PcGive Professional.
	model = new PcGive();
	model.Load(sprint("Data/Realtime/Storm47.csv"));
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
	model.SetSelSample(1, 1, 72+47, 1);
	model.SetMethod(M_OLS);
	model.Estimate();
}
