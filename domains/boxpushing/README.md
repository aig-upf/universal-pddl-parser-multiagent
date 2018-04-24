# BoxPushing Domain
This domain is described in [Brafman and Zoran, 2014](#ref-brafman-zoran). There are two different specifications, both following [Kovacs, 2012](#ref-kovacs) notation:

* `boxpushing_dom_cal.pddl` uses existential quantifiers. 
* `boxpushing_dom_cal_v2.pddl` does not use existential quantifiers.

The `problems` folder contains some sample problems. Besides, inside this folder there is a folder called `generator` containing a Python script for creating new instances. 

You can use the generator as follows:

```
python generate_instance.py <rows> <columns> <agents> <small> <medium> <large>
```

where

* `rows` is the number of rows of the grid,
* `columns` is the number of columns of the grid,
* `agents` is the number of agents in the grid,
* `small` is the number of small boxes in the grid,
* `medium` is the number of medium boxes in the grid, and
* `large` is the number of large boxes in the grid.

## References

* <a name="ref-brafman-zoran">Brafman, R. I., and Zoran, U. (2014).</a> [_Forward Search with Interacting Actions_](http://icaps14.icaps-conference.org/proceedings/dmap/DMAP_proceedings.pdf) In Proceedings of the 2nd ICAPS Distributed and Multi-Agent Planning workshop (ICAPS DMAP-2014).

* <a name="ref-kovacs">Kovacs, D. L. (2012).</a> [_A Multi-Agent Extension of PDDL 3.1._](http://www.r3-cop.eu/wp-content/uploads/2013/01/A-Multy-Agent-Extension-of-PDDL3.1.pdf) In Proceedings of the 3rd Workshop on the International Planning Competition (IPC), 19–27.

