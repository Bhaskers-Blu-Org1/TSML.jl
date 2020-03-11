module TimescaleDBs

using HTTP, JSON2
using Dates
using DataFrames

using AutoMLPipeline.AbsTypes
using AutoMLPipeline.Utils
import AutoMLPipeline.AbsTypes: fit!, transform!

export fit!,transform!
export TimescaleDB

# Transforms instances with nominal features into one-hot form
# and coerces the instance matrix to be of element type Float64.
mutable struct TimescaleDB <: Transformer
  model
  args

  function TimescaleDB(args=Dict())
    default_args = Dict(
        :uri => "http://localhost:3000",
        :db => "dateval",
        :dbusername =>"postgres",
        :dbpassword => "mysecretpassword",
        :query => "select=date,value"
    )
    new(nothing, mergedict(default_args, args))
  end
end

function fit!(tdb::TimescaleDB, features::DataFrame=DataFrame(), labels::Vector=[]) 
  (features == DataFrame() && labels == [])  || error("features and labels should be empty because data are from http request")
  uri = tdb.args[:uri]; db = tdb.args[:db]; query = tdb.args[:query] 
  (uri != "" && query != "" && db != "") || error("missing uri/query/db")
  tdb.model = tdb.args
end

function transform!(tdb::TimescaleDB, features::DataFrame=DataFrame())
  features == DataFrame()  || error("features should be empty because data are from http request")
  uri = tdb.args[:uri]; db = tdb.args[:db]; query = tdb.args[:query] 
  (uri != "" && query != "" && db != "") || error("missing uri/query/db")
  payload = uri*"/"*db*"?"*query
  req = HTTP.get(payload)
  req.status == 200 || error(req.status)
  body = String(req.body)
  df = body |> JSON2.read |> DataFrame
  ncol(df) == 2 || error("data should have 2 columns")
  nrow(df) > 0 || return DataFrame()
  rename!(df,names(df)[1] => :Date, names(df)[2] => :Value)
  df.Date = DateTime.(df.Date)
  eltype(df.Value) <: Number || error("values in second column are not numeric")
  return df
end

end
