#!/usr/bin/awk -f
BEGIN {
        server = "/inet/tcp/0/127.0.0.1/400"
        quit = "no"


        print "<xcatrequest>" |& server
        print "   <command>getcredentials</command>" |& server
        print "   <callback_port>300</callback_port>" |& server
        print "   <arg>"ARGV[1]"</arg>" |& server
        print "</xcatrequest>" |& server

        while (server |& getline) {
                print $0
                if (match($0,"<serverdone>")) {
                  quit = "yes"
                }
                if (match($0,"</xcatresponse>") && match(quit,"yes")) {
                  close(server)
                  exit
               }
        }
}
