# Maze Domain

This domain is described in  [[Crosby, Jonsson and Rovatsos, 2014]](#ref-crosby-ecai14). In this case, there are two different domains depending on the multiagent notation used:

* `maze_dom_cal.pddl` for [[Kovacs, 2012]](#ref-kovacs) notation.
* `maze_dom_cn.pddl` for [[Crosby, Jonsson and Rovatsos, 2014]](#ref-crosby-ecai14) notation.

The problems in the `problems` folder can be related to any of the domains. Besides, inside this folder there is a folder called `generator` containing C++ code for creating new instances. You can compile it as follows:

```
g++ generate.cpp -o generate
```

The usage of the generator is the following:

```
generate <agents> <iter> <lo> <hi> <step> <door> <bridge> <boat> <switch>
```

where:

* `agents` is the number of agents.
* `iter` is the number of instances for each combination of `<number of agents, grid size>`.
* `lo` and `hi` are the minimum and maximum size of the grid respectively. The generator will create an instance for `lo` size. Then it will progressively increase this quantity by `step`, `2 * step`, `3 * step`, ... until reaching or surpassing `hi`.
* `door`: percentage of opened doors in the maze.
* `bridge`: percentage of bridges in the maze.
* `boat`: percentage of boats in the maze.
* `switch`: percentage of switches (with an associated locked door) in the maze.

## References

* <a name="ref-kovacs">Kovacs, D. L. (2012).</a> [_A Multi-Agent Extension of PDDL 3.1._](http://www.r3-cop.eu/wp-content/uploads/2013/01/A-Multy-Agent-Extension-of-PDDL3.1.pdf) In Proceedings of the 3rd Workshop on the International Planning Competition (IPC), 19–27.

* <a name="ref-crosby-ecai14">Crosby, M., Jonsson, A., and Rovatsos, M. (2014).</a> [_A Single-Agent Approach to Multiagent Planning_](https://doi.org/10.3233/978-1-61499-419-0-237). Proceedings of the 21st European Conference on Artificial Intelligence (ECAI-14), 237-242.

