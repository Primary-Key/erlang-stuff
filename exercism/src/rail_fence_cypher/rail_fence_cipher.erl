-module(rail_fence_cipher).

-export([decode/2, encode/2]).


decode(_Message, _Rails) -> undefined.

encode(Message, Rails) ->
  %% Prepare empty rails to store text
  RailsMap = lists:foldl(fun (R, Map) -> Map#{R => []} end, #{}, lists:seq(1, Rails)),
  encode(Message, Rails, 1, RailsMap, down).

encode([], _, _, RailsMap, _) ->
  %% Return encoded value
  NumRails = length(maps:keys(RailsMap)),
  %% Go through rails in order building encoded text
  lists:foldl(fun(R, Text) -> Text ++ maps:get(R, RailsMap) end, [], lists:seq(1, NumRails));

encode([X|Rest], MaxRails, Rail, RailsMap, down) ->
  %% Encoding down the rails
  CurrentRailTxt = maps:get(Rail, RailsMap),
  NewRailsMap = RailsMap#{Rail => CurrentRailTxt ++ [X]},
  case Rail == MaxRails of
    true -> encode(Rest, MaxRails, Rail - 1, NewRailsMap, up);
    false -> encode(Rest, MaxRails, Rail + 1, NewRailsMap, down)
  end;

encode([X|Rest], MaxRails, Rail, RailsMap, up) ->
  %% Encoding up the rails
  CurrentRailTxt = maps:get(Rail, RailsMap),
  NewRailsMap = RailsMap#{Rail => CurrentRailTxt ++ [X]},
  case Rail == 1 of
    true -> encode(Rest, MaxRails, Rail + 1, NewRailsMap, down);
    false -> encode(Rest, MaxRails, Rail - 1, NewRailsMap, up)
  end.