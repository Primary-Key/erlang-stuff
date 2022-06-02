-module(strategy_pattern).
-compile(export_all).

example() ->
    House = #{name => "house", size => "big", color => "blue"},
    Apple = #{name => "apple", size => "small", color => "red"},
    Plant = #{name => "plant", size => "medium", color => "green"},
    Items = [House, Apple, Plant],
    Is_Green = fun(#{color := "green"}) -> true; (_) -> false end,
    Is_Medium = fun(#{size := "medium"}) -> true; (_) -> false end,
    Is_Green_And_Medium = fun(Item) -> Is_Green(Item) and Is_Medium(Item) end,

    Green_Filter = fun(Items) -> lists:filter(Is_Green, Items) end,

    io:format("~p~n", [Green_Filter(Items)]),
    io:format("~p~n", [lists:filter(Is_Medium, Items)]),
    io:format("~p~n", [lists:filter(Is_Green_And_Medium, Items)]).