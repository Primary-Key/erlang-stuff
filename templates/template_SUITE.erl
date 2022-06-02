 %%%-------------------------------------------------------------------
 %%% File       : example_SUITE.erl
 %%% Author     : 
 %%% Description: 
 %%% Created    : 
 %%%-------------------------------------------------------------------
 -module(template_SUITE).
 -compile(export_all).

 -include_lib("common_test/include/ct.hrl").

 suite() ->
     [{timetrap,{minutes,10}}].

 init_per_suite(Config) ->
     Config.

 end_per_suite(_Config) ->
     ok.

 init_per_group(_GroupName, Config) ->
     Config.

 end_per_group(_GroupName, _Config) ->
     ok.

 init_per_testcase(_TestCase, Config) ->
     Config.

 end_per_testcase(_TestCase, _Config) ->
     ok.

 %%--------------------------------------------------------------------
 %% Function: groups() -> [Group]
 %% Group = {GroupName,Properties,GroupsAndTestCases}
 %% GroupName = atom()
 %%   The name of the group.
 %% Properties = [parallel | sequence | Shuffle | {RepeatType,N}]
 %%   Group properties that may be combined.
 %% GroupsAndTestCases = [Group | {group,GroupName} | TestCase]
 %% TestCase = atom()
 %%   The name of a test case.
 %% Shuffle = shuffle | {shuffle,Seed}
 %%   To get cases executed in random order.
 %% Seed = {integer(),integer(),integer()}
 %% RepeatType = repeat | repeat_until_all_ok | repeat_until_all_fail |
 %%              repeat_until_any_ok | repeat_until_any_fail
 %%   To get execution of cases repeated.
 %% N = integer() | forever
 %%--------------------------------------------------------------------
 groups() ->
     [].

 %%--------------------------------------------------------------------
 %% Function: all() -> GroupsAndTestCases | {skip,Reason}
 %% GroupsAndTestCases = [{group,GroupName} | TestCase]
 %% GroupName = atom()
 %%   Name of a test case group.
 %% TestCase = atom()
 %%   Name of a test case.
 %% Reason = term()
 %%   The reason for skipping all groups and test cases.
 %%--------------------------------------------------------------------
 all() -> 
     [my_test_case].

 %%--------------------------------------------------------------------
 %% Function: TestCase() -> [tuple()]
 %% Description: Test case info function - returns list of tuples to set
 %%              properties for the test case.
 %%--------------------------------------------------------------------
 my_test_case() -> 
     [].

 my_test_case(_Config) -> 
     ok.