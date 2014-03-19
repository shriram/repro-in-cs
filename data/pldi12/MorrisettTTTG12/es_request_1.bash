########################################################
#Script_in pldi12/MorrisettTTTG12
verified=true
sent=true

if [[ "$verified" != "true" ]]; then
  echo "Email not sent because was not verified"
  exit 1
fi
if [[ "$sent" != "false" ]]; then
  echo "Email not sent because \"already sent\" parameter is not set to false"
  exit 1
fi

MESSAGE="$(cat <<\ENDHEREDOC
Hi!

Hope you are doing well! I was looking at your PLDIQUOTE12 paper
   RockSalt: better, faster, stronger SFI for the x86
and IQUOTEm interested in trying out the implementation. I looked
around but wasnQUOTEt able to find it online. Could you
let me know where I can find the source code so that I can
try to build and run it?

Thanks!

Christian
ENDHEREDOC
)"

MESSAGE="`echo "$MESSAGE" | sed s/QUOTE/\'/g`"

echo "$MESSAGE" | \
$1 -V -tls -smtp-auth login -smtp-server smtp.gmail.com \
-smtp-port 587 -c ~/bin/email.conf -smtp-user ccollberg@gmail.com -smtp-pass \
$EMAILPASSWORD -from-addr ccollberg@gmail.com -from-name "Christian Collberg" \
-subject "Your PLDI'12 paper" -cc 'gtan@cse.lehigh.edu,tassarotti@college.harvard.edu,tristan@seas.harvard.edu,egan@college.harvard.edu' \
'greg@eecs.harvard.edu'
echo "EXIT_CODE $?"
########################################################
