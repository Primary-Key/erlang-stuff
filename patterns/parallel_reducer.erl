-module(parallel_reducer).
-compile(export_all).

even(Numbers) ->
    mapreduce(Numbers, fun (Number) -> Number rem 2 == 0 end).
mapreduce(Numbers, Function) ->
    Parent = self(),
    [spawn(fun () -> Parent ! {Number, Function(Number)} end) || Number <- Numbers],
    Returns = [receive {Number, true} -> Number; _ -> [] end || Number <- Numbers],
    lists:flatten(Returns).
  