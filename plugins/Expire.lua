﻿local function check_member_superrem2(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local data = cb_extra.data
  local msg = cb_extra.msg
  for k,v in pairs(result) do
    local member_id = v.id
    if member_id ~= our_id then
	  -- Group configuration removal
      data[tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = nil
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
	  chat_del_user(get_receiver(msg), 'user#id'..260163879, ok_cb, false)
	  leave_channel(get_receiver(msg), ok_cb, false)
    end
  end
end

local function superrem2(msg)
	local data = load_data(_config.moderation.data)
    local receiver = get_receiver(msg)
    channel_get_users(receiver, check_member_superrem2,{receiver = receiver, data = data, msg = msg})
end
local function pre_process(msg)
	local timetoexpire = 'unknown'
	local expiretime = redis:hget ('expiretime', get_receiver(msg))
	local now = tonumber(os.time())
	if expiretime then    
		timetoexpire = math.floor((tonumber(expiretime) - tonumber(now)) / 86400) + 1
		if tonumber("0") > tonumber(timetoexpire) then
		if get_receiver(msg) then
		redis:del('expiretime', get_receiver(msg))
		rem_mutes(msg.to.id)
		superrem2(msg)
		return send_large_msg(get_receiver(msg), 'تاریخ اتقضای گروه به پایان رسید.\n از پشتیبانی در خواست تمدید کنید.')
		else
			return
		end
	end
	if tonumber(timetoexpire) == 0 then
			if redis:hget('expires0',msg.to.id) then return msg end
		local user = "user#id"..250049437
		local text = "تاریخ انقضای گروه ارسال شده به پایان رسیده است"
			local text12 = "0"
			local data = load_data(_config.moderation.data)
			local group_owner = data[tostring(msg.to.id)]['set_owner']
			if not group_owner then
group_owner = "--"
end
			local group_link = data[tostring(msg.to.id)]['settings']['set_link']
			if not group_link then
group_link = "Unset"
end
local exppm = '💢انقضای این گروه ارسال شده به اتمام است\n'
..'----------------------------------\n'
..'👥نام گروه : <code> '..msg.to.title..' </code>\n'
..'🆔آیدی گروه : <code> '..msg.to.id..'  </code>\n'
..'💢آیدی صاحب گروه:  <code> '..group_owner..'  </code> \n'
..'➰لینک گروه: '..group_link..'\n'
..'🔘تعداد زمان باقی مانده:\n'..text12..'\n'
..'----------------------------------\n'
..'🔋برای شارژ کردن یک ماهه گروه عبارت زیر را بزنید :\n'
..'/setexp_'..msg.to.id..'_30\n\n'
..'🔋برای شارژ کردن سه ماهه گروه عبارت زیر را بزنید :\n'
..'/setexp_'..msg.to.id..'_90\n\n'
..'🔋برای شارژ کردن نامحدود گروه عبارت زیر را بزنید :\n'
..'/setexp_'..msg.to.id..'_999\n\n'
..'----------------------------------\n'
..'@TeleMuteTG'
			local sends = send_msg(user, exppm, ok_cb, false)   
			send_large_msg(get_receiver(msg), '0 روز تا پایان تاریخ انقضای گروه باقی مانده است\nنسبت به تمدید اقدام کنید.')
   redis:hset('expires0',msg.to.id,'0')
	end
	if tonumber(timetoexpire) == 1 then
			if redis:hget('expires1',msg.to.id) then return msg end
      local user = "user#id"..250049437
			local text2 = "تاریخ انقضای گروه ارسال شده 1 روز دیگر به پایان میرسد"
			local text13 = "1"
			local data = load_data(_config.moderation.data)
			local group_owner = data[tostring(msg.to.id)]['set_owner']
			if not group_owner then
group_owner = "--"
end
			local group_link = data[tostring(msg.to.id)]['settings']['set_link']
			if not group_link then
group_link = "Unset"
end
local exppm = '💢انقضای مشخصات گروه ارسال شده در حال اتمام است\n'
..'----------------------------------\n'
..'👥نام گروه : <code> '..msg.to.title..' </code>\n'
..'🆔آیدی گروه: <code> '..msg.to.id..'  </code>\n'
..'🏅آیدی صاحب گروه :  <code> '..group_owner..'  </code> \n'
..'➰لینک گروه : '..group_link..' \n'
..'🔘تعداد زمان باقی مانده:\n'..text13..'\n'
..'----------------------------------\n'
..'🔋برای شارژ کردن یک ماهه گروه عبارت زیر را بزنید :\n'
..'/setexp_'..msg.to.id..'_30\n\n'
..'🔋برای شارژ کردن 3 ماهه گروه عبارت زیر را بزنید :\n'
..'/setexp_'..msg.to.id..'_90\n\n'
..'🔋برای شارژ کردن نامحدود گروه عبارت زیر را بزنید :\n'
..'/setexp_'..msg.to.id..'_999\n\n'
..'----------------------------------\n'
..'@TeleMuteTG'
		local sends = send_msg(user, exppm, ok_cb, false)
			send_large_msg(get_receiver(msg), '1 روز تا پایان تاریخ انقضای گروه باقی مانده است\nنسبت به تمدید اقدام کنید.')
		redis:hset('expires1',msg.to.id,'1')
	end
	if tonumber(timetoexpire) == 2 then
		if redis:hget('expires2',msg.to.id) then return msg end
		send_large_msg(get_receiver(msg), '2 روز تا پایان تاریخ انقضای گروه باقی مانده است\nنسبت به تمدید اقدام کنید.')
		redis:hset('expires2',msg.to.id,'2')
	end
	if tonumber(timetoexpire) == 3 then
					if redis:hget('expires3',msg.to.id) then return msg end
		send_large_msg(get_receiver(msg), '3 روز تا پایان تاریخ انقضای گروه باقی مانده است\nنسبت به تمدید اقدام کنید.')
			redis:hset('expires3',msg.to.id,'3')
	end
	if tonumber(timetoexpire) == 4 then
					if redis:hget('expires4',msg.to.id) then return msg end
		send_large_msg(get_receiver(msg), '4 روز تا پایان تاریخ انقضای گروه باقی مانده است\nنسبت به تمدید اقدام کنید.')
		redis:hset('expires4',msg.to.id,'4')
	end
	if tonumber(timetoexpire) == 5 then
					if redis:hget('expires5',msg.to.id) then return msg end
		send_large_msg(get_receiver(msg), '5 روز تا پایان تاریخ انقضای گروه باقی مانده است\nنسبت به تمدید اقدام کنید.')
		redis:hset('expires5',msg.to.id,'5')
	end
end
return msg
end
function run(msg, matches)
	if matches[1]:lower() == 'setexpire' then
		if not is_sudo(msg) then return end
		local time = os.time()
		local buytime = tonumber(os.time())
		local timeexpire = tonumber(buytime) + (tonumber(matches[2]) * 86400)
		redis:hset('expiretime',get_receiver(msg),timeexpire)
		return "تاریخ انقضای گروه:\nبه "..matches[2].. " روز دیگر تنظیم شد."
	end
	
	if matches[1]:lower() == 'setexp' then
		if not is_sudo(msg) then return end
    local expgp = "channel#id"..matches[2]
		local time = os.time()
		local buytime = tonumber(os.time())
		local timeexpire = tonumber(buytime) + (tonumber(matches[3]) * 86400)
		redis:hset('expiretime',expgp,timeexpire)
		return "تاریخ انقضای گروه:\nبه "..matches[3].. " روز دیگر تنظیم شد."
	end
	if matches[1]:lower() == 'expire' then
		local expiretime = redis:hget ('expiretime', get_receiver(msg))
		if not expiretime then return 'تاریخ ست نشده است' else
			local now = tonumber(os.time())
			local text = (math.floor((tonumber(expiretime) - tonumber(now)) / 86400) + 1)
			return (math.floor((tonumber(expiretime) - tonumber(now)) / 86400) + 1) .. "  روز دیگر تا پایان انقضای گروه باقی مانده است\nاگر تمایل به شارژ کردن گروه دارید دستور زیر را اسال نمایید\n /charge"
		
		end
		end
			if matches[1]:lower() == 'charge' then
			if not is_owner(msg) then return end
			local expiretime = redis:hget ('expiretime', get_receiver(msg))
			local now = tonumber(os.time())
			local text4 = (math.floor((tonumber(expiretime) - tonumber(now)) / 86400) + 1)
			if not expiretime then 
				expiretime = "-"
				end
local text3 = "صاحب گروه درخواست شارژ کردن گروه را دارد"
local user = "user#id"..250049437
local data = load_data(_config.moderation.data)
local group_owner = data[tostring(msg.to.id)]['set_owner']
if not group_owner then
group_owner = "--"
end
local group_link = data[tostring(msg.to.id)]['settings']['set_link']
if not group_link then
group_link = "Unset"
end
local exppm = '💢یک گروه درخواست شارژ کردن گروه خود را داد\n'
..'----------------------------------\n'
..'👥نام گروه : <code> '..msg.to.title..' </code>\n'
..'🆔آیدی گروه: <code> '..msg.to.id..'  </code>\n'
..'🏅صاحب گروه :  <code> '..group_owner..'  </code> \n'
..'➰لینک گروه : '..group_link..' \n'
..'🔘تعداد زمان باقی مانده: '..text4..'  \n'
..'🔘درباره ی پیام:\n'..text3..'  \n'
..'----------------------------------\n'
..'🔋برای شارژ کردن یک ماهه این گروه عبارت زیر را بزنیر :\n'
..'/setexp_'..msg.to.id..'_30 +'..text4..'\n\n'
..'🔋برای شارژ کردن 3 ماهه گروه عبارت زیر را بزنید :\n'
..'/setexp_'..msg.to.id..'_90 +'..text4..'\n'
..'🔋برای شارژ کردن نامحدود گروه عبارت زیر را بزنید:\n'
..'/setexp_'..msg.to.id..'_999\n\n'
..'----------------------------------\n'
..'@TeleMuteTG'
			local sends = send_msg(user, exppm, ok_cb, false)
		return "درخواست شما برای شارژ مجدد گروه ارسال شد"
end
end
return {
  patterns = {
    "^(setexpire) (.*)$",
		"^(setexp)_(.*)_(.*)$",
	  "^(expire)$",
		"^(charge)$",
		"^[!#/](charge)$",
		"^[!#/](setexpire) (.*)$",
		"^[!#/](setexp)_(.*)_(.*)$",
	"^[!#/](expire)$",
  },
  run = run,
  pre_process = pre_process
}
