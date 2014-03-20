########################################################
#Script_in vldb12_new/WangHLWZS12
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
Dear Dr. Wang,

IQUOTEve been looking at your VLDBQUOTE12 paper
   Accelerating Pathology Image Data Cross-Comparison
   on CPU-GPU Hybrid Systems
and would like to try out the implementation. However,
I havenQUOTEt been able to find it online. Would you please
let me know how I can obtain the source code so that I
can try to build and run it?

Thank you very much for your help!

Christian Collberg
ccollberg@gmail.com
Department of Computer Science
University of Arizona
ENDHEREDOC
)"

MESSAGE="`echo "$MESSAGE" | sed s/QUOTE/\'/g`"

echo "$MESSAGE" | \
$1 -V -tls -smtp-auth login -smtp-server smtp.gmail.com \
-smtp-port 587 -c ~/bin/email.conf -smtp-user ccollberg@gmail.com -smtp-pass \
$EMAILPASSWORD -from-addr ccollberg@gmail.com -from-name "Christian Collberg" \
-subject "Your VLDB'12 paper" -cc 'huai@cse.ohio-state.edu,liru@cse.ohio-state.edu,zhang@cse.ohio-state.edu,fusheng.wang@emory.edu,jhsaltz@emory.edu' \
'wangka@cse.ohio-state.edu'
echo "EXIT_CODE $?"
########################################################