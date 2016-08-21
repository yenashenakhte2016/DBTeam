do 
-------------------------- 
local function savefile(extra, success, result) 
  local msg = extra.msg 
  local name = extra.name 
  local adress = extra.adress 
  local receiver = get_receiver(msg) 
  if success then 
    local file = './'..adress..'/'..name..'' 
    print('File saving to:', result) 
    os.rename(result, file) 
    print('File moved to:', file) 
  else 
    print('Error downloading: '..msg.id) 
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false) 
  end 
end 
-------------------------- 
local function clean_msg(extra, suc, result) 
  for i=1, #result do 
    delete_msg(result[i].id, ok_cb, false) 
  end 
  if tonumber(extra.con) == #result then 
    send_msg(extra.chatid, ''..#result..' messages were deleted', ok_cb, false) 
  else 
    send_msg(extra.chatid, 'Error Deleting messages', ok_cb, false) 
end 
end 
----------------------- 
local function topng(msg, success, result) 
  local receiver = get_receiver(msg) 
  if success then 
    local file = './data/topng/'..msg.from.id..'.png' 
    print('File downloaded to:', result) 
    os.rename(result, file) 
    print('File moved to:', file) 
    send_document(get_receiver(msg), file, ok_cb, false) 
    redis:del("photo:png") 
  else 
    print('Error downloading: '..msg.id) 
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false) 
  end 
end 
----------------------- 
local function toaudio(msg, success, result) 
  local receiver = get_receiver(msg) 
  if success then 
    local file = './data/toaudio/'..msg.from.id..'.mp3' 
    print('File downloaded to:', result) 
    os.rename(result, file) 
    print('File moved to:', file) 
    send_audio(get_receiver(msg), file, ok_cb, false) 
    redis:del("video:audio") 
  else 
    print('Error downloading: '..msg.id) 
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false) 
  end 
end 
----------------------- 

local function tomkv(msg, success, result) 
  local receiver = get_receiver(msg) 
  if success then 
    local file = './data/tomkv/'..msg.from.id..'.mkv' 
    print('File downloaded to:', result) 
    os.rename(result, file) 
    print('File moved to:', file) 
    send_document(get_receiver(msg), file, ok_cb, false) 
    redis:del("video:document") 
  else 
    print('Error downloading: '..msg.id) 
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false) 
  end 
end 
----------------------- 

local function togif(msg, success, result) 
  local receiver = get_receiver(msg) 
  if success then 
    local file = './data/togif/'..msg.from.id..'.mp4' 
    print('File downloaded to:', result) 
    os.rename(result, file) 
    print('File moved to:', file) 
    send_document(get_receiver(msg), file, ok_cb, false) 
    redis:del("video:gif") 
  else 
    print('Error downloading: '..msg.id) 
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false) 
  end 
end 
----------------------- 
local function tovideo(msg, success, result) 
  local receiver = get_receiver(msg) 
  if success then 
    local file = './data/tovideo/'..msg.from.id..'.gif' 
    print('File downloaded to:', result) 
    os.rename(result, file) 
    print('File moved to:', file) 
    send_video(get_receiver(msg), file, ok_cb, false) 
    redis:del("gif:video") 
  else 
    print('Error downloading: '..msg.id) 
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false) 
  end 
end 
----------------------- 
local function toimage(msg, success, result) 
  local receiver = get_receiver(msg) 
  if success then 
    local file = './data/tophoto/'..msg.from.id..'.jpg' 
    print('File downloaded to:', result) 
    os.rename(result, file) 
    print('File moved to:', file) 
    send_photo(get_receiver(msg), file, ok_cb, false) 
    redis:del("sticker:photo") 
  else 
    print('Error downloading: '..msg.id) 
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false) 
  end 
end 
----------------------- 
local function tosticker(msg, success, result) 
  local receiver = get_receiver(msg) 
  if success then 
    local file = './data/tosticker/'..msg.from.id..'.webp' 
    print('File downloaded to:', result) 
    os.rename(result, file) 
    print('File moved to:', file) 
    send_document(get_receiver(msg), file, ok_cb, false) 
    redis:del("photo:sticker") 
  else 
    print('Error downloading: '..msg.id) 
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false) 
  end 
end 

------------------------ 
local function get_weather(location) 
  print("Finding weather in ", location) 
  local BASE_URL = "http://api.openweathermap.org/data/2.5/weather" 
  local url = BASE_URL 
  url = url..'?q='..location..'&APPID=eedbc05ba060c787ab0614cad1f2e12b' 
  url = url..'&units=metric' 
  local b, c, h = http.request(url) 
  if c ~= 200 then return nil end 

   local weather = json:decode(b) 
   local city = weather.name 
   local country = weather.sys.country 
   local temp = 'دمای شهر '..city..' هم اکنون '..weather.main.temp..' درجه سانتی گراد می باشد\n____________________' 
   local conditions = 'شرایط فعلی آب و هوا : ' 

   if weather.weather[1].main == 'Clear' then 
     conditions = conditions .. 'آفتابی☀' 
   elseif weather.weather[1].main == 'Clouds' then 
     conditions = conditions .. 'ابری ☁☁' 
   elseif weather.weather[1].main == 'Rain' then 
     conditions = conditions .. 'بارانی ☔' 
   elseif weather.weather[1].main == 'Thunderstorm' then 
     conditions = conditions .. 'طوفانی ☔☔☔☔' 
 elseif weather.weather[1].main == 'Mist' then 
     conditions = conditions .. 'مه 💨' 
  end 

  return temp .. '\n' .. conditions 
end 
-------------------------- 
local function mathjs(exp)
  local url = 'http://api.mathjs.org/v1/'
  url = url..'?expr='..URL.escape(exp)
  local b,c = http.request(url)
  local text = nil
  if c == 200 then
    text = 'نتیجه: '..b
  
  elseif c == 400 then
    text = b
  else
    text = 'Unexpected error\n'
      ..'Is api.mathjs.org up?'
  end
  return text
end

local function run(msg, matches)
  return mathjs(matches[1])
end
-------------------------- 
function run(msg, matches) 
    -------------------------- 
  if matches[1] == 'rmsg' and is_momod(msg) then 
    if msg.to.type == "user" then 
      return 
      end 
    if msg.to.type == 'chat' then 
      return  "Only in the Super Group" 
      end 
    if not is_owner(msg) then 
      return "You Are Not Allow To clean Msgs!" 
      end 
    if tonumber(matches[3]) > 100 or tonumber(matches[3]) < 10 then 
      return "Minimum clean 10 and maximum clean is 100" 
      end 
   get_history(msg.to.peer_id, matches[3] + 1 , clean_msg , { chatid = msg.to.peer_id,con = matches[3]}) 
   end 
  -------------------------- 
    if matches[1] == 'addplugin' and is_sudo(msg) then 
        if not is_sudo(msg) then 
           return "You Are Not Allow To Add Plugin" 
           end 
   name = matches[2] 
   text = matches[3] 
   file = io.open("./plugins/"..name, "w") 
   file:write(text) 
   file:flush() 
   file:close() 
   return "Add plugin successful " 
end 
------------------------ 
 if matches[1] == "mean" then 
 http = http.request('http://api.vajehyab.com/v2/public/?q='..URL.escape(matches[2])) 
   data = json:decode(http) 
   return 'واژه : '..(data.data.title or data.search.q)..'\n\nترجمه : '..(data.data.text or '----' )..'\n\nمنبع : '..(data.data.source or '----' )..'\n\n'..(data.error.message or '')..'\n..\n____________________' 
end 
   -------------------------- 
      if matches[1] == "dl" and matches[2] == "plugin" and is_sudo(msg) then 
     if not is_sudo(msg) then 
    return "You Are Not Allow To Download Plugins!" 
  end 
   receiver = get_receiver(msg) 
      send_document(receiver, "./plugins/"..matches[3]..".lua", ok_cb, false) 
      send_document(receiver, "./plugins/"..matches[3], ok_cb, false) 
    end 
    -------------------------- 
if matches[1] == "calc" and matches[2] then 
    if msg.to.type == "user" then 
       return 
       end 
    return calc(matches[2]) 
end 
-------------------------- 
if matches[1] == 'weather' then 
    city = matches[2] 
  local wtext = get_weather(city) 
  if not wtext then 
    wtext = 'مکان وارد شده صحیح نیست' 
  end 
  return wtext 
end 
--------------------- 
if matches[1] == 'time' then 
local url , res = http.request('http://api.gpmod.ir/time/') 
if res ~= 200 then 
 return "No connection" 
  end 
  local colors = {'blue','green','yellow','magenta','Orange','DarkOrange','red'} 
  local fonts = {'mathbf','mathit','mathfrak','mathrm'} 
local jdat = json:decode(url) 
local url = 'http://latex.codecogs.com/png.download?'..'\\dpi{600}%20\\huge%20\\'..fonts[math.random(#fonts)]..'{{\\color{'..colors[math.random(#colors)]..'}'..jdat.ENtime..'}}' 
local file = download_to_file(url,'time.webp') 
send_document(get_receiver(msg) , file, ok_cb, false) 

end 
-------------------- 
function run(msg, matches) local url , res = http.request('http://api.gpmod.ir/time/') if res ~= 200 then return "No connection" end local jdat = json:decode(url) local text = '🕒 ساعت '..jdat.FAtime..' \n📆 امروز '..jdat.FAdate..' میباشد.\n —--------------------------\n🕒 '..jdat.ENtime..'\n📆 '..jdat.ENdate.. '\n' return text end
--------------------
if matches[1] == 'voice' then 
 local text = matches[2] 

  local b = 1 

  while b ~= 0 do 
    textc = text:trim() 
    text,b = text:gsub(' ','.') 
  if msg.to.type == 'user' then 
      return nil 
      else 
  local url = "http://tts.baidu.com/text2audio?lan=en&ie=UTF-8&text="..textc 
  local receiver = get_receiver(msg) 
  local file = download_to_file(url,'mohamad.ogg') 
 send_audio('channel#id'..msg.to.id, file, ok_cb , false) 
end 
end 
end 
 -------------------------- 
   if matches[1] == "tr" then 
     url = https.request('https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20160119T111342Z.fd6bf13b3590838f.6ce9d8cca4672f0ed24f649c1b502789c9f4687a&format=plain&lang='..URL.escape(matches[2])..'&text='..URL.escape(matches[3])) 
     data = json:decode(url) 
   return 'زبان : '..data.lang..'\nترجمه : '..data.text[1]..'\n____________________\n' 
end 
----------------------- 
if matches[1] == 'short' then 
 local yon = http.request('http://api.yon.ir/?url='..URL.escape(matches[2])) 
  local jdat = json:decode(yon) 
  local bitly = https.request('https://api-ssl.bitly.com/v3/shorten?access_token=f2d0b4eabb524aaaf22fbc51ca620ae0fa16753d&longUrl='..URL.escape(matches[2])) 
  local data = json:decode(bitly) 
  local yeo = http.request('http://yeo.ir/api.php?url='..URL.escape(matches[2])..'=') 
  local opizo = http.request('http://api.gpmod.ir/shorten/?url='..URL.escape(matches[2])..'&username=mersad565@gmail.com') 
  local u2s = http.request('http://u2s.ir/?api=1&return_text=1&url='..URL.escape(matches[2])) 
  local llink = http.request('http://llink.ir/yourls-api.php?signature=a13360d6d8&action=shorturl&url='..URL.escape(matches[2])..'&format=simple') 
    return ' 🌐لینک اصلی :\n'..data.data.long_url..'\n\nلینکهای کوتاه شده با 6 سایت کوتاه ساز لینک : \n》کوتاه شده با bitly :\n___________________________\n'..data.data.url..'\n___________________________\n》کوتاه شده با yeo :\n'..yeo..'\n___________________________\n》کوتاه شده با اوپیزو :\n'..opizo..'\n___________________________\n》کوتاه شده با u2s :\n'..u2s..'\n___________________________\n》کوتاه شده با llink : \n'..llink..'\n___________________________\n》لینک کوتاه شده با yon : \nyon.ir/'..jdat.output..'\n____________________\n' 
end 
------------------------ 
 local receiver = get_receiver(msg) 
    local group = msg.to.id 
    if msg.reply_id then 
       if msg.to.type == 'document' and redis:get("sticker:photo") then 
        if redis:set("sticker:photo", "waiting") then 
        end 
       end 
      if matches[1]:lower() == "photo" then 
     redis:get("sticker:photo") 
    send_large_msg(receiver, '', ok_cb, false) 
        load_document(msg.reply_id, toimage, msg) 
    end 
end 
------------------------ 
       local receiver = get_receiver(msg) 
    local group = msg.to.id 
    if msg.reply_id then 
       if msg.to.type == 'photo' and redis:get("photo:sticker") then 
        if redis:set("photo:sticker", "waiting") then 
        end 
       end 
      if matches[1]:lower() == "sticker"  then 
     redis:get("photo:sticker") 
    send_large_msg(receiver, '', ok_cb, false) 
        load_photo(msg.reply_id, tosticker, msg) 
    end 
end 
------------------------- 


------------------------- 
local receiver = get_receiver(msg) 
    local group = msg.to.id 
    if msg.reply_id then 
       if msg.to.type == 'video' and redis:get("video:audio") then 
        if redis:set("video:audio", "waiting") then 
        end 
       end 
      if matches[1]:lower() == "audio"  then 
     redis:get("video:audio") 
    send_large_msg(receiver, '', ok_cb, false) 
        load_audio(msg.reply_id, toaudio, msg) 
    end 
end 
----------------------- 

local receiver = get_receiver(msg) 
    local group = msg.to.id 
    if msg.reply_id then 
       if msg.to.type == 'document' and redis:get("gif:video") then 
        if redis:set("gif:video", "waiting") then 
        end 
       end 
      if matches[1]:lower() == "video"  then 
     redis:get("gif:video") 
    send_large_msg(receiver, '', ok_cb, false) 
        load_document(msg.reply_id, tovideo, msg) 
    end 
end 
------------------------ 
local receiver = get_receiver(msg) 
    local group = msg.to.id 
    if msg.reply_id then 
       if msg.to.type == 'video' and redis:get("video:document") then 
        if redis:set("video:document", "waiting") then 
        end 
       end 
      if matches[1]:lower() == "mkv"  then 
     redis:get("video:document") 
    send_large_msg(receiver, '', ok_cb, false) 
        load_video(msg.reply_id, tomkv, msg) 
    end 
end 
------------------------ 
local receiver = get_receiver(msg) 
    local group = msg.to.id 
    if msg.reply_id then 
       if msg.to.type == 'video' and redis:get("video:gif") then 
        if redis:set("video:gif", "waiting") then 
        end 
       end 
      if matches[1]:lower() == "gif"  then 
     redis:get("video:gif") 
    send_large_msg(receiver, '', ok_cb, false) 
        load_video(msg.reply_id, togif, msg) 
    end 
end 
------------------------ 
local receiver = get_receiver(msg) 
    local group = msg.to.id 
    if msg.reply_id then 
       if msg.to.type == 'photo' and redis:get("photo:sticker") then 
        if redis:set("photo:png", "waiting") then 
        end 
       end 
      if matches[1]:lower() == "png"  then 
     redis:get("photo:png") 
    send_large_msg(receiver, '', ok_cb, false) 
        load_photo(msg.reply_id, topng, msg) 
    end 
end 
------------------------ 
if matches[1] == "delplugin" and is_sudo(msg) then 
         if not is_sudo(msg) then 
             return "You Are Not Allow To Delete Plugins!" 
             end 
        io.popen("cd plugins && rm "..matches[2]..".lua") 
        return "Delete plugin by "..msg.from.id.." is successful" 
     end 

     --------------- 
if matches[1] == "laliga" then 
local url , res = http.request('http://botfamapi.zgig.in/bot132412412.php') 
if res ~= 200 then return "No connection" end 
local jdat = json:decode(url) 
local text = jdat.Builder..' \n🇪🇸🇪🇸🇪🇸🇪🇸🇪🇸🇪🇸🇪🇸🇪🇸🇪🇸🇪🇸\n'..jdat.table..'\n'..jdat.team1..'😍امتیاز'..jdat.teams1..'\n'..jdat.team2..'😎امتیاز'..jdat.teams2..'\n'..jdat.team3..'😊امتیاز'..jdat.teams3..'\n'..jdat.team4..'😆امتیاز'..jdat.teams4..'\n'..jdat.team5..'😐امتیاز'..jdat.teams5..'\n'..jdat.team6..'🤔امتیاز'..jdat.teams6..'\n'..jdat.team7..'😕امتیاز'..jdat.teams7..'\n'..jdat.team8..'🙁امتیاز'..jdat.teams8..'\n'..jdat.team9..'☹️امتیاز'..jdat.teams9..'\n'..jdat.team10..'😯امتیاز'..jdat.teams10..'\n'..jdat.team11..'😦امتیاز'..jdat.teams11..'\n'..jdat.team12..'😧امتیاز'..jdat.teams12..'\n'..jdat.team13..'😢امتیاز'..jdat.teams13..'\n'..jdat.team14..'😥امتیاز'..jdat.teams14..'\n'..jdat.team15..'😨امتیاز'..jdat.teams15..'\n'..jdat.team16..'😰امتیاز'..jdat.teams16..'\n'..jdat.team17..'😰امتیاز'..jdat.teams17..'\n'..jdat.team18..'😰امتیاز'..jdat.teams18..'\n'..jdat.team19..'😰امتیاز'..jdat.teams19..'\n'..jdat.team20..'😰امتیاز'..jdat.teams20..'\n' 
  if string.match(text, 'laliga') then text = string.gsub(text, 'laliga', 'لیگ برتر اسپانیا لالیگا') end 
  if string.match(text, '0') then text = string.gsub(text, '0', '۰') end 
  if string.match(text, '1') then text = string.gsub(text, '1', '۱') end 
  if string.match(text, '2') then text = string.gsub(text, '2', '۲') end 
  if string.match(text, '3') then text = string.gsub(text, '3', '۳') end 
  if string.match(text, '4') then text = string.gsub(text, '4', '۴') end 
  if string.match(text, '5') then text = string.gsub(text, '5', '۵') end 
  if string.match(text, '6') then text = string.gsub(text, '6', '۶') end 
  if string.match(text, '7') then text = string.gsub(text, '7', '۷') end 
  if string.match(text, '8') then text = string.gsub(text, '8', '۸') end 
  if string.match(text, '9') then text = string.gsub(text, '9', '۹') end 
  if string.match(text, 'barselona') then text = string.gsub(text, 'barselona', 'بارسلونا ') end 
  if string.match(text, 'realmadrid') then text = string.gsub(text, 'realmadrid', 'رئال مادرید ') end 
  if string.match(text, 'atletikomadrid') then text = string.gsub(text, 'atletikomadrid', 'اتلتیکومادرید ') end 
  if string.match(text, 'viareal') then text = string.gsub(text, 'viareal', 'ویارئال ') end 
  if string.match(text, 'bilbao') then text = string.gsub(text, 'bilbao', 'بیلبائو ') end 
  if string.match(text, 'seltavigo') then text = string.gsub(text, 'seltavigo', 'سلتاویگو ') end 
  if string.match(text, 'sevia') then text = string.gsub(text, 'sevia', 'سویا ') end 
  if string.match(text, 'malaga') then text = string.gsub(text, 'malaga', 'مالاگا ') end 
  if string.match(text, 'realsosi') then text = string.gsub(text, 'realsosi', 'رئال سوسیداد ') end 
  if string.match(text, 'betis') then text = string.gsub(text, 'betis', 'بتیس ') end 
  if string.match(text, 'valensia') then text = string.gsub(text, 'valensia', 'والنسیا ') end 
  if string.match(text, 'laspalmas') then text = string.gsub(text, 'laspalmas', 'لاس پالماس ') end 
  if string.match(text, 'ibar') then text = string.gsub(text, 'ibar', 'ایبار ') end 
  if string.match(text, 'spaniol') then text = string.gsub(text, 'spaniol', 'اسپانیول ') end 
  if string.match(text, 'diportiv') then text = string.gsub(text, 'diportiv', 'دیپورتیوولاکرونیا ') end 
  if string.match(text, 'khikhon') then text = string.gsub(text, 'khikhon', 'خیخون ') end 
  if string.match(text, 'granada') then text = string.gsub(text, 'granada', 'گرانادا ') end 
  if string.match(text, 'rayovayecano') then text = string.gsub(text, 'rayovayecano', 'رایو وایه کانو') end 
  if string.match(text, 'khetafe') then text = string.gsub(text, 'khetafe', 'ختافه') end 
  if string.match(text, 'levante') then text = string.gsub(text, 'levante', 'لوانته') end 
  return text 
  end
--------------------- 
     if matches[1] == "sticker"  then 
local eq = URL.escape(matches[2]) 
local w = "500" 
local h = "500" 
local txtsize = "150" 
local txtclr = "ff2e4357" 
if matches[3] then 
  txtclr = matches[3] 
end 
if matches[4] then 
  txtsize = matches[4] 
  end 
  if matches[5] and matches[6] then 
  w = matches[5] 
  h = matches[6] 
  end 
  local url = "https://assets.imgix.net/examples/clouds.jpg?blur=150&w="..w.."&h="..h.."&fit=crop&txt="..eq.."&txtsize="..txtsize.."&txtclr="..txtclr.."&txtalign=middle,center&txtfont=Futura%20Condensed%20Medium&mono=ff6598cc" 

  local receiver = get_receiver(msg) 
local  file = download_to_file(url,'text.webp') 
 send_document('channel#id'..msg.to.id, file, ok_cb , false) 
end 
-------------------------- 
  if matches[1] == "gif" then 
local text = URL.escape(matches[2]) 
  local url2 = 'http://www.flamingtext.com/net-fu/image_output.cgi?_comBuyRedirect=false&script=blue-fire&text='..text..'&symbol_tagname=popular&fontsize=70&fontname=futura_poster&fontname_tagname=cool&textBorder=15&growSize=0&antialias=on&hinting=on&justify=2&letterSpacing=0&lineSpacing=0&textSlant=0&textVerticalSlant=0&textAngle=0&textOutline=off&textOutline=false&textOutlineSize=2&textColor=%230000CC&angle=0&blueFlame=on&blueFlame=false&framerate=75&frames=5&pframes=5&oframes=4&distance=2&transparent=off&transparent=false&extAnim=gif&animLoop=on&animLoop=false&defaultFrameRate=75&doScale=off&scaleWidth=240&scaleHeight=120&&_=1469943010141' 
  local title , res = http.request(url2) 
  local jdat = json:decode(title) 
  local gif = jdat.src 
     local  file = download_to_file(gif,'t2g.gif') 
   send_document(get_receiver(msg), file, ok_cb, false) 
  end 
--------------------------- 
if matches[1] == "stickerpro" then 
local text1 = "" 
local text2 = matches[2] 
local text3 = matches[3] 
if not matches[2] then 
  text2 = " " 
  end 
if not matches[3] then 
  text3 = " " 
  end 
if not matches[2] and not matches[3] then 
  text2 = " " 
  text3 = " " 
  end 
  text4 = "[pika]" 
  local url = URL.escape(text1.." "..text2.." "..text3) 
  local answers = {'https://assets.imgix.net/examples/clouds.jpg?blur=200&w=1300&h=600&fit=crop&txt=', 
                   'https://assets.imgix.net/examples/redleaf.jpg?blur=200&w=1300&h=600&fit=crop&txt=', 
                   'https://assets.imgix.net/examples/blueberries.jpg?blur=200&w=1300&h=600&fit=crop&txt=', 
                   'https://assets.imgix.net/examples/butterfly.jpg?blur=200&w=1300&h=600&fit=crop&txt=', 
                   'https://assets.imgix.net/examples/espresso.jpg?blur=200&w=1000&h=400&fit=crop&txt=', 
                   'https://assets.imgix.net/unsplash/transport.jpg?blur=200&w=1300&h=600&fit=crop&txt=', 
                   'https://assets.imgix.net/unsplash/coffee.JPG?blur=200&w=1300&h=600&fit=crop&txt=', 
                   'https://assets.imgix.net/unsplash/citystreet.jpg?blur=200&w=1300&h=600&fit=crop&txt=', 
       'http://assets.imgix.net/examples/vista.png?blur=200&w=1300&h=600&fit=crop&txt='} 
local fonts = {'American%20Typewriter%2CBold','Arial%2CBoldItalicMT','Arial%2CBoldMT','Athelas%2CBold', 
               'Baskerville%2CBoldItalic','Charter%2CBoldItalic','DIN%20Alternate%2CBold','Gill%20Sans%2CUltraBold', 
      'PT%20Sans%2CBold','Seravek%2CBoldItalic','Verdana%2CBold','Yuanti%20SC%2CBold','Avenir%20Next%2CBoldItalic', 
      'Lucida%20Grande%2CBold','American%20Typewriter%20Condensed%2CBold','rial%20Rounded%20MT%2CBold','Chalkboard%20SE%2CBold', 
      'Courier%20New%2CBoldItalic','Charter%20Black%2CItalic','American%20Typewriter%20Light'} 
local colors = {'00FF00','6699FF','CC99CC','CC66FF','0066FF','000000','CC0066','FF33CC','FF0000','FFCCCC','FF66CC','33FF00','FFFFFF','00FF00'} 
local f = fonts[math.random(#fonts)] 
local c = colors[math.random(#colors)] 
local url = answers[math.random(#answers)]..url.."&txtsize=120&txtclr="..c.."&txtalign=middle,center&txtfont="..f.."%20Condensed%20Medium&mono=ff6598cc=?markscale=60&markalign=center%2Cdown" 
local randoms = math.random(1000,900000) 
local randomd = randoms..".webp" 
local cb_extra = {file_path=file} 
local receiver = get_receiver(msg) 
local file = download_to_file(url,randomd) 
 send_document(receiver, file, rmtmp_cb, cb_extra) 
end 
-------------------------- 
if matches[1] == "imagepro" then 
local text1 = "" 
local text2 = matches[2] 
local text3 = matches[3] 
if not matches[2] then 
  text2 = " " 
  end 
if not matches[3] then 
  text3 = " " 
  end 
if not matches[2] and not matches[3] then 
  text2 = " " 
  text3 = " " 
  end 
  text4 = "[pika]" 
  local url = URL.escape(text1.." "..text2.." "..text3) 
  local answers = {'https://assets.imgix.net/examples/clouds.jpg?blur=200&w=1300&h=600&fit=crop&txt=', 
                   'https://assets.imgix.net/examples/redleaf.jpg?blur=200&w=1300&h=600&fit=crop&txt=', 
                   'https://assets.imgix.net/examples/blueberries.jpg?blur=200&w=1300&h=600&fit=crop&txt=', 
                   'https://assets.imgix.net/examples/butterfly.jpg?blur=200&w=1300&h=600&fit=crop&txt=', 
                   'https://assets.imgix.net/examples/espresso.jpg?blur=200&w=1000&h=400&fit=crop&txt=', 
                   'https://assets.imgix.net/unsplash/transport.jpg?blur=200&w=1300&h=600&fit=crop&txt=', 
                   'https://assets.imgix.net/unsplash/coffee.JPG?blur=200&w=1300&h=600&fit=crop&txt=', 
                   'https://assets.imgix.net/unsplash/citystreet.jpg?blur=200&w=1300&h=600&fit=crop&txt=', 
       'http://assets.imgix.net/examples/vista.png?blur=200&w=1300&h=600&fit=crop&txt='} 
local fonts = {'American%20Typewriter%2CBold','Arial%2CBoldItalicMT','Arial%2CBoldMT','Athelas%2CBold', 
               'Baskerville%2CBoldItalic','Charter%2CBoldItalic','DIN%20Alternate%2CBold','Gill%20Sans%2CUltraBold', 
      'PT%20Sans%2CBold','Seravek%2CBoldItalic','Verdana%2CBold','Yuanti%20SC%2CBold','Avenir%20Next%2CBoldItalic', 
      'Lucida%20Grande%2CBold','American%20Typewriter%20Condensed%2CBold','rial%20Rounded%20MT%2CBold','Chalkboard%20SE%2CBold', 
      'Courier%20New%2CBoldItalic','Charter%20Black%2CItalic','American%20Typewriter%20Light'} 
local colors = {'00FF00','6699FF','CC99CC','CC66FF','0066FF','000000','CC0066','FF33CC','FF0000','FFCCCC','FF66CC','33FF00','FFFFFF','00FF00'} 
local f = fonts[math.random(#fonts)] 
local c = colors[math.random(#colors)] 
local url = answers[math.random(#answers)]..url.."&txtsize=120&txtclr="..c.."&txtalign=middle,center&txtfont="..f.."%20Condensed%20Medium&mono=ff6598cc=?markscale=60&markalign=center%2Cdown" 
local randoms = math.random(1000,900000) 
local randomd = randoms..".jpg" 
local cb_extra = {file_path=file} 
local receiver = get_receiver(msg) 
local file = download_to_file(url,randomd) 
 send_photo(receiver, file, rmtmp_cb, cb_extra) 
end 
-------------------------- 
if matches[1] == 'keepcalm' then 
local url = "http://weblogg.ir/BeatBot/keepcalm/?FasTReaCtoR=t=%EE%BB%AA%0D%0AKEEP%0D%0ACALM%0D%0A" 
if matches[2] then 
url = url..URL.escape(matches[2]) 
end 
if matches[3] then 
url = url.."%0D%0A"..URL.escape(matches[3]) 
end 
if matches[4] then 
url = url.."%0D%0A"..URL.escape(matches[4]) 
end 
if msg.text then 
if msg.text:match('red') then 
url = url.."&bc=E31F17" 
end 
if msg.text:match('blue') then 
url = url.."&bc=0000ff" 
end 
if msg.text:match('yellow') then 
url = url.."&bc=ffff00" 
end 
if msg.text:match('green') then 
url = url.."&bc=00ff00" 
end 
if msg.text:match('black') then 
url = url.."&bc=000000" 
end 
if msg.text:match('pink') then 
url = url.."&bc=ff00ff" 
end 
end 
local url =  url.."&tc=FFFFFF&cc=FFFFFF&uc=true&ts=true&ff=PNG&w=500&ps=sq" 
  local  file = download_to_file(url,'keep.webp') 
    send_document(get_receiver(msg), file, ok_cb, false) 
end 

--------------------- 
if matches[1] == 'love' then 
local text1 = matches[1] 
local text2 = matches[2] 
local url = "http://www.iloveheartstudio.com/-/p.php?t="..text1.."%20%EE%BB%AE%20"..text2.."&bc=FFFFFF&tc=000000&hc=ff0000&f=c&uc=true&ts=true&ff=PNG&w=500&ps=sq" 
       local  file = download_to_file(url,'love.webp') 
         send_document(get_receiver(msg), file, ok_cb, false) 
end 
-------------------- 
if matches[1] == "get" then 
    local file = matches[2] 
    if is_sudo(msg) or is_vip(msg) then 
      local receiver = get_receiver(msg) 
      send_document(receiver, "./plugins/"..file..".lua", ok_cb, false) 
    end 
  end 
-------------------- 

 if matches[1] == "note" and matches[2] then 
 local text = matches[2] 
   local b = 1 
  while b ~= 0 do 
    text = text:trim() 
    text,b = text:gsub('^!+','') 
  end 
  local file = io.open("./system/adv/note/"..msg.from.id..".txt", "w") 
  file:write(text) 
  file:flush() 
  file:close() 
  return "You can use it:\n!mynote\n\nYour note has been changed to:\n"..text 
 end 
if matches[1] == "mynote" then 
local note = io.open("./system/adv/note/"..msg.from.id..".txt", "r") 
   local mn = note:read("*all") 
   if matches[1] == "mynote" then 
      return mn 
    else 
     return "You havent any note." 
  end 
end 
-------------------- 

------------------- 

------------------- 

if matches[1] == 'broadcast' then 
      if is_sudo(msg) then -- Only sudo ! 
         local data = load_data(_config.moderation.data) 
         local groups = 'groups' 
         local response = matches[2] 
         for k,v in pairs(data[tostring(groups)]) do 
            chat_id =  v 
            local chat = 'chat#id'..chat_id 
            local channel = 'channel#id'..chat_id 
            send_large_msg(chat, response) 
            send_large_msg(channel, response) 
            end 
      end 
   end 

-------------------- 
if matches[1]:lower() == 'app' then 
      local url = http.request('http://api.magic-team.ir/plazza/search.php?key='..URL.escape(matches[2])) 
      local jdat = json:decode(url) 
      items = jdat 
      local text = '' 
      local msgss = 0 
      for item in pairs(items) do 
      msgss = msgss + 1 
      text = text..msgss..' 📦 عنوان: '..items[msgss].title..' 🔰   Package Id: '..items[msgss].pack..'\n\n' 
    local hash = 'app:'..msg.from.id..msgss 
   local hash1 = 'img:'..msg.from.id..msgss 
  redis:set(hash, items[msgss].pack) 
  redis:set(hash1, items[msgss].icon) 
      end 
      return text..'برای دریافت اطلاعات برنامه از دستور زیر استفاده کنید\n/appinfo number\n(example): /appinfo 1' 
   end 
   if matches[1]:lower() == 'appinfo' then 
   local hash = 'app:'..msg.from.id..matches[2] 
   local hash1 = 'img:'..msg.from.id..matches[2] 
   pp = redis:get(hash) 
   pp1 = redis:get(hash1) 
   local url = http.request('http://api.magic-team.ir/plazza/info.php?key='..pp) 
      local jdat = json:decode(url) 
      if jdat.needroot == "false" then 
      root = 'خیر' 
      else 
      root = 'بله' 
      end 
      ple = math.floor(jdat.dlsize / 1024) 
      text = 'عنوان: \n'..jdat.title..'\nنام پکیج :\n'..pp..'\nدرباره: \n'..jdat.info..'\nورژن: \n'..jdat.version..'\nنیاز به روت : '..root..'\nسایز : '..ple..'\n تصویر : '..pp1..'\nلینک دانلود : '..jdat.dlurl 
      return text 
   end 
-------------------- 
if matches[1] == "news"  then 
local url = http.request('http://api.avirateam.ir/irna/cli/index.php?pass=dN@-Sy1k$mKB2PgWoj)7/9vbDL0VCpfA') 
  return url 
end 
-------------------- 
if matches[1] == "mobile"  then 
local pass = 'dram1135' 
local url = 'http://api.avirateam.ir/mobile/cli/index.php?pass='..pass 
  local req = http.request(url) 
  return req..' @specialteam_ch' 
end 
-------------------- 
if matches[1] == "alexa"  then 
local url = http.request('http://api.tarfandbazar.ir/alexa.php?url='..matches[2]..'') 
  local photo = 'http://api.tarfandbazar.ir/alexaphoto.php?url='..matches[2] 
  return url.."\n\n"..photo 
    end 
-------------------- 
if matches[1] == 'about' and matches[2] and is_admin1(msg) then 
local data = load_data(_config.moderation.data) 
      local group_link = data[tostring(matches[2])]['settings']['set_link'] 
       if not group_link then 
      return 'Group ('..matches[2]..') Not Found!' 
       end 
        local group_owner = data[tostring(matches[2])]['set_owner'] 
       if not group_owner then 
         return 
       end 
   local group_type = data[tostring(matches[2])]['group_type'] 
   if not group_type then 
  return 
end 
       local lock_link = data[tostring(matches[2])]['settings']['lock_link'] 
   if not lock_link then 
  return 
end 
   local lock_fwd = data[tostring(matches[2])]['settings']['lock_fwd'] 
   if not lock_fwd then 
  return 
end 
    local lock_arabic = data[tostring(matches[2])]['settings']['lock_arabic'] 
   if not lock_arabic then 
  return 
end 
local lock_rtl = data[tostring(matches[2])]['settings']['lock_rtl'] 
   if not lock_rtl then 
  return 
end 
local lock_tgservice = data[tostring(matches[2])]['settings']['lock_tgservice'] 
   if not lock_tgservice then 
  return 
end 
local lock_porn = data[tostring(matches[2])]['settings']['lock_porn'] 
   if not lock_porn then 
  return 
end 
local lock_reply = data[tostring(matches[2])]['settings']['lock_reply'] 
   if not lock_reply then 
  return 
end 
local lock_sticker = data[tostring(matches[2])]['settings']['lock_sticker'] 
   if not lock_sticker then 
  return 
end 
local lock_contacts = data[tostring(matches[2])]['settings']['lock_contacts'] 
   if not lock_contacts then 
  return 
end 
local lock_member = data[tostring(matches[2])]['settings']['lock_member'] 
   if not lock_member then 
  return 
end 
local lock_tag = data[tostring(matches[2])]['settings']['lock_tag'] 
   if not lock_tag then 
  return 
end 
local lock_username = data[tostring(matches[2])]['settings']['lock_username'] 
   if not lock_username then 
  return 
end 
local lock_flood = data[tostring(matches[2])]['settings']['flood'] 
   if not lock_flood then 
  return 
end 
local NUM_MSG_MAX = data[tostring(matches[2])]['settings']['flood_msg_max'] 
   if not NUM_MSG_MAX then 
  return 
end 
local lock_spam = data[tostring(matches[2])]['settings']['lock_spam'] 
   if not lock_spam then 
  return 
end 
local adminslist = '' 
for k,v in pairs(data[tostring(matches[2])]['moderators']) do 
  adminslist = adminslist .. '> @'.. v ..' ('..k..')\n' 
end 
      local text = "Group Id: "..matches[2].."\nGroup Name: "..msg.to.title.."\nGroup Owner: "..group_owner.."\nGroup Type: "..group_type.."\nGroup Link: "..group_link.."\nGroup Moderators:\n "..adminslist.."\nGroup Settings:\n================\nLock links: "..lock_link.."\nLock fwd: "..lock_fwd.."\nLock Arabic: "..lock_arabic.."\nLock rtl: "..lock_rtl.."\nLock tgservice: "..lock_tgservice.."\nLock Porn: "..lock_porn.."\nLock Reply: "..lock_reply.."\nLock Sticker: "..lock_sticker.."\nLock contact: "..lock_contacts.."\nLock Member: "..lock_member.."\nLock tag: "..lock_tag.."\nLock UserName: "..lock_username.."\nLock Flood: "..lock_flood.."\nFlood sensitivity: "..NUM_MSG_MAX.."\nLock Spam: "..lock_spam 
return text 
end 
-------------------- 
if matches[1] == "earz"  then 
local url = 'http://exchange.nalbandan.com/api.php?action=json' 
  local jstr, res = http.request(url) 
  local arz = json:decode(jstr) 
  local text = 'مبلغ مورد نظر شما : '..matches[2]..' هزار تومان است که ' 

 text = text..'\nمعادل '..arz.dollar.value * matches[2]..' دلار' 
 text = text..'\nمعادل '..arz.dollar_rasmi.value * matches[2]..' دلار رسمی' 
 text = text..'\nمعادل '..arz.euro.value * matches[2]..' یورو' 
 text = text..'\nمعادل '..arz.derham.value * matches[2]..' درهم' 
 text = text..'\nمعادل '..arz.pond.value * matches[2]..' پوند میباشد' 

return text 
end 
-------------------- 
if matches[1]:lower() == 'del' then 
      if not is_sudo(msg) then 
        return "شما سودو نیستید!" 
      end 
if matches[2] == 'gbanlist' then 
local hash = 'gbanned' 
send_large_msg(get_receiver(msg), "لیست سوپر بن پاک شد.") 
redis:del(hash) 
     end 
     end 
---------------------- 
if matches[1] == "rev"  then 
local rev =  string.reverse(matches[1])
       return "Reverse:\n"..rev
end
---------------------
if matches[1] == "let"  then 
local let = string.len(matches[1])
       return "Letters:\n"..let
end
------------------

if matches[1]:lower() == 'aparat' then
		local url = http.request('http://www.aparat.com/etc/api/videoBySearch/text/'..URL.escape(matches[2]))
		local jdat = json:decode(url)

		local items = jdat.videobysearch
		text = 'نتیجه جستوجو در آپارات: \n'
		for i = 1, #items do
		text = text..'\n'..i..'- '..items[i].title..'  -  تعداد بازدید: '..items[i].visit_cnt..'\n    لینک: aparat.com/v/'..items[i].uid
		end
		text = text..'\n\n😃'
		return text
	end
--------------------
if matches[1]:lower() == 'joke' then
local database = 'http://vip.opload.ir/vipdl/94/11/amirhmz/'
	local res = http.request(database.."joke.db")
	local joke = res:split(",") 
	return joke[math.random(#joke)]
end
--------------
if matches[1] == "photo"  then 
local eq = URL.escape(matches[2]) 
local w = "500" 
local h = "500" 
local txtsize = "150" 
local txtclr = "ff2e4357" 
if matches[3] then 
  txtclr = matches[3] 
end 
if matches[4] then 
  txtsize = matches[4] 
  end 
  if matches[5] and matches[6] then 
  w = matches[5] 
  h = matches[6] 
  end 
  local url = "https://assets.imgix.net/examples/clouds.jpg?blur=150&w="..w.."&h="..h.."&fit=crop&txt="..eq.."&txtsize="..txtsize.."&txtclr="..txtclr.."&txtalign=middle,center&txtfont=Futura%20Condensed%20Medium&mono=ff6598cc" 

  local receiver = get_receiver(msg) 
local  file = download_to_file(url,'text.jpg') 
 send_photo('channel#id'..msg.to.id, file, ok_cb , false) 
end 
end 
end 
return { 
patterns = { 
   "^[!/#]([Mm][Oo][Bb][Ii][Ll][Ee])$", 
   "^[/#!]joke$",
   "^[/!](aparat) (.*)$",
  -- "^(laliga)$", 
    "[/!#]rev (.*)",
    "[/!#]let (.*)",
   "[!/#]([Dd]el) (.*)$", 
   '^[#!/]([Aa]bout) (.*)$', 
   "^[/#!](earz) (%d+)$", 
   "^[/#!]alexa (.*)$", 
   "^[!/#]([Nn][Ee][Ww][Ss])$", 
   "^[/!](app) (.*)$", 
   "^[/!](appinfo) (.*)$", 
   "^[#!/](broadcast) +(.+)$", 
   --"^[!/#]([Ff]ile) (.*) (.*)$", 
   "^[!/#](get) (.*)$", 
   "^[#!/]([Aa]ddplugin) (.+) (.*)$", 
   "^[#!/]([Dd]l) ([Pp]lugin) (.*)$", 
   "^[!#/]([rR]msg) (%d*)$", 
   "^[!#/]([Dd]elplugin) (.*)$", 
   "^[!/#](weather) (.*)$", 
   "^[#!/](calc) (.*)$", 
   "^[#!/](time)$", 
  -- "^[#!/](info)$", 
  -- "^[#!/](me)$", 
   "^[!/#](voice) +(.*)$", 
   "^[!#/]([Tt]r) ([^%s]+) (.*)$", 
   "^[!/#]([Mm]ean) (.*)$", 
   "^[!#/]([Ss]hort) (.*)$", 
   "^[#!/]([Ss]ticker)$", 
   "^[#!/](photo)$", 
   "^[#!/](gif)$", 
   "^[#!/](video)$", 
   "^[#!/](mkv)$", 
   "^[#!/](audio)$", 
   "^[#!/](love) (.+) (.+)$", 
   "^[#!/](gif) (.*)$", 
   "^[#!/](stickerpro) (.+)$", 
   "^[!#/]([Nn]ote) (.*)$", 
   "^[!#/]([Mm]ynote)$", 
"^[#!/](stickerpro) (.+) (.+)$", 
"^[#!/](stickerpro) (.+) (.+) (.+)$", 
"^[#!/](stickerpro) (.+) (.+) (.+) (.+)$", 

"^[#!/](imagepro) (.+)$", 

'^[#/!](keepcalm) "(.*)" "(.*)" "(.*)" black$', 
 '^[#/!](keepcalm) "(.*)" "(.*)" "(.*)" green$', 
 '^[#/!](keepcalm) "(.*)" "(.*)" "(.*)" red$', 
 '^[#/!](keepcalm) "(.*)" "(.*)" "(.*)" blue$', 
 '^[#/!](keepcalm) "(.*)" "(.*)" "(.*)" pink$', 
 '^[#/!](keepcalm) "(.*)" "(.*)" "(.*)" yellow$', 
'^[#/!](keepcalm) "(.*)" "(.*)" black$', 
 '^[#/!](keepcalm) "(.*)" "(.*)" red$', 
 '^[#/!](keepcalm) "(.*)" "(.*)" blue$', 
 '^[#/!](keepcalm) "(.*)" "(.*)" pink$', 
 '^[#/!](keepcalm) "(.*)" "(.*)" yellow$', 
'^[#/!](keepcalm) "(.*)" green$', 
'^[#/!](keepcalm) "(.*)" black$', 
 '^[#/!](keepcalm) "(.*)" red$', 
 '^[#/!](keepcalm) "(.*)" blue$', 
 '^[#/!](keepcalm) "(.*)" pink$', 
 '^[#/!](keepcalm) "(.*)" yellow$', 
 '^[#/!](keepcalm) "(.*)" "(.*)" "(.*)"$', 
 '^[#/!](keepcalm) "(.*)" "(.*)"$', 
'^[#/!](keepcalm) "(.*)"$', 
"^[#!/](imagepro) (.+) (.+)$", 
"^[#!/](imagepro) (.+) (.+) (.+)$", 
"^[#!/](imagepro) (.+) (.+) (.+) (.+)$", 
"^[#!/](png)$", 
  "^([Pp]hoto)$", 
   "^([Ss]ticker)$", 
"^([Ss]ticker) (.*)$", 
"^([Pp]hoto) (.*)$", 
   "%[(document)%]", 
   "%[(photo)%]", 
"%[(video)%]", 
   "%[(audio)%]", 
 }, 
run = run, 
} 

-- beyond programing team (core)
-- کپی بدون ذکر منبع راضی نیستم چون پنج ساعت طول کشید ادیت کردم

-- @beyondteam
-- باز نویسی توسط @sudo1