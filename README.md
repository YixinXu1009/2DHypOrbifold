# 2DHypOrbifold
A Mathematica package to compute the geodesic spectrum and operator spectrum of two-dimensional compact hyperbolic orbifolds.
## Enumerate geodesics
Clone the current repository:
```bash
git clone https://github.com/YixinXu1009/2DHypOrbifold.git
```
If you are working with mathematica notebook, import the package:
```
<<<"path/to/Geodesics.m"
```
As an example, to enumerate all closed geodesics on the hyperbolic triangle [0;3,3,5] up to length 8, call
```Mathematica
enumerateGeodesics[HyperbolicTriangle[3,3,5],8]
```
The function will output a message indicating the progress:
```
Enumerating group elements.....

Counting conjugacy classes.....

Done! Data saved in ./Geodesics-HyperbolicTriangle[3, 3, 5]-lengthCutoff-8-precision-500-epsilon-0.01-ouputPrec-100.JSON
```
The resulting data is saved in a JSON file with the following structure:
```json
[
	{
		"Length":1.534394436502638886658057537039742667252616763921706000181361044363384253607619919677938651299932035,
		"WindingNumber":1,
		"Multiplicity":2,
		"SignedMultiplicity":2
	},
...
]
```
The output JSON file contains a list of objects, each representing a geodesic with the following field:
- **Length:** The length of the geodesic.
- **WindingNumber:** The number of times the geodesic winds around a primitive geodesic
- **Multiplicity:** The number of distinct hyperbolic conjugacy classes in the underlying Fuchsian group $\Gamma \subset PSL(2,\mathbb{R})$.
- **SignedMultiplicity:** The number of conjugacy classes counted with sign. When a spin structure is chosen, one lifts $\Gamma$ to an $SL(2,\mathbb{R})$ subgroup $\tilde{\Gamma}$. Now different hyperbolic elements sharing the same geodesic length can have traces differing by a sign. For each hyperbolic conjugacy class in $\tilde{\Gamma}$, if all of its members have positive (negative) trace, the sign of this conjugacy class is set to be +1 (-1). For non-spin orbifolds (e.g. hyperbolic triangles with even degree orbifold points) the SignedMultiplicity field should be ignored.
- 
The general schema for calling `enumerateGeodesics` is:
```mathematica
enumerateGeodesics[orbifoldName,lengthCutoff,outputDirectory,precision,epsilon,outputPrecision]
```
- **orbifoldName:** The name of the orbifold. It has to be defined in the file `OrbifoldData.m`.  `OrbifoldData.m` is still very incomplete right now. It only has hyperbolic triangle and the Bolza surface in it (will probably add more orbifolds later). If you want to compute the geodesic spectrum of other orbifolds,you need to enter the base point (for the Dirichlet domain), the side pairing generators and the spine radius in `OrbifoldData.m` then call `enumerateGeodesics`.
- **precision:** Precision of internal calculations. Defaults to 500.
- **epsilon:** Internal parameter that defaults to 0.01. Must be small compared with the spine radius
- **outputPrecision:** precision of the geodesic length in the output file. Defaults to 100.
  
## Converting length spectrum into operator spectrum 
Using Selberg trace formula, one can convert the geodesic length spectrum into eigenspectrum of various differential operators. I haven't cleaned up the code for this part yet but you can find an example notebook in the notebook directory.

## Comments:
* For a description of the algorithm, see section 4 of [this paper](https://jamathr.org/index.php/jamr/article/view/Vol-3Issue-1Paper-3) and reference therein. A separate report might be posted on arXiv.
* Contributions are welcome! Please open an issue or submit a pull request with your suggestions or improvements.

