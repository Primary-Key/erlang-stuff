-module(joiner).
-compile(export_all).

loop(Address, MsgList) ->
    receive
        {set_address, PID} ->
            loop(PID, MsgList);
        bang ->
            Address ! MsgList,
            loop(Address, []);
        Msg ->
            loop(Address, MsgList ++ [Msg])
    end.