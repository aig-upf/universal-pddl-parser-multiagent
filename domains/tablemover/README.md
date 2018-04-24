# TableMover Domain

This domain is described in [[Boutilier and Brafman, 2001]](#ref-boutilier). The `domain` folder contains a domain generator called `generate_domain.py`. The difference between two TableMover domains is given by the number of tables in the problem since tables are used as constants. The generator creates domains using [[Kovacs, 2012]](#ref-kovacs) notation, and it is used as follows:

```
python generate_domain.py <num-tables> <add-move-agent-action>
```

where `num-tables` is the number of tables in the domain, and `add-move-agent-action` indicates whether to add or not the action for moving agents between rooms (i.e. no need to be move the table to go from one room to another).

In the same `domain` folder you can find TableMover domains ranging from 1 to 4 tables (`table_domain1.pddl`, ..., `table_domain4.pddl`).

The `problems` folder also contains a generator inside the `generator` subfolder. The script is called `generate_instance.py` and it is used as follows:

```
python generate_instance.py <num-nodes> <num-edges> <num-blocks> <num-agents> <num-tables> <instance-number>
```

where:

* `num_nodes` is the number of rooms.
* `num_edges` is the number of links between rooms (they are randomly created).
* `num_agents` is the number of agents.
* `num_tables` is the number of tables.
* `instance_number` is a number used to differentiate between two instances with the same number of nodes, edges, ...

## References

* <a name="ref-boutilier">Boutilier, C. and Brafman, R. I. (2001).</a> [_Partial-Order Planning with Concurrent Interacting Actions._](http://dx.doi.org/10.1613/jair.740) Journal of Artificial Intelligence Research (JAIR) 14, 105-136.

* <a name="ref-kovacs">Kovacs, D. L. (2012).</a> [_A Multi-Agent Extension of PDDL 3.1._](http://www.r3-cop.eu/wp-content/uploads/2013/01/A-Multy-Agent-Extension-of-PDDL3.1.pdf) In Proceedings of the 3rd Workshop on the International Planning Competition (IPC), 19–27.

