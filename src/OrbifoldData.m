: ::Package:: *)

BeginPackage["OrbifoldData`"]


dirichletDomain::usage = "Gives side-pairing generators,base points and spine radius of various orbifolds"
HyperbolicTriangle::usage =" "


Begin["`Private`"]


(*This Dirichilet domain consists of two hyperbolic triangles glued together along 
one of the edges. The base point is on the gluing edge and it is placed so that the
spine radius is minimized *)
dirichletDomain[HyperbolicTriangle[k1_Integer,k2_Integer,k3_Integer]]:=
	<|
		"SidePairings"->
						{
							{{-Cos[\[Pi]/k1],Sin[\[Pi]/k1]},{-Sin[\[Pi]/k1],-Cos[\[Pi]/k1]}},
							{{-Cos[\[Pi]/k1],-Sin[\[Pi]/k1]},{Sin[\[Pi]/k1],-Cos[\[Pi]/k1]}},
							{{-Cos[\[Pi]/k3]-Sqrt[Cos[\[Pi]/k2]+Cos[(1/k1-1/k3) \[Pi]]] Sqrt[Cos[\[Pi]/k2]+Cos[(1/k1+1/k3) \[Pi]]] Csc[\[Pi]/k1],(Cos[\[Pi]/k2]+Cos[\[Pi]/k1] Cos[\[Pi]/k3]) Csc[\[Pi]/k1]},{-((Cos[\[Pi]/k2]+Cos[\[Pi]/k1] Cos[\[Pi]/k3]) Csc[\[Pi]/k1]),-Cos[\[Pi]/k3]+Sqrt[Cos[\[Pi]/k2]+Cos[(1/k1-1/k3) \[Pi]]] Sqrt[Cos[\[Pi]/k2]+Cos[(1/k1+1/k3) \[Pi]]] Csc[\[Pi]/k1]}},
							{{-Cos[\[Pi]/k3]+Sqrt[Cos[\[Pi]/k2]+Cos[(1/k1-1/k3) \[Pi]]] Sqrt[Cos[\[Pi]/k2]+Cos[(1/k1+1/k3) \[Pi]]] Csc[\[Pi]/k1],-((Cos[\[Pi]/k2]+Cos[\[Pi]/k1] Cos[\[Pi]/k3]) Csc[\[Pi]/k1])},{(Cos[\[Pi]/k2]+Cos[\[Pi]/k1] Cos[\[Pi]/k3]) Csc[\[Pi]/k1],-Cos[\[Pi]/k3]-Sqrt[Cos[\[Pi]/k2]+Cos[(1/k1-1/k3) \[Pi]]] Sqrt[Cos[\[Pi]/k2]+Cos[(1/k1+1/k3) \[Pi]]] Csc[\[Pi]/k1]}}
						},
		"BasePointD"->
						{Sqrt[1+Csc[\[Pi]/k1] (Cos[\[Pi]/k3] Cot[\[Pi]/k1]+Cos[\[Pi]/k2] Csc[\[Pi]/k1]-Sqrt[2 Cos[\[Pi]/k2]+2 Cos[\[Pi]/k1] Cos[\[Pi]/k3]+Sin[\[Pi]/k1]^2+Sin[\[Pi]/k3]^2])]/Sqrt[1+Csc[\[Pi]/k1] (Cos[\[Pi]/k3] Cot[\[Pi]/k1]+Cos[\[Pi]/k2] Csc[\[Pi]/k1]+Sqrt[2 Cos[\[Pi]/k2]+2 Cos[\[Pi]/k1] Cos[\[Pi]/k3]+Sin[\[Pi]/k1]^2+Sin[\[Pi]/k3]^2])],0},
		"BasePointH"->
						{(Sqrt[1+Csc[\[Pi]/k1] (Cos[\[Pi]/k3] Cot[\[Pi]/k1]+Cos[\[Pi]/k2] Csc[\[Pi]/k1]-Sqrt[2 Cos[\[Pi]/k2]+2 Cos[\[Pi]/k1] Cos[\[Pi]/k3]+Sin[\[Pi]/k1]^2+Sin[\[Pi]/k3]^2])] Sqrt[1+Csc[\[Pi]/k1] (Cos[\[Pi]/k3] Cot[\[Pi]/k1]+Cos[\[Pi]/k2] Csc[\[Pi]/k1]+Sqrt[2 Cos[\[Pi]/k2]+2 Cos[\[Pi]/k1] Cos[\[Pi]/k3]+Sin[\[Pi]/k1]^2+Sin[\[Pi]/k3]^2])])/(1+Cos[\[Pi]/k3] Cot[\[Pi]/k1] Csc[\[Pi]/k1]+Cos[\[Pi]/k2] Csc[\[Pi]/k1]^2),(Csc[\[Pi]/k1] Sqrt[2 Cos[\[Pi]/k2]+2 Cos[\[Pi]/k1] Cos[\[Pi]/k3]+Sin[\[Pi]/k1]^2+Sin[\[Pi]/k3]^2])/(1+Cos[\[Pi]/k3] Cot[\[Pi]/k1] Csc[\[Pi]/k1]+Cos[\[Pi]/k2] Csc[\[Pi]/k1]^2)},
		"SpineRadius"->
						ArcSinh[Sin[\[Pi]/k1] Sqrt[-1+(Cos[\[Pi]/k3] Cot[\[Pi]/k1]+Cos[\[Pi]/k2] Csc[\[Pi]/k1]+Sin[\[Pi]/k1])/Sqrt[2 Cos[\[Pi]/k2]+2 Cos[\[Pi]/k1] Cos[\[Pi]/k3]+Sin[\[Pi]/k1]^2+Sin[\[Pi]/k3]^2]] Sqrt[1+(Cos[\[Pi]/k3] Cot[\[Pi]/k1]+Cos[\[Pi]/k2] Csc[\[Pi]/k1]+Sin[\[Pi]/k1])/Sqrt[2 Cos[\[Pi]/k2]+2 Cos[\[Pi]/k1] Cos[\[Pi]/k3]+Sin[\[Pi]/k1]^2+Sin[\[Pi]/k3]^2]]]
	|>;


 dirichletDomain[name_/;name==="Bolza"]:=
	<|
		"SidePairings"->
						{
							{{Sqrt[1+Sqrt[2]]+Cot[\[Pi]/8],Sqrt[1+Sqrt[2]]},{Sqrt[1+Sqrt[2]],-Sqrt[1+Sqrt[2]]+Cot[\[Pi]/8]}},
							{{Sqrt[2 (1+Sqrt[2])]+Cot[\[Pi]/8],0},{0,-Sqrt[2 (1+Sqrt[2])]+Cot[\[Pi]/8]}},
							{{Sqrt[1+Sqrt[2]]+Cot[\[Pi]/8],-Sqrt[1+Sqrt[2]]},{-Sqrt[1+Sqrt[2]],-Sqrt[1+Sqrt[2]]+Cot[\[Pi]/8]}},
							{{Cot[\[Pi]/8],-Sqrt[2 (1+Sqrt[2])]},{-Sqrt[2 (1+Sqrt[2])],Cot[\[Pi]/8]}},
							{{-Sqrt[1+Sqrt[2]]+Cot[\[Pi]/8],-Sqrt[1+Sqrt[2]]},{-Sqrt[1+Sqrt[2]],Sqrt[1+Sqrt[2]]+Cot[\[Pi]/8]}},
							{{-Sqrt[2 (1+Sqrt[2])]+Cot[\[Pi]/8],0},{0,Sqrt[2 (1+Sqrt[2])]+Cot[\[Pi]/8]}},
							{{-Sqrt[1+Sqrt[2]]+Cot[\[Pi]/8],Sqrt[1+Sqrt[2]]},{Sqrt[1+Sqrt[2]],Sqrt[1+Sqrt[2]]+Cot[\[Pi]/8]}},
							{{Cot[\[Pi]/8],Sqrt[2 (1+Sqrt[2])]},{Sqrt[2 (1+Sqrt[2])],Cot[\[Pi]/8]}}
						},
		"BasePointD"->
						{0,0},
		"BasePointH"->
						{0,1},
		"SpineRadius"-> 
						ArcCosh[1+Sqrt[2]]
 |>;
 

dirichletDomain[x__]:=Missing["Unknow orbifold!"];


End[]
EndPackage[]
