########################################################
#Script_in vldb12_new/LuSCO12
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
Dear Dr. Lu,

IQUOTEve been looking at your VLDBQUOTE12 paper
   Efficient Processing of k Nearest Neighbor Joins using
   MapReduce
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
-subject "Your VLDB'12 paper" -cc 'shenyanyan@comp.nus.edu.sg,chensu@comp.nus.edu.sg,ooibc@comp.nus.edu.sg' \
'luwei1@comp.nus.edu.sg'
echo "EXIT_CODE $?"
########################################################