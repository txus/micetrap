#micetrap
            ___
        _.-|   |          |\__/,|   (`\
       {   |   |          |o o  |__ _) )
        "-.|___|        _.( T   )  `  /
         .--'-`-.     _((_ `^--' /_<  \
       .+|______|__.-||__)`-'(((/  (((/

Catch hackers on the fly with *micetrap*!

Micetrap opens a server on either a given or random port, emulating fake
vulnerable services. Port scanners such as Nmap, when fingerprinting ports
to discover service names and versions, will get apparently legitimate
responses from common services such as FTP, HTTP or MySQL servers,
therefore misleading potential attackers with false information.

Depending on the operating system you are using, micetrap will try its best
to _look feasible_ by choosing the appropriate fake services and versions
to emulate. Whenever possible, micetrap will provide a bit outdated versions
which are more likely to be vulnerable, and thus making the attacker focus
on those ports. While the attacker tries to exploit these ports, she is
essentially sending certain packets -- which get properly captured and
logged by micetrap. This information might be useful to discover what kind
of attacks are being tried against your machine, therefore giving you time
and the opportunity to defend appropriately.

Running micetrap with sudo will allow it to use default, unsuspicious ports,
which may give you advantage at tricking a smart attacker.

##Install

    gem install micetrap

...or, if you want to be able to use it with sudo:

    sudo gem install micetrap

Micetrap currently runs on Ruby versions 1.8.7 and 1.9.2.

##Usage

Just fire up the server with some fake service, such an ftp server:

    micetrap ftp --port 8765

If everything is ok, you will see something like this:

    (some timestamp) ::: Ftp trap listening on ::ffff:0.0.0.0:8765 :::

TL;DR: Most port scanners such as *nmap* have some kind of fingerprinting
capabilities. This means that, in order to discover which services and
versions run behind a specific port, they send special packets or _probes_
which make different services and versions react differently. By capturing
the response and matching against with a database, most of the time they
can reliably determine what service and version is running behind that port.

Port scanners usually start by sending a blank probe, since many servers
respond with a welcome banner telling interesting stuff about them. Micetrap
only responds to those early blank probes. Let's try to port-scan this fake
ftp service with nmap fingerprinting:

    nmap 127.0.0.1 -p 8765 -A

We are scanning localhost, port 8765, and -A means service version detection
and OS guessing. After a while, in our micetrap server terminal we see:

    (timestamp) Recorded a probe coming from ::ffff:127.0.0.1:51082 containing
    the following: (empty line)

    (timestamp) ::: Responded misleadingly: let's drive those hackers nuts! :::

These gets logged inside a .log file within the current directory.
And in the nmap terminal:

    Starting Nmap 5.35DC1 ( http://nmap.org ) at (timestamp)
    Nmap scan report for localhost (127.0.0.1)
    Host is up (0.00017s latency).
    PORT     STATE SERVICE VERSION
    8765/tcp open  ftp     Mac OS X Server ftpd

The faked service/version is random (you can start an ftp server which looks
like lukemftpd, Mac OS X server ftpd or PureFTPd for example), but it is
consistent within the same server, so that every scan reports the same service
and version.

## U mad? Evil hackers

Probably.

##Available services

For now there are a bunch of ftp, http, torrent, mysql and samba services,
mostly Mac-ish.

##Contribute!

If you want to contribute with more services and versions to empower micetrap
and be a superhero, you shall follow these steps:

* Fork the project.
* Install _nmap_ and look for a file called nmap-service-probes in your system.
  This file contains regexes used to match responses from scanned services.
* You only have to devise a string which fits in one of this regexes and then
  add it in the corresponding service file (in lib/micetrap/services/ftp.rb for
  example if it's an ftp server).
* Commit, do not mess with rakefile, version, or history.
  If you want to have your own version, that is fine but bump version
  in a commit by itself I can ignore when I pull.
* Send me a pull request. Bonus points for topic branches.
* Profit!

## Copyright

Copyright (c) 2011 Josep M. Bach. See LICENSE for details.
