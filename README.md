# Universal PDDL Parser - Multiagent Extension

An extension to the [Universal PDDL Parser](https://github.com/aig-upf/universal-pddl-parser) to handle multiagent domains. The parser currently supports [[Crosby, Jonsson and Rovatsos, 2014]](#ref-crosby-ecai14) and [[Kovacs, 2012]](#ref-kovacs) specifications.

1. [Installation](#installation)
	1. [Universal PDDL Parser](#universal-pddl-parser)
	1. [Multiagent Extension](#multiagent-extension)
	1. [Examples Compilation](#examples-compilation)
1. [Multiagent Domains](#multiagent-domains)
1. [Compilers from Multiagent to Classical Planning](#ma-classical-compilers)
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

### CoDMAP-15 Domains

The `codmap15` folder contains 12 different domains that were used in the [Competition of Distributed and Multiagent Planners (CoDMAP)](http://agents.fel.cvut.cz/codmap/). Some domains, apart from the original `domain.pddl` file, contain a `domain_constrained.pddl` forcing some constraints on the concurrency between actions using  [[Kovacs, 2012]](#ref-kovacs) specification.

### Maze Domain

### TableMover Domain

### Workshop Domain

## <a name="compilers-ma-classical"></a>Compilers from Multiagent to Classical Planning

## <a name="references"></a>References

* <a name="ref-boutilier">Boutilier, C. and Brafman, R. I. (2001).</a> [_Partial-Order Planning with Concurrent Interacting Actions._](http://dx.doi.org/10.1613/jair.740) Journal of Artificial Intelligence Research (JAIR) 14, 105-136.

* <a name="ref-kovacs">Kovacs, D. L. (2012).</a> [_A Multi-Agent Extension of PDDL 3.1._](http://www.r3-cop.eu/wp-content/uploads/2013/01/A-Multy-Agent-Extension-of-PDDL3.1.pdf) In Proceedings of the 3rd Workshop on the International Planning Competition (IPC), 19–27.

* <a name="ref-crosby-ecai14">Crosby, M., Jonsson, A., and Rovatsos, M. (2014).</a> [_A Single-Agent Approach to Multiagent Planning_](https://doi.org/10.3233/978-1-61499-419-0-237). Proceedings of the 21st European Conference on Artificial Intelligence (ECAI-14), 237-242.

