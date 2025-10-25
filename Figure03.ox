//	Code to Generate Figure 3

#include <oxstd.oxh>
#include <oxdraw.oxh>

main()
{
	//See Code to Generate Data for Figure 3 in the Data folder on how this data is generated
	decl data1=loadmat(sprint("Data/data_h1.csv"));
	decl data2=loadmat(sprint("Data/data_h2.csv"));
	decl data = {
		"y1":constant(1,1,10),
		"y2":constant(1,1,10),
		"y3":data1[][2]',
		"y4":data1[][3]',
		"y5":data1[][4]',
		"y6":data2[][2]',
		"y7":data2[][3]',
		"y8":data2[][4]',
		"end": <>
	};
	
	DrawAdjust(ADJ_PAPERSCALE, 50);
	DrawAdjust(ADJ_AREAMATRIX, -1, -1, 0, 640);
	DrawAxis(0,1,0,0,9,0,1,1,1,0);
	DrawAxis(0,0,1,0,2,0,0.5,0.25,0,0);
	DrawAdjust(ADJ_AREA_P, 0, 800, 640, 6200, 3720);
	DrawAdjust(ADJ_AREA_X, 0, 1, 9);
	DrawLegend(0,54,-16,0);
	DrawAdjust(ADJ_LEGEND, 0, 4, 400, 1, 0);
	DrawPText(0,"Days After Landfall",2678,70,0,330,0,0);
	DrawPText(0,"Panel A: Early Sample (2002-2012: 21 Hurricanes)",756,4614,0,330,0,0);
	DrawPText(0,"Relative Accuracy (Ratio)",305,1095,0,300,0,90);
	DrawTMatrix(0,data["y1"],"",0,1,1,0,13);
	DrawAdjust(ADJ_COLOR, -1, 5);
	DrawPText(0,"$\\leftarrow$ Ave. Cat Risk Model More Accurate ",7318,604,0,225,0,90);
	DrawAxis(1,1,0,1,9,1,1,1,1,0);
	DrawAxis(1,0,1,0,2,0,0.5,0.25,0,0);
	DrawAdjust(ADJ_AREA_P, 1, 8160, 640, 6200, 3720);
	DrawAdjust(ADJ_AREA_X, 1, 1, 9);
	DrawAdjust(ADJ_AREA_Y, 1, 0, 2);
	DrawLegend(1,20,20,1);
	DrawPText(1,"Days After Landfall",9901,61,0,330,0,0);
	DrawPText(1,"Panel B: Recent Sample (2013-2023: 20 Hurricanes)",7845,4619,0,330,0,0);
	DrawTMatrix(1,data["y2"],"x0",0,1,1,0,13);
	DrawAdjust(ADJ_COLOR, -1, 5);
	DrawPText(0,"Statistical Model More Accurate $\\rightarrow$",7629,968,0,225,0,90);
	DrawTMatrix(0,data["y3"],"RMSE",1,1,1,0,2);
	DrawAdjust(ADJ_COLOR, -1, 12);
	DrawTMatrix(0,data["y4"],"MAE",1,1,1,0,3);
	DrawAdjust(ADJ_COLOR, -1, 10);
	DrawTMatrix(0,data["y5"],"MAPE",1,1,1,0,4);
	DrawAdjust(ADJ_COLOR, -1, 7);
	DrawTMatrix(1,data["y6"],"r1",1,1,1,0,2);
	DrawAdjust(ADJ_COLOR, -1, 12);
	DrawTMatrix(1,data["y7"],"r2",1,1,1,0,3);
	DrawAdjust(ADJ_COLOR, -1, 10);
	DrawTMatrix(1,data["y8"],"r3",1,1,1,0,4);
	DrawAdjust(ADJ_COLOR, -1, 7);
	DrawAdjust(ADJ_AREAMATRIX, 1, 2);
	ShowDrawWindow();
	SaveDrawWindow("Figure03.pdf");	
}


