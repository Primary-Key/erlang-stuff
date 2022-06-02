-module(pure_fun).
-compile(export_all).

pure_fun(X) -> X + 1. % takes X, adds 1 and returns new value.

pure_receive() ->
    receive
        {X, PID} -> % receives a tuple with X and return address
            PID ! X + 1, % adds 1 and sends it back
            pure_receive() % recursive call to self
    end.