########################################################
#Script_in ccs12/ArapinisMRRGRB12
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
Dear Dr. Arapinis,

IQUOTEve been looking at your CCSQUOTE12 paper
   New privacy issues in mobile telephony: fix and verification
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
-subject "Your CCS'12 paper" -cc 'l.mancini@cs.bham.ac.uk,e.ritter@cs.bham.ac.uk,m.d.ryan@cs.bham.ac.uk,nico@sec.t-labs.tu-berlin.de,kredon@sec.t-labs.tu-berlin.de,ravii@sec.t-labs.tu-berlin.de' \
'm.d.arapinis@cs.bham.ac.uk'
echo "EXIT_CODE $?"
########################################################