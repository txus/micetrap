#micetrap
            ___
        _.-|   |          |\__/,|   (`\
       {   |   |          |o o  |__ _) )
        "-.|___|        _.( T   )  `  /
         .--'-`-.     _((_ `^--' /_<  \
       .+|______|__.-||__)`-'(((/  (((/

Catch hackers on the fly with micetrap!

Micetrap opens a server on either a given or random port, emulating fake
vulnerable services. Port scanners such as Nmap, when fingerprinting ports
to discover service names and versions, will get apparently legitimate
responses from common services such as FTP, HTTP or MySQL servers,
therefore misleading potential attackers with false information.

Depending on the operating system you are using, micetrap will try its best
to +look feasible+ by choosing the appropriate fake services and versions
to emulate. Whenever possible, micetrap will provide a bit outdated versions
which are more likely to be vulnerable, and thus making the attacker focus
on those ports. While the attacker tries to exploit these ports, she is
essentially sending certain packets -- which get properly captured and
logged my micetrap. This information might be useful to discover what kind
of attacks are being tried against your machine, therefore giving you time
and the opportunity to defend appropriately.

Running micetrap with sudo will allow it to use default, unsuspicious ports,
which may give you advantage at tricking a smart attacker.

Micetrap is currently under intensive development, and hopefully a first
version will be soon available.

##Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add specs for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  If you want to have your own version, that is fine but bump version
  in a commit by itself I can ignore when I pull.
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2011 Josep M. Bach. See LICENSE for details.
