# 2DHypOrbifold
Code that computes geodesic spectrum and operator spectrum of a 2d hyperbolic orbifold
## Enumerate geodesics
Example:
```
<<<"path/to/Geodesics.m"
enumerateGeodesics[HyperbolicTriangle[3,3,5],8]
```
Output:
```
Enumerating group elements.....

Counting conjugacy classes.....

Done! Data saved in ./Geodesics-HyperbolicTriangle[3, 3, 5]-lengthCutoff-8-precision-500-epsilon-0.01-ouputPrec-100.JSON
```
The data will be saved in a .JSON file which typically looks like:
```
[
	{
		"Length":1.534394436502638886658057537039742667252616763921706000181361044363384253607619919677938651299932035,
		"WindingNumer":1,
		"Multiplicity":2,
		"SignedMultiplicity":2
	},
...
]
```
Each closed geodesic on a compact hyperbolic orbifold correspond to a hyperbolic conjugacy class in the underlying cocompact Fuchsian group $\Gamma\in PSL(2,\mathbb{R})$. The multiplicity of the geodesic is the number of distinct conjugacy classes in $\Gamma$ sharing the same geodesic length $\ell(\gamma) = 2\cosh^{-1}(|\text{Tr}(\gamma)|/2)$. When a spin structure is chosen, one lifts $\Gamma$ to an $SL(2,\mathbb{R})$ subgroup $\tilde{\Gamma}$. Now different hyperbolic elements sharing the same geodesic length can have traces differing by a sign. For each hyperbolic conjugacy class in $\tilde{Gamma}$, if all of its members have positive (negative) trace, the sign of this conjugacy class is set to be +1 (-1). The signed multiplicity is the number of conjugacy classes counted with sign. For non-spin orbifolds (e.g. hyperbolic triangles with even degree orbifold points) the signed multiplicity should be ignored.
The general schema for calling `enumerateGeodesics` is:
`enumerateGeodesics[orbifoldName,lengthCutoff,outputDirectory,precision,epsilon,outputPrecision]`
* orbifoldName: has to be defined in the file `OrbifoldData.m`.  `OrbifoldData.m` is still very incomplete. It only has hyperbolic triangle and the Bolza surface in it (will probably add more orbifolds later). If you want to compute the geodesic spectrum of other orbifolds,you need to enter the base point (for the Dirichlet domain), the side pairing generators and the spine radius in `OrbifoldData.m` then call `enumerateGeodesics`.
* precision: the precision of internal calculations. Defaults to 500.
* epsilon: internal parameter that defaults to 0.01. Must be small compared with the spine radius
* outputPrecision: precision of the geodesic length in the output file. Defaults to 100.
  
## Converting length spectrum into operator spectrum 
Using Selberg trace formula, one can convert the geodesic length spectrum into eigenspectrum of various differential operators. I haven't cleaned up the code for this part yet but you can find an example notebook in the notebook directory.

## Comments:
* For a description of the algorithm, see section 4 of [this paper](https://jamathr.org/index.php/jamr/article/view/Vol-3Issue-1Paper-3) and reference therein. A separate report might be posted on arXiv.
* If you find a bug or need the program to do better (right now it is not very optimized) please contact me. 

