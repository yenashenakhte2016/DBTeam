
do

local function run(msg, matches)
  if matches[1] == 'plist' or 'planlist' then
    send_document(get_receiver(msg), "/root/blackplus/data/me/payment.webp", ok_cb, false)
      return "خرید گروه با ربات پیشرفته محافظ🔥\n\nهزینه ها به صورت ماهیانه میباشد و باید ماهیانه پرداخت شوند\n\n💰ماهیانه: 5 هزار تومان💰\n\n📞برای خرید به @MutePuker و یا @MohammadDeveloper پیام دهید\nاگر ریپورت هستید به آیدی @MohammadDeveloperBot مراجعه کنید"
end
end
return {
  patterns = {
    "^[#!/]([Pp]list)$",
	"^[#!/]([Pp]lanlist)$",
    "^([Pp]list)$",
	"^([Pp]lanlist)$",

    },
  run = run
}
end
