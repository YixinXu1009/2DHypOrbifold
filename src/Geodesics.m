(* ::Package:: *)

BeginPackage["Geodesics`"]


enumerateGeodesics::usage=
"enumerateGeodesics[orbifoldName,lengthCutoff] enumerates all the closed geodesics
of the orbifold up to the lengthCutoff. The orbifold must be defined in OrbifoldData.m"
getAllCloseTiles::usage=" "
geodesicsBelowCutoffOrbifold::usage=" "


Begin["`Private`"]


Import["OrbifoldData.m"]
Import["HyperbolicGeometry.m"]


getAllCloseTiles[sidepairings_List,basepoint_,spineRadius_?NumericQ,lengthCutoff_, precision_:500,epsilon_:0.01,lowPrec_:100]:=
	Module[{distanceToBaseCutoff,closeTiles,front,new},
           Print["getAllCloseTiles:The precision of the input is:",Precision[sidepairings]];
		distanceToBaseCutoff = 2 ArcCosh[Cosh[spineRadius]Cosh[lengthCutoff/2]];
		lowPrecisionHash[expr_]:=Hash[SetPrecision[expr,lowPrec]];
		front = closeTiles = <|lowPrecisionHash[IdentityMatrix[2]]->SetPrecision[IdentityMatrix[2],precision]|>;
		While[front =!= <||>,
			new =Table[
				If[!KeyExistsQ[closeTiles,lowPrecisionHash[g . f]]&& distanceToBase[g . f,basepoint,precision]<= distanceToBaseCutoff + epsilon,
					lowPrecisionHash[g . f]->g . f,
					Nothing
				],
					{g,sidepairings},
					{f,Values[front]}
				];
			front = Association[new//Flatten];
			closeTiles = closeTiles~Join~front
		];
		Return[closeTiles]
	];


Options[getConjClasses]={"comparisonPrecision"->5,"comparisonTolerance"->10^-8};
getConjClasses[source_,conjecture_,OptionsPattern[]]:=Module[{truncate,ht,comparisonPrecision,comparisonTolerance,representative,classes,approxSource,progressBar},
{comparisonPrecision,comparisonTolerance}={OptionValue["comparisonPrecision"],OptionValue["comparisonTolerance"]};
truncate=Chop[#,comparisonTolerance]~SetPrecision~comparisonPrecision&;
ht=CreateDataStructure@"HashTable";
("Insert"~ht~(truncate[#]->#))&/@source;
classes={};
(classes=While[!ht["EmptyQ"],progressBar=PercentForm@N@(1-(ht["Length"]/Length[source]));representative=ht["Values"][[1]];
Sow[representative];
(*Note: I am counting conjugacy classes in SL(2,R), not in PSL(2,R)*)
(*If you want to count conjugacy classes in PSL(2,R) uncomment the following line *)
("KeyDrop"~ht~truncate[-1*(# . representative . Inverse[#])];)&/@conjecture;
("KeyDrop"~ht~truncate[# . representative . Inverse[#]];)&/@conjecture
(*need to make sure identity is in conjecture*)
]//Reap//Rest//First//First;)(*~Monitor~progressBar*);
Return[classes]];


adjustWinding[list_]:=Module[{geolist,lengthSet,windingCheckCutoff,windingChecks,descendents,toChange,newlist,primitive,primitiveLength,windingNumber,multiplicity,signedMultiplicity},
(*The input of adjust winding has to be sorted by geodesic length. Otherwise there will be mistakes*)
(*geolist = Sort[list];*)
geolist=list;
lengthSet=#[[1]]&/@list;
windingCheckCutoff=Ceiling[Max[lengthSet]/2];
windingChecks=Select[lengthSet,#<=windingCheckCutoff&];
descendents=Join@@(Table[{#,i},{i,2,Floor[Max[lengthSet]/#]}]&/@windingChecks);
(*descendents is a table of the form {....{primary,level}...}*)
Table[primitiveLength=descendents[[j]][[1]];windingNumber=descendents[[j]][[2]];primitive=Select[geolist,#[[1]]==primitiveLength&&#[[2]]==1&];If[primitive!={},primitive=primitive[[1]];multiplicity=primitive[[3]];signedMultiplicity=primitive[[4]],multiplicity=0;signedMultiplicity=0];toChange=(Position[geolist,#]&/@Select[geolist,SetPrecision[#[[1]],5]==SetPrecision[primitiveLength*windingNumber,5]&&#[[2]]==1&]);
If[toChange!={},toChange=toChange[[1,1,1]];
geolist[[toChange]][[3]]=geolist[[toChange]][[3]]-multiplicity;
geolist[[toChange]][[4]]=geolist[[toChange]][[4]]-If[EvenQ[windingNumber],multiplicity,signedMultiplicity];newlist={{geolist[[toChange]][[1]],windingNumber,multiplicity,If[EvenQ[windingNumber],multiplicity,signedMultiplicity]}};geolist=Join[geolist,newlist]];geolist=Select[geolist,#[[3]]!=0&],{j,1,Length[descendents]}];Return[geolist]];


geodesicsBelowCutoffOrbifold[tiles_,basepoint_,spineRadius_,lengthCutoff_,precision_:500,epsilon_:0.01,lowPrec_:100]:=
	Module[{conjugacyMatrices,hyperbolic,ordered,geolength,test,classes,multiplicity,signedmultiplicity,geolist,distanceToBaseCutoffConj,signedMultiplicity},
        Print["geodesicsBelowCutoffOrbifold:the precision of the input tiles is:",Precision[tiles[[1]]]];
		distanceToBaseCutoffConj = 2 ArcCosh[Cosh[spineRadius]Cosh[lengthCutoff/4]];
		conjugacyMatrices = Select[tiles,distanceToBase[#,basepoint]<distanceToBaseCutoffConj&];
		hyperbolic = Select[tiles,Abs[Tr[#]]>2 && geodesicLength[#]<=lengthCutoff && axisDistanceToBase[#,basepoint]<spineRadius+ epsilon*spineRadius&];
		ordered = KeySort[GroupBy[hyperbolic,SetPrecision[geodesicLength[#],lowPrec]&]];
		geolist={};
		Do[
			geolength =(ordered//Keys)[[i]];
			test = Select[conjugacyMatrices,distanceToBase[#,basepoint]< 2 ArcCosh[Cosh[spineRadius]Cosh[geolength/4]]&];
			classes = getConjClasses[ordered[[i]]//Values,test];
			multiplicity=classes//Length;
			signedMultiplicity=Total[Sign[Tr[#]//Chop]&/@classes];
			geolist=Join[geolist,{{geolength,1,multiplicity,signedMultiplicity}}];
			,{i,1,Length[ordered]}];
		geolist=adjustWinding[geolist];
		Return[SortBy[geolist,#[[1]]&]]
	];


formatFileName[orbifold_,lengthCutoff_,precision_,epsilon_,lowPrec_]:="Geodesics-"<>ToString[orbifold]<>"-lengthCutoff-"<>ToString[lengthCutoff]<>"-precision-"<>ToString[precision]<>"-epsilon-"<>ToString[epsilon]<>"-ouputPrec-"<>ToString[lowPrec]<>".JSON";


enumerateGeodesics[orbifold_,lengthCutoff_,outputDir_:None,precision_:500,epsilon_:0.01,lowPrec_:100]:=
	Module[{sidepairings,basepoint,spineRadius,orbData,tiles,geodesicList,assoList,dirName,fileName},
		If[outputDir=!=None && !FileExistsQ[outputDir],Print["Output directory does not exist"];Abort[]];
		If[outputDir === None, dirName = ".",dirName = outputDir];
		fileName=formatFileName[orbifold,lengthCutoff,precision,epsilon,lowPrec];
		orbData=dirichletDomain[orbifold];
		If[Head[orbData]===Missing,Print["Unknown orbifold! Please add information about this orbifold in OrbifoldData.m"];Abort[]];
		sidepairings = SetPrecision[orbData["SidePairings"],precision];
		basepoint =SetPrecision[ orbData["BasePointH"],precision];
		spineRadius =SetPrecision[orbData["SpineRadius"],precision];
		Print["Enumerating group elements....."];
		tiles = getAllCloseTiles[sidepairings,basepoint,spineRadius,lengthCutoff, precision,epsilon,lowPrec];
		Print["Counting conjugacy classes....."];
		geodesicList = geodesicsBelowCutoffOrbifold[tiles,basepoint,spineRadius,lengthCutoff,precision,epsilon,lowPrec];
		assoList=<|"Length"->#[[1]],"WindingNumer"->#[[2]],"Multiplicity"->#[[3]],"SignedMultiplicity"->#[[4]]|>&/@geodesicList;
		Export[FileNameJoin[{dirName,fileName}],assoList];
           Print["Done! Data saved in "<>FileNameJoin[{dirName,fileName}]];
		Return[]]


End[];


EndPackage[];
