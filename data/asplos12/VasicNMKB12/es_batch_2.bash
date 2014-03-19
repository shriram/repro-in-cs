########################################################
#Script_in asplos12/VasicNMKB12
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
Dear Dr. Vasic,

IQUOTEve been looking at your ASPLOSQUOTE12 paper
   DejaVu: accelerating resource allocation in virtualized
   environments
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
-subject "Your ASPLOS'12 paper" -cc 'Dejan.Novakovic@epfl.ch,Svetozar.Miucin@epfl.ch,Dejan.Kostic@epfl.ch,ricardob@cs.rutgers.edu' \
'Nedeljko.Vasic@epfl.ch'
echo "EXIT_CODE $?"
########################################################