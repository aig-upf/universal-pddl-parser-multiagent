# Workshop Domain

This domain is described in [[Furelos-Blanco, 2017]](#ref-furelos-mthesis). As in the case of the [Maze](../maze) domain, there are two different domains depending on the multiagent notation used:

* `workshop_dom_cal.pddl` for [[Kovacs, 2012]](#ref-kovacs) notation.
* `workshop_dom_cn.pddl` for [[Crosby, Jonsson and Rovatsos, 2014]](#ref-crosby-ecai14) notation.

The problems in the `problems` folder can be related to any of the domains. Besides, inside this folder there is a folder called `generator` containing a Python script for creating new instances. The generated instances have the following features:

* There are connected buildings forming a tree. Buildings are linked by locked security doors.
* Each bulding has a number of rooms which are connected via unlocked doors, forming a tree.
* In each building there is a switch and a key for each of the security doors it is connected to. The key and the switch are randomly placed in one of its rooms.
* Pallets and forklifts are randomly placed in rooms.
* Two agents are placed in the same room as a forklift.

You can use the generator as follows:

```
python generate_instance.py <num-agents> <num-pallet> <num-buildings> <num-rooms-per-building> <num-instance>
```

## References

* <a name="ref-kovacs">Kovacs, D. L. (2012).</a> [_A Multi-Agent Extension of PDDL 3.1._](http://www.r3-cop.eu/wp-content/uploads/2013/01/A-Multy-Agent-Extension-of-PDDL3.1.pdf) In Proceedings of the 3rd Workshop on the International Planning Competition (IPC), 19–27.

* <a name="ref-crosby-ecai14">Crosby, M., Jonsson, A., and Rovatsos, M. (2014).</a> [_A Single-Agent Approach to Multiagent Planning_](https://doi.org/10.3233/978-1-61499-419-0-237). Proceedings of the 21st European Conference on Artificial Intelligence (ECAI-14), 237-242.

* <a name="ref-furelos-mthesis">Furelos-Blanco, D. (2017).</a> [_Resolution of Concurrent Planning Problems using Classical Planning_](http://hdl.handle.net/10230/33107). Master Thesis.
