-module(sieve).

-export([primes/1]).

primes(0) -> [];
primes(1) -> [];
primes(Limit) ->
  Map = lists:foldl(fun (X, M) -> maps:put(X, p, M) end, #{}, lists:seq(2,Limit)),
  primes(2, Limit, Map).

primes(N, Limit, Map) when N == Limit ->
  FilteredMap = maps:filter(fun (_K, V) -> V == p end, Map),
  maps:keys(FilteredMap);

primes(N, Limit, Map) ->
  case maps:get(N, Map) of
    p ->
      %% Update Map here
      IntegerMultiples = lists:seq(N*2, Limit, N),
      NewMap = lists:foldl(fun (X, M) -> maps:put(X, np, M) end, Map, IntegerMultiples),
      primes(N+1, Limit, NewMap);
    np ->
      %% No update required here
      primes(N+1, Limit, Map)
  end.