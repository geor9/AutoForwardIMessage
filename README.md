AutoForwardIMessage
===================

A very simple AppleScript to help those who have to juggle between Android and iPhone...
- Forwards incoming and outgoing iMessage texts to any account of choice

To install
==========
- Register the script with "Message Received" event - refer to https://46b.it/2012/hacking-with-imessage

Note
====
- Supports two-way iMessage forwarding.
- Only works if Messages app is both (1) running and (2) out of focus.
 - This script relies on "Message Received" event to fire. It seems that this event may not fire (and hence forwarding won't work) if:
  - (1) Messages app currently has focus, and
  - (2) if you receive messages on active chat.
 - Perhaps the fix is to listen for "Message Received in Active Chat" event too?
- Only supports one-to-one text iMessages. Group messsages, pictures, movies don't work.
 - Active discussion on iMessage attachments at https://discussions.apple.com/thread/5214769
- Presumably, not all iOS emoji will work either.
 - I personally use a secondary Google Talk account for forwarding.
 - Google Hangout Android app seems to support iPhone emoji, which plays nicely as well.
