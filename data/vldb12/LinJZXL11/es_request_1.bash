########################################################
#Script_in vldb12/LinJZXL11
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
Dear Dr. Lin,

IQUOTEve been looking at your VLDBQUOTE11 paper
   A Moving-Object Index for Efficient Query Processing
   with Peer-Wise Location Privacy
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
-subject "Your VLDB'11 paper" -cc 'csj@cs.aau.dk,rui@csse.unimelb.edu.au,lx787@mail.mst.edu,jiahenglu@ruc.edu.cn' \
'lindan@mst.edu'
echo "EXIT_CODE $?"
########################################################