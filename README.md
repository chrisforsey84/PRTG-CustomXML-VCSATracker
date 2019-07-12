# PRTG-CustomXML-VCSATracker
Custom PRTG Sensor to track the location of a VCSA VM. Useful if it goes down and you need to know the host it's on. Set a notification email up for changes so you have this info sent to you every time it vmotions.

add the parameters and amend to fit your environment

-vcentre %name -username "%windowsdomain\%windowsuser" -password "%windowspassword" -VMName %host

-vcentre will need to be FQDN
-VMName is whatever it's called in VCenter
