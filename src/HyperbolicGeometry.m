(* ::Package:: *)

BeginPackage["HyperbolicGeometry`"]


hyperbolicDistance::usage = 
"hyperbolicDistance[{x1,y1},{x2,y2}] compute the hyperbolic distance between two points on the Poincare disc"


geodesicLength::usage = 
"Computes geodesic length of a hyperbolic element."


distanceToBase::usage=
"distanceToBase[matrix,basepoint] gives the hyperbolic distance between basepoint and its
image under the action of matrix. basepoint is a point on the upperhalf pland and matrix
must be in SL(2,R)" 


axisDistanceToBase::usage =
"Giving a hyperbolic element, its axis is defined as the unique geodesic preserved under
the action of this element. axisDistanceToBase[matrix,basepoint] returns the hyperbolic distance
between the axis of matrix (assumed to be a hyperbolic elemet in SL(2,R)) and the basepoint (assumed
to be on the upper half-plane)"


Begin["`Private`"]


hyperbolicDistance[{x1_?NumericQ,y1_?NumericQ},{x2_?NumericQ,y2_?NumericQ},precision_:500]:=
	Module[{EucDisquare12,EucDisquare1,EucDisquare2},
		If[x1 == x2 && y1 == y2,Return[0]];
		Return[ArcCosh[1+(2* EuclideanDistance[{x1,y1},{x2,y2}]^2)/((1-EuclideanDistance[{x1,y1},{0,0}]^2)(1-EuclideanDistance[{x2,y2},{0,0}]^2))]//SetPrecision[#,precision]&]
	]


geodesicLength[{{a_?NumericQ,b_?NumericQ},{c_?NumericQ,d_?NumericQ}},precision_:500]:=If[Abs[a+d]<=2,Return[Indeterminate],Return[2*ArcCosh[1/2*Chop[Abs[a+d]]]//SetPrecision[#,precision]&]];


distanceToBase[matrix:{{a_?NumericQ,b_?NumericQ},{c_?NumericQ,d_?NumericQ}},basePoint:{x_?NumericQ,y_?NumericQ},precision_:500]:=
	Module[{newX,newY,result},
		(* Checking edge cases *)
		If[{{a,b},{c,d}}==={{1,0},{0,1}},Return[SetPrecision[0,precision]]];
		If[Chop[a*d - b*c] != 1,Return[Missing["InvalidSL2RMatrix","Determinant must be one"]]];
		
		(* Computing coordinates of the image *)
		newX = ((b+a*x) (d+c*x)+a*c*y^2)/((d+c*x)^2+c^2*y^2);
		newY = (-b*c*y+a*d*y)/((d+c*x)^2+c^2*y^2);
		
		(* Compute hyperbolic distance from the base point to the image *)
		result = 2* ArcTanh[EuclideanDistance[{newX,newY},{x,y}]/EuclideanDistance[{newX,newY},{x,-y}]];
		Return[SetPrecision[result,precision]]
	]


axisDistanceToBase[matrix:{{a_?NumericQ,b_?NumericQ},{c_?NumericQ,d_?NumericQ}},basePoint:{x_?NumericQ,y_?NumericQ},precision_:500]:=
	Module[{intersectX,intersectY},
		If[Abs[a + d] <=2, Return[Missing["Non-hyperbolic element","trace must be greater than 2"]]];
		(*intersectX = (-a b+b (d+4 c x)+a c (x^2+y^2)-c d (x^2+y^2))/(a^2+d^2-2 a (d+c x)+2 c (b+x (d+c x)+c y^2));*)
		intersectX = If[c!=0,-((d+a^2 d+4 c x+c^2 d (x^2+y^2)-a (1+d^2+4 c d x+c^2 (x^2+y^2)))/(c (-2+a^2+d^2-2 a c x+2 c (d x+c (x^2+y^2))))),x];
		intersectY = If[c !=0, (*(Sqrt[4 b c+(a-d)^2] Sqrt[b^2+2 b (a x-x (d+c x)+c y^2)+(x^2+y^2) ((-a+d+c x)^2+c^2 y^2)])/(c^2 Abs[a^2+d^2-2 a (d+c x)+2 c (b+x (d+c x)+c y^2)])*)(2 c^2 Sqrt[((-2+a+d) (2+a+d))/c^2] Sqrt[(y^2+(a-d-2 c x+Sqrt[-4+(a+d)^2] Sign[c])^2/(4 c^2)) (y^2+(-a+d+2 c x+Sqrt[-4+(a+d)^2] Sign[c])^2/(4 c^2))])/Abs[(-2+a+d) (2+a+d)+(-a+d+2 c x)^2+4 c^2 y^2],Sqrt[(b/(a-d)+x)^2 + y^2]];
		Return[2 ArcTanh[EuclideanDistance[{intersectX,intersectY},{x,y}]/EuclideanDistance[{intersectX,intersectY},{x,-y}]]//SetPrecision[#,precision]&]
	]


End[];


EndPackage[];
