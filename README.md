AutoForwardIMessage
===================

A very simple AppleScript to help those who have to juggle between Android and iPhone...
- Forwards incoming and outgoing iMessage texts to any account of choice

To install
==========
- OS X 10.8: Register the script with "Message Received" event - refer to https://46b.it/2012/hacking-with-imessage
- OS X 10.9: Unfortunately, Messages no longer allows binding scripts to events. It's a one-script-fits-all solution now, selected in the "General" tab of Message's preferences. (Refer to https://github.com/yongjunj/AutoForwardIMessage/pull/1). 
- This means if you have an existing script or want to use multiple scripts in the future, you'll want to write a macro "loader" script that loads them all in via "run" (see http://macscripter.net/viewtopic.php?id=25529)

Note
====
- Supports two-way iMessage forwarding, tested on OS X 10.11.
- Only works if Messages app is both (1) running and (2) out of focus.
 - This script relies on "Message Received" event to fire. It seems that this event may not fire (and hence forwarding won't work) if:
  - (1) Messages app currently has focus, and 
  - (2) you receive messages on currently active chat.
 - Perhaps the fix is to listen for "Message Received in Active Chat" event too?
- Only supports one-to-one text iMessages. Group messsages, pictures, movies don't work.
 - Active discussion on iMessage attachments at https://discussions.apple.com/thread/5214769
- Presumably, not all iOS emoji will work either.
 - I personally use a secondary Google Talk account for forwarding.
 - Google Hangout Android app seems to support iPhone emoji, which plays nicely as well.
