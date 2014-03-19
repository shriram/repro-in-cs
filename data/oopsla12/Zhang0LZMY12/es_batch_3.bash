########################################################
#Script_in oopsla12/Zhang0LZMY12
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
Dear Dr. Zhang,

IQUOTEve been looking at your OOPSLAQUOTE12 paper
   Refactoring android Java code for on-demand computation
   offloading
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
-subject "Your OOPSLA'12 paper" -cc 'hg@pku.edu.cn,liuxzh@sei.pku.edu.cn,zhangwei11@sei.pku.edu.cn,yangsx07@sei.pku.edu.cn,meih@pku.edu.cn' \
'zhangying06@sei.pku.edu.cn'
echo "EXIT_CODE $?"
########################################################