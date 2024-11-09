ip addr | grep 'inet' | grep -vE '127/.0/.0/.1|::1' | awk {'print $2}' | cut -d'/' -f1 | grep '^10\.0\.17.'
 

