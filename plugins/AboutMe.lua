
do

local function run(msg, matches)
  if matches[1] == 'bot' then
    if is_sudo(msg) then
    send_document(get_receiver(msg), "./data/me/version.webp", ok_cb, false)
      return "Security Bot\n---------------------------------------------\n|An Advanced Bot Based On Lua|\n\n> Bot Number : +6288973825734\n---------------------------------------------\n#Developers [ @MutePuker | @MohammadDeveloper ]\n#Report [ @MutePukerBot | @MohammadDeveloperBot ]\n---------------------------------------------\n#Channel : @MuteTeam"
    elseif is_admin1(msg) then
    send_document(get_receiver(msg), "./data/me/admin.webp", ok_cb, false)
      return "You're Admin"
    elseif is_owner(msg) then
    send_document(get_receiver(msg), "./data/me/owner.webp", ok_cb, false)
      return "You're Owner"
    elseif is_momod(msg) then
    send_document(get_receiver(msg), "./data/me/mod.webp", ok_cb, false)
      return "You're Moderator"
    else
    send_document(get_receiver(msg), "./data/me/mmbr.webp", ok_cb, false)
      return "You're Just member :("
    end
  end
end

return {
  patterns = {
    "^[#!/]([Bb]ot)$",
    "^([Bb]ot)$"
    },
  run = run
}
end