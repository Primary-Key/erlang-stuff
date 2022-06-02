-module(singleton).
-compile(export_all).

loop(C) ->
    receive
        add -> loop(C+1);
        sub -> loop(C-1);
        {show, PID} -> PID ! C, loop(C)
    end. 

test() ->
    CounterPID = spawn(localproc, loop, [0]), % assigning PID to CounterPID
    register(counter, CounterPID), % registering name in local node
    AddOne = fun (_) -> CounterPID ! add end, % sending to PID
    SubOne = fun (_) -> counter ! sub end, % sending to registered name
    lists:foreach(AddOne, lists:seq(1, 10)), % send add 10 times
    lists:foreach(SubOne, lists:seq(1, 5)), % send sub 5 times
    CounterPID ! {show, self()}, % asking to get the counter stored value
    receive X -> io:format("~p~n", [X]) end. % should print 5