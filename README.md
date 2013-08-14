AutoForwardIMessage
===================

A very simple AppleScript to help those who have to juggle between Android and iPhone...
- Forwards incoming and outgoing iMessage texts to any account of choice

To install
==========
- Register the script as in https://46b.it/2012/hacking-with-imessage

Note
====
- Supports two-way iMessage forwarding.
- Only works if Messages app is running.
- Only supports text iMessages. Pictures, movies won't work. Presumably, not all iOS emoji will work either.
- This script relies on "Message Received" event to fire. It seems that this event may not fire (and hence forwarding won't work) if:
 - Messages app currently has focus, and
 - if you receive messages on active chat.
