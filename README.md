# Solar panel stuff

Most of this is in Swedish.

## FreeCAD drawings

Made using FreeCAD 0.16.
Relevant blag posts:

* [Trying out FreeCAD](http://härdin.se/blog/2018/01/28/trying-out-freecad/)
* [FreeCAD follow-up](http://härdin.se/blog/2018/02/08/freecad-follow-up/)
* [Triangular solar panel mount](http://härdin.se/blog/2018/03/10/triangular-solar-panel-mount/)
* [Triangular solar panel mount version 2](http://härdin.se/blog/2018/03/17/triangular-solar-panel-mount-version-2/)

## Insolation model

Run modell/doit.m with octave.
doit.sh can download data from other years or other coordinates.
STRÅNG data for 2017 had some gaps, hence the scaling by 365/362 in doit.m.

## License

The Python code is released under AGPLv3 and the hardware is released under TAPRv1.
