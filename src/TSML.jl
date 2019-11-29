module TSML
using Reexport

# reexport common functions to Main
include("pkgdeps.jl")
using .PkgDeps

include("imputer/Imputers.jl")
using .Imputers

include("types.jl")
using .TSMLTypes

include("utils.jl")
using .Utils

include("basefilters.jl")
using .BaseFilters

include("valdatefilters.jl")
using .ValDateFilters

include("baseline.jl")
using .BaselineAlgos

include("mlbase.jl")
using .MLBaseWrapper

include("decisiontree.jl")
using .DecisionTreeLearners

include("normalizer.jl")
using .Normalizers

include("statifier.jl")
using .Statifiers

include("monotonicer.jl")
using .Monotonicers

include("cliwrapper.jl")
using .CLIWrappers

include("tsclassifier.jl")
using .TSClassifiers

include("outliernicer.jl")
using .Outliernicers

include("plotter.jl")
using .Plotters

include("timescaledb.jl")
using .TimescaleDBs

include("demo.jl")
using .TSMLDemo

include("argparse.jl")
using .ArgumentParsers

include("ensemble.jl")
using .EnsembleMethods

include("schema.jl")
using .Schemalizers

end # module
