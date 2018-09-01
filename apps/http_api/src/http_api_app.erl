%%%-------------------------------------------------------------------
%% @doc http_api public API
%% @end
%%%-------------------------------------------------------------------

-module(http_api_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
        {'_',
         [
          {"/ping", ping_handler, []},
          {"/save", save_handler, []}
         ]}
    ]),
    {ok, _} = cowboy:start_http(http_listener, 100,
                                [{port, 8080}],
                                [{env, [{dispatch, Dispatch}]}]),
    http_api_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
