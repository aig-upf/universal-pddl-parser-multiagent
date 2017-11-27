# Universal PDDL Parser - Multiagent Extension

An extension to the [Universal PDDL Parser](https://github.com/aig-upf/universal-pddl-parser) to handle multiagent domains. The parser currently supports [[Crosby, Jonsson and Rovatsos, 2014]](#ref-crosby-ecai14) and [[Kovacs, 2012]](#ref-kovacs) specifications.

1. [Installation](#installation)
	1. [Universal PDDL Parser](#universal-pddl-parser)
	1. [Multiagent Extension](#multiagent-extension)
	1. [Examples Compilation](#examples-compilation)
1. [Multiagent Domains](#multiagent-domains)
	1. [CoDMAP-15 Domains](#codmap15-domains)
	1. [Maze Domain](#maze-domain)
	1. [TableMover Domain](#tablemover-domain)
	1. [Workshop Domain](#workshop-domain) 
1. [Compilers from Multiagent to Classical Planning](#compilers-ma-classical)
	1. [Compilation by Crosby, Jonsson and Rovatsos (2014)](#compiler-ecai14)
1. [References](#references) 

## <a name="installation"></a>Installation

In this section, the steps for compiling the diverse tools in the repository are described.

### <a name="universal-pddl-parser"></a>Universal PDDL Parser

As this repository extends the [Universal PDDL Parser](https://github.com/aig-upf/universal-pddl-parser), we need to install it first. You can clone the Universal PDDL Parser repository with the following command:

```
git clone https://github.com/aig-upf/universal-pddl-parser.git
```

Afterwards, you should compile it using `scons`:

```
cd universal-pddl-parser
scons
```

### <a name="multiagent-extension"></a>Multiagent Extension

Firstly, you have to either download or clone this repository. It is important to have the folder next to the `universal-pddl-parser` folder so that it can be properly referenced. To clone it, you can use the following command:

```
git clone https://github.com/aig-upf/universal-pddl-parser-multiagent.git
```

Then, to compile the extension you only have to open the folder and run the `scons` command:

```
cd universal-pddl-parser-multiagent
scons
```

### <a name="examples-compilation"></a>Examples Compilation

The `examples` folder contains different functionalities that use the multiagent extension of the Universal PDDL Parser. To compile them, you just have to run the following command from the `universal-pddl-parser-multiagent` folder:

```
cd universal-pddl-parser-multiagent
scons examples
```

## <a name="multiagent-domains"></a>Multiagent Domains

The `domains` folder contains a variety of multiagent domains. Each domain folder contains two subfolders:

 - `domain`: It contains domain description(s). Note that there can be more than one if they are written in different specifications. 
 - `problems`: It contains some domain problems. In some cases, you will also find a generator for creating new instances.

The following subsections briefly describe some of the domains and the content in the corresponding folders.

### <a name="codmap15-domains">CoDMAP-15 Domains

The `codmap15` folder contains 12 different domains that were used in the [Competition of Distributed and Multiagent Planners (CoDMAP)](http://agents.fel.cvut.cz/codmap/). Some domains, apart from the original `domain.pddl` file, contain a `domain_constrained.pddl` forcing some constraints on the concurrency between actions using  [[Kovacs, 2012]](#ref-kovacs) specification.

### <a name="maze-domain">Maze Domain

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

### <a name="tablemover-domain">TableMover Domain

This domain is described in  [[Boutilier and Brafman, 2001]](#ref-boutilier).

### <a name="workshop-domain">Workshop Domain

This domain is described in [[Furelos-Blanco, 2017]](#ref-furelos-mthesis). As in the case of the [Maze](#maze-domain) domain, there are two different domains depending on the multiagent notation used:

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

## <a name="compilers-ma-classical"></a>Compilations from Multiagent to Classical Planning

In this section, it is described how to run different compilers for converting multiagent planning problems (MAP) into classical planning problems. The resulting classical planning problems can be later solved using an off-the-shelf classical planner, such as [Fast Downward](http://www.fast-downward.org/) in the LAMA-2011 setting.

### <a name="compiler-ecai14"></a> Compilation by Crosby, Jonsson and Rovatsos (2014)

This compilation is described in [[Crosby, Jonsson and Rovatsos, 2014]](#ref-crosby-ecai14). Note that only domains following the notation described in this paper will be compiled.

The folder containing the source code is `examples/serialize_cn`. [After compiling the source code](#examples-compilation), two binaries are created: `serialize.bin` and `compress.bin`.

The binary for compiling MAPs into classical problems is `serialize.bin`. It used as follows:

```
./serialize.bin <ma-domain> <ma-problem> > <cl-domain> 2> <cl-problem>
```

where:

* `ma-domain` and `ma-problem` are the paths to the multiagent domain and the multiagent problem respectively.
* `cl-domain` and `cl-problem` are the output paths for the classical domain and the classical problem respectively.

For example, we can use it with the [Maze](#maze-domain) domain as follows:

```
./serialize.bin ../../domains/maze/domain/maze_dom_cn.pddl ../../domains/maze/problems/maze5_4_1.pddl > dom.pddl 2> ins.pddl
```

The `compress.bin` binary can be used to compress the plans given by a classical planner. The compression algorithm is described in the paper, and consists in forming joint actions from the classical plan. It is used as follows:

```
./compress.bin <cl-plan> <ma-plan>
```

where `cl-plan` is the plan given by the classical planner, while `ma-plan` is the compressed/multiagent plan.

## <a name="references"></a>References

* <a name="ref-boutilier">Boutilier, C. and Brafman, R. I. (2001).</a> [_Partial-Order Planning with Concurrent Interacting Actions._](http://dx.doi.org/10.1613/jair.740) Journal of Artificial Intelligence Research (JAIR) 14, 105-136.

* <a name="ref-kovacs">Kovacs, D. L. (2012).</a> [_A Multi-Agent Extension of PDDL 3.1._](http://www.r3-cop.eu/wp-content/uploads/2013/01/A-Multy-Agent-Extension-of-PDDL3.1.pdf) In Proceedings of the 3rd Workshop on the International Planning Competition (IPC), 19–27.

* <a name="ref-crosby-ecai14">Crosby, M., Jonsson, A., and Rovatsos, M. (2014).</a> [_A Single-Agent Approach to Multiagent Planning_](https://doi.org/10.3233/978-1-61499-419-0-237). Proceedings of the 21st European Conference on Artificial Intelligence (ECAI-14), 237-242.

* <a name="ref-furelos-mthesis">Furelos-Blanco, D. (2017).</a> [_Resolution of Concurrent Planning Problems using Classical Planning_](http://hdl.handle.net/10230/33107). Master Thesis.
