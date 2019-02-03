module TSMLTypes
export typerun
export 	Transformer,
		TSLearner,
		fit!,
		transform!

abstract type Transformer end
abstract type TSLearner <: Transformer end

function transform!(tr::Transformer, instances::T) where {T<:Union{Vector,Matrix}}
	error(typeof(tr)," not implemented yet: transform!")
end

function fit!(tr::Transformer, instances::T, labels::Vector) where {T<:Union{Vector,Matrix}}
	error(typeof(tr)," not implemented yet: fit!")
end

function typerun()
	println("hello types")
end

end
