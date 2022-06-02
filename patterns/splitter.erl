-module(splitter).
-export([loop/2, helper/1]).
-compile(export_all).

%% Initialized with a list of destinations and counter, progresses
%% through PIDs to send the Msg to successive receivers, while incrementing
%% a counter N

loop(Dests, N) when N =< length(Dests) ->
    receive
        Msg ->
            Dest = lists:nth(N, Dests),
            Dest ! Msg,
            loop(Dests, N + 1)
    end;
loop(Dests, N) when N > length(Dests) ->
    loop(Dests, 1).

helper(Name) ->
    receive
        Msg ->
            io:format("Helper process ~s received ~p.~n", [Name, Msg]),
            helper(Name)
    end.
