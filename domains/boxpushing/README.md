# BoxPushing Domain
This domain is described in [[Brafman and Zoran, 2014]](#ref-brafman-zoran). There are two different specifications, both following [[Kovacs, 2012]](#ref-kovacs) notation:

* `domain.pddl` uses existential quantifiers.
* `domain_v2.pddl` does not use existential quantifiers.
* `domain_injured.pddl` is an alternative definition of BoxPushing where an agent gets injured if it pushes a box alone. If it is injured it cannot push a box again. However, if a box is pushed by more than 1 agent at a time, these agents do not get injured. This variation is used in [[Shekhar and Brafman, 2018]](#ref-shekhar-brafman).

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

* <a name="ref-shekhar-brafman">Shekhar, S., and Brafman, R. I. (2018).</a> [_Forward Search with Interacting Actions_](https://www.aaai.org/ocs/index.php/ICAPS/ICAPS18/paper/view/17742/16983). In Proceedings of the 28th International Conference on Automated Planning and Scheduling (ICAPS 2018).

* <a name="ref-brafman-zoran">Brafman, R. I., and Zoran, U. (2014).</a> [_Forward Search with Interacting Actions_](http://icaps14.icaps-conference.org/proceedings/dmap/DMAP_proceedings.pdf). In Proceedings of the 2nd ICAPS Distributed and Multi-Agent Planning workshop (ICAPS DMAP-2014).

* <a name="ref-kovacs">Kovacs, D. L. (2012).</a> [_A Multi-Agent Extension of PDDL 3.1._](http://www.r3-cop.eu/wp-content/uploads/2013/01/A-Multy-Agent-Extension-of-PDDL3.1.pdf) In Proceedings of the 3rd Workshop on the International Planning Competition (IPC), 19–27.
