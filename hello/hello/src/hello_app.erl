%%%-------------------------------------------------------------------
%% @doc hello public API
%% @end
%%%-------------------------------------------------------------------

-module(hello_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_Type, _Args) ->
        Dispatch = cowboy_router:compile([
            {'_', [
                {"/", default_page_h, []},
                {"/hello", hello_page_h, []}
                
            ]}
        ]),

    	PrivDir = code:priv_dir(tracker_business_logic),
        
    	%tls stands for transport layer security
          {ok,_} = cowboy:start_tls(https_listener, [
                  		{port, 443},
				{certfile, PrivDir ++ "hello/hello/priv/ssl/fullchain.pem"},
				{keyfile, PrivDir ++ "hello/hello/priv/ssl/privkey.pem"}
              		], #{env => #{dispatch => Dispatch}}),

        hello_sup:start_link().

stop(_State) ->
    ok.                                                                                     

%% internal functions

%% internal functions
