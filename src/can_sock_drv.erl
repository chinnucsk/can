%% Generated by eapi (DO NOT EDIT)
-module(can_sock_drv).

-export([start_link/0, start/0, stop/0]).
-export([start_link/1, start/1]).
-export([set_loopback/1]).
-export([ifindex/1]).
-export([ifname/1]).
-export([bind/1]).
-export([send/2]).
-export([recv_own_messages/1]).
-export([set_error_filter/1]).
-include_lib("eapi/include/cbuf.hrl").
-include("../include/can.hrl").
-include("can_sock_drv.hrl").

-compile(export_all).

start_link() ->
  start_link([]).

start_link(Opts) ->
  eapi_drv:start_link([
    {srv_name, can_sock_drv},
    {prt_name, can_sock_prt},
    {reg_name, can_sock_reg},
    {driver_name, "can_sock_drv"},
    {app, can} | Opts]).

start() ->
  start([]).

start(Opts) ->
  eapi_drv:start([
    {srv_name, can_sock_drv},
    {prt_name, can_sock_prt},
    {reg_name, can_sock_reg},
    {driver_name, "can_sock_drv"},
    {app, can}|Opts]).

stop() ->
  eapi_drv:stop(can_sock_drv).

e_struct_can_frame(R)->
  Rtr__bool=if (R#can_frame.rtr) -> 1; true -> 0 end,
  Ext__bool=if (R#can_frame.ext) -> 1; true -> 0 end,
  Data__size = byte_size(R#can_frame.data),  <<?uint32_t((R#can_frame.id)),?uint8_t(Rtr__bool),?uint8_t(Ext__bool),?int_t((R#can_frame.intf)),?uint8_t((R#can_frame.len)),?uint32_t(Data__size),(R#can_frame.data)/binary,?int_t((R#can_frame.ts))>>.

ifname(Index) -> 
  eapi_drv:control(can_sock_prt,?CAN_SOCK_DRV_CMD_IFNAME, <<?int_t((Index))>>).
ifindex(Name) -> 
  Name__bin = list_to_binary([Name]),Name__size = byte_size(Name__bin),
  eapi_drv:control(can_sock_prt,?CAN_SOCK_DRV_CMD_IFINDEX, <<?uint32_t(Name__size),Name__bin/binary>>).
set_error_filter(Mask) -> 
  eapi_drv:control(can_sock_prt,?CAN_SOCK_DRV_CMD_SET_ERROR_FILTER, <<?uint32_t((Mask))>>).
set_loopback(Enable) -> 
  Enable__bool=if (Enable) -> 1; true -> 0 end,
  eapi_drv:control(can_sock_prt,?CAN_SOCK_DRV_CMD_SET_LOOPBACK, <<?uint8_t(Enable__bool)>>).
recv_own_messages(Enable) -> 
  Enable__bool=if (Enable) -> 1; true -> 0 end,
  eapi_drv:control(can_sock_prt,?CAN_SOCK_DRV_CMD_RECV_OWN_MESSAGES, <<?uint8_t(Enable__bool)>>).
bind(Index) -> 
  eapi_drv:control(can_sock_prt,?CAN_SOCK_DRV_CMD_BIND, <<?int_t((Index))>>).
send(Index,Frame) -> 
  Frame__bin = e_struct_can_frame(Frame),Frame__size = byte_size(Frame__bin),
 eapi_drv:command(can_sock_prt,?CAN_SOCK_DRV_CMD_SEND, [<<?int_t((Index))>>,<<?uint32_t(Frame__size),Frame__bin/binary>>]).