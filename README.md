# Universal PDDL Parser - Multiagent Extension [![Build Status](https://travis-ci.org/aig-upf/universal-pddl-parser-multiagent.svg?branch=master)](https://travis-ci.org/aig-upf/universal-pddl-parser-multiagent)

An extension to the [Universal PDDL Parser](https://github.com/aig-upf/universal-pddl-parser) to handle multiagent domains. The parser currently supports [[Crosby, Jonsson and Rovatsos, 2014]](#ref-crosby-ecai14) and [[Kovacs, 2012]](#ref-kovacs) specifications.

1. [Installation](#installation)
	1. [Universal PDDL Parser](#universal-pddl-parser)
	1. [Multiagent Extension](#multiagent-extension)
	1. [Examples Compilation](#examples-compilation)
1. [Multiagent Domains](#multiagent-domains)
1. [Compilers from Multiagent to Classical Planning](#compilers-ma-classical)
	1. [Compilation by Crosby, Jonsson and Rovatsos (2014)](#compiler-ecai14)
    1. [Compilation by Furelos-Blanco and Jonsson (2018)](#compiler-dmap18)
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

Firstly, you have to either clone or download this repository. To clone it, you can use the following command:

```
git clone https://github.com/aig-upf/universal-pddl-parser-multiagent.git
```

This repository references the `universal-pddl-parser` repository previously cloned and compiled. There are two ways for referencing that repository:

1. You have the `universal-pddl-parser` and the `universal-pddl-parser-multiagent` repositories next to each other (i.e., in the same folder).
1. You use the `PDDL_PARSER_PATH` environment variable, which should contain the path to the `universal-pddl-parser` repository.

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

The domains are briefly described in their corresponding folders:

* [BoxPushing](domains/boxpushing)
* [CoDMAP-15 (Competition of Distributed and Multiagent Planners)](domains/codmap15)
* [Maze](domains/maze)
* [TableMover](domains/tablemover)
* [Workshop](domains/workshop)

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

### <a name="compiler-dmap18"></a> Compilation by Furelos-Blanco and Jonsson (2018)

This compilation is described in [[Furelos-Blanco, 2017]](#ref-furelos-mthesis). This compiler takes as input domains and problems specified using [[Kovacs, 2012]](#ref-kovacs) notation.

The folder containing the source code is `examples/serialize`. [After compiling the source code](#examples-compilation), a `serialize.bin` binary is created and is used as follows:

```
./serialize.bin [-h] [-j N] [-o]  <ma-domain> <ma-problem> > <cl-domain> 2> <cl-problem>
```

* `ma-domain` and `ma-problem` are the paths to the multiagent domain and the multiagent problem respectively.
* `cl-domain` and `cl-problem` are the output paths for the classical domain and the classical problem respectively.
* `-h` shows information about how to use the program.
* `-j N` forces the output plans to have joint actions composed by at most `N` atomic actions. For example, if you use `-j 2`, then the plan generated by a classical planner will not have joint actions formed by 3 or more atomic actions. By default there is not a limit on the size of the actions.
* `-o` forces agents to run actions in an specific order (`a1` before `a2`, `a2` before `a3` and so on).

## <a name="references"></a>References

* <a name="ref-boutilier">Boutilier, C. and Brafman, R. I. (2001).</a> [_Partial-Order Planning with Concurrent Interacting Actions._](http://dx.doi.org/10.1613/jair.740) Journal of Artificial Intelligence Research (JAIR) 14, 105-136.

* <a name="ref-kovacs">Kovacs, D. L. (2012).</a> [_A Multi-Agent Extension of PDDL 3.1._](http://www.r3-cop.eu/wp-content/uploads/2013/01/A-Multy-Agent-Extension-of-PDDL3.1.pdf) In Proceedings of the 3rd Workshop on the International Planning Competition (IPC), 19–27.

* <a name="ref-crosby-ecai14">Crosby, M., Jonsson, A., and Rovatsos, M. (2014).</a> [_A Single-Agent Approach to Multiagent Planning_](https://doi.org/10.3233/978-1-61499-419-0-237). Proceedings of the 21st European Conference on Artificial Intelligence (ECAI-14), 237-242.

* <a name="ref-furelos-mthesis">Furelos-Blanco, D. (2017).</a> [_Resolution of Concurrent Planning Problems using Classical Planning_](http://hdl.handle.net/10230/33107). Master Thesis.
