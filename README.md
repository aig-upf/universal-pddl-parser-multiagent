# Universal PDDL Parser - Multiagent Extension

An extension to the [Universal PDDL Parser](https://github.com/aig-upf/universal-pddl-parser) to handle multiagent domains.

1. [Installation](#installation)
	1. [Universal PDDL Parser](#universal-pddl-parser)
	1. [Multiagent Extension](#multiagent-extension)
1. [References](#references) 

## <a name="installation"></a>Installation

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

## <a name="references"></a>References

* <a name="ref-crosby-ecai14">Crosby, M., Jonsson, A., and Rovatsos, M. (2014).</a> [_A Single-Agent Approach to Multiagent Planning_](https://doi.org/10.3233/978-1-61499-419-0-237). Proceedings of the 21st European Conference on Artificial Intelligence (ECAI-14), 237-242 (2014).

* <a name="ref-kovacs">Kovacs, D. L. (2012).</a> [_A Multi-Agent Extension of PDDL 3.1._](http://www.r3-cop.eu/wp-content/uploads/2013/01/A-Multy-Agent-Extension-of-PDDL3.1.pdf). In Proceedings of the 3rd Workshop on the International Planning Competition (IPC), 19–27 (2012).

