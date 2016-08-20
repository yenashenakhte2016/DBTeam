
do

function run(msg, matches)
local reply_id = msg['id']
local text = 'Welcome to Security Bot!\n\n>To get a new Security Bot  group, contact a support group:\n https://telegram.me/joinchat/D4HJJwkKcH5iL9Q1MEpf2w\n\nFor more information, check out our channels:\n\nChannel : @MuteTeam\nSite : Mute-Team.ir \n\nUse #superhelp command to show bot commands!!\n\n@SecurityBot'
if matches [1] == 'start' then
reply_msg(reply_id, text, ok_cb, false)
end
end
return {
patterns = {
'^[#!/](start)$',
},
run = run
}

end
