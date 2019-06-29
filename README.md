# GeometricFlux.jl

[![Build Status](https://travis-ci.org/yuehhua/GeometricFlux.jl.svg?branch=master)](https://travis-ci.org/yuehhua/GeometricFlux.jl)
[![codecov](https://codecov.io/gh/yuehhua/GeometricFlux.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/yuehhua/GeometricFlux.jl)

GeometricFlux is a geometric deep learning library for [Flux](https://github.com/FluxML/Flux.jl). This library aims to be compatible with packages from [JuliaGraphs](https://github.com/JuliaGraphs) ecosystem and have support of CUDA GPU acceleration with [CuArrays](https://github.com/JuliaGPU/CuArrays.jl).

## Development

[![Build Status](https://travis-ci.org/yuehhua/GeometricFlux.jl.svg?branch=develop)](https://travis-ci.org/yuehhua/GeometricFlux.jl)
[![codecov](https://codecov.io/gh/yuehhua/GeometricFlux.jl/branch/develop/graph/badge.svg)](https://codecov.io/gh/yuehhua/GeometricFlux.jl)

This repository is in early development. Suggestions and PRs are welcome.

## Roadmap

Construct layers from adjacency matrix or graph (maybe extend to other structures).
Input features (including vertex, edge or graph features) of neural network may not need a structure or type.
Labels or features for output of classification or regression are part of training data, they may not need a specific structure or type, too.

* Start
    * [ ] Establish a simple example of GNN
* Integration of JuliaGraphs
    * [ ] Construct layer from SimpleGraph
    * [ ] Construct layer from SimpleWeightedGraph
    * [ ] Construct layer from Matrix
    * Support vertex/edge/graph features from MetaGraphs
* Layers
    * Convolution layers
        * [ ] MessagePassing
        * [x] GCNConv
        * [ ] GraphConv
        * [x] ChebConv
        * [ ] GatedGraphConv
        * [ ] GATConv
        * [ ] EdgeConv
        * [ ] Meta
    * Pooling layers
        * [ ] GlobalPool
        * [ ] TopKPool
        * [ ] MaxPool
        * [ ] MeanPool
    * Embedding layers
        * [ ] InnerProductDecoder
* Networks
    * [ ] VGAE
* Datasets
    * Benchmark JLD2, BSON
