-module(circular_buffer).

-export([init/1, create/1, read/1, size/1, write/2, write_attempt/2]).

create(Size) ->
  spawn(?MODULE, init, [Size]).

read(Pid) ->
  Ref = erlang:monitor(process, Pid),
  Pid ! {Ref, read, self()},
  receive
    {Ref, ok, N} -> {ok, N};
    {Ref, error, empty} -> {error, empty}
  end.

size(Pid) ->
  Ref = erlang:monitor(process, Pid),
  Pid ! {Ref, size, self()},
  receive
    {Ref, ok, N} -> {ok, N}
  end.
        
write(Pid, Item) ->
  Ref = erlang:monitor(process, Pid),
  Pid ! {Ref, write, Item}.

write_attempt(Pid, Item) ->
  Ref = erlang:monitor(process, Pid),
  Pid ! {Ref, write_attempt, self(), Item},
  receive
    {Ref, ok} -> ok;
    {Ref, error, full} -> {error, full}
  end.

init(Size) ->
  Map = lists:foldl(fun (X, M) -> maps:put(X, undefined, M) end, 
    #{}, lists:seq(1,Size)),
  Buffer = #{
    write => 1,
    read => 1,
    size => Size,
    map => Map
  },
  circular_buffer(Buffer).

circular_buffer(#{write := W, read := R, size := S, map := M} = B) ->
  receive
    {Ref, size, Addr} ->
        Addr ! {Ref, ok, S},
        circular_buffer(B);
    {_Ref, write, Item} ->
      NW = campare_increment_limit(W, S),
      circular_buffer(B#{write => NW, map => M#{W => Item}});
    {Ref, read, Addr} ->
      case maps:get(R, M) of
        undefined -> 
          Addr ! {Ref, error, empty},
            NR = R;
        Val -> 
          Addr ! {Ref, ok, Val},
          NR = campare_increment_limit(R, S)
      end,
      circular_buffer(B#{map => M#{R => undefined}, read => NR});
    {Ref, write_attempt, Addr, Item} ->
      case maps:get(W, M) of
        undefined ->
          Addr ! {Ref, ok},
          NW = campare_increment_limit(W, S),
          NewM = M#{W => Item};
        _ ->
          Addr ! {Ref, error, full},
          NW = W,
          NewM = M
      end,
      circular_buffer(B#{map => NewM, write => NW})
    end.

campare_increment_limit(OldVal, Limit) ->
  case OldVal + 1 > Limit of
    true -> 1;
    false -> OldVal + 1
  end.