
©

game.protogame"°
GameStartNtf
session (
	playercnt (1

playerinfo (2.game.GameStartNtf.PlayerInfoI

PlayerInfo
uid (
seatid (
gold (	
nickname (	"/

SetSession
session (
clientid ("—
	TableInfo
session (%
players (2.game.TableInfo.InfoR
Info
uid (
seatid (
ready (
gold (	
nickname (	"Z

EnterTable
session (
uid (
seatid (
gold (	
nickname (	"D
AskReady
session (
time (
uid (
flag (":

LeaveTable
session (
uid (
reason ("
GetReadyReq
session (">
GetReadyRep
session (
result (
seatid ("j
	AskCashOn
session (
index (
time (
seatid (
money (
maxmoney ("_
AnswerCashOn
session (
index (
seatid (
money (
betcount (	"M

UseCardNtf
session (
index (
seatid (
cardids ("X
	AskMaster
session (
index (
seatid (
score (
time (".
AnswerMaster
session (
score ("k
SetScore
session (
index (
score (
seatid (
ismaster (
status ("m
AskPlayCard
session (
index (
seatid (
time (
pseatid (
cardids ("‰
AddCard
session (
index (
seatid (
	askseatid (
cardid (
time (
odds (
cardids ("K
ShowCard
session (
index (
seatid (
cardids ("+
GameEnd
session (
chanage ("7
TalkNtf
session (
seatid (
msg (	"j
RobotSetInfos
session (,
cardids (2.game.RobotSetInfos.CardIds
CardIds
cardids ("<
SetCards
session (
seatid (
cardids (">
ReconnectReq
session (
seatid (
index ("Ê
ReconnectRep
session (
status (
time (.
players (2.game.ReconnectRep.PlayerInfo
params1 (
params2 (9

PlayerInfo
uid (
seatid (
params ("0
GiveUpGameReq
session (
status ("0
GiveUpGameRep
session (
result (";
UserOffline
session (
result (
uid (":

UserOnline
session (
seatid (
uid ("¦
GameActionReq
session (
seatid (
action (	.
addition (2.game.GameActionReq.Addition4
Addition
msgi (
msgb (
msgs (	"µ
GameActionRep
session (
index (
seatid (
action (	.
addition (2.game.GameActionRep.Addition4
Addition
msgi (
msgb (
msgs (	"Ý
UpdateMasterInfo
session (
optype (
bankerscore (
bankergamecnt (
maxmoney (	/
info (2!.game.UpdateMasterInfo.MasterInfo9

MasterInfo
uid (
nickname (	
gold (	"S
UpdateBetInfo
session (
optype (
timeout (
betcount ("A
GameStatusNtf
session (
optype (
timeout ("R
UpdateGameInfo
session (
index (
params1 (
params2 ("=

OperateReq
session (
optype (
params ("€

OperateRep
session (
index (
optype (
seatid (
	askseatid (
timeout (
params ("1
UserInfoInGameReq
session (
uid ("b
UserInfoInGameRep
session (
uid (
nickname (	
gold (	
imageid (	