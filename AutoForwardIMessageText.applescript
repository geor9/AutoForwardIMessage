# AutoForwardIMessageText.applescript
# - Supports 2-way relaying of iMessage to/from another chat service
# - To send iMessage, each outgoing iMessage must be formatted as: "[iMessage destination] Message"

# References
# https://discussions.apple.com/thread/5214769?start=0&tstart=0
# https://46b.it/2012/hacking-with-imessage

# You can enumerate all your chat accounts on Messages like this:
(*
tell application "Messages"
get name of every service
end tell
*)
# Example result: {"Bonjour", "Facebook Chat", "AIM", "E:you@me.com"}

# What's your iMessage/iCloud/Apple ID? Note the format
property myIMsgService : "E:myIMessage@me.com"

# Remember the iMessage that just came in
property recvService : ""
property recvText : ""
property recvBuddy : ""

# Account to use for forwarding
property fwdService : "Fowarding Chat Acct"
# The buddy to receive the forwarded message - presumably your primary chat acct
property fwdServiceBuddy : "myPrimary@gmail.com"

# What ultimately gets forwarded
property fwdMsg : ""

# Event handler
using terms from application "Messages"
	on message received theText from theBuddy for theChat
		# get what we need
		set recvService to name of service of theChat
		set recvText to theText
		set recvBuddy to name of theBuddy as text
		
		# fwd
		if recvText ­ "" then
			try
				if recvService = myIMsgService then # incoming iMessage
					# recvBuddyId is ABCDEFGH-IJKL-MNOP-QRST-UVWXYZABCDEF:+17894560123
					set recvBuddyId to id of theBuddy as text
					set oldDelims to AppleScript's text item delimiters
					set AppleScript's text item delimiters to {":"}
					set recvBuddyId to text item 2 of recvBuddyId
					set AppleScript's text item delimiters to oldDelims
					# now recvBuddyId is +17894560123
					
					set fwdMsg to "[" & recvBuddy & "] [" & recvBuddyId & "] [" & recvText & "]"
					set sendServiceName to name of 1st service whose name = fwdService
					set myid to get id of service sendServiceName
					set sendBuddy to buddy fwdServiceBuddy of service id myid
					send fwdMsg to sendBuddy
				else if recvService = fwdService then # outgoing iMessage
					set sendServiceName to name of 1st service whose name = myIMsgService
					set myid to get id of service sendServiceName
					set tokens to words of recvText
					set targetBuddy to get item 1 of tokens
					set sendBuddy to buddy targetBuddy of service id myid
					# chop out targetBuddy from recvText
					set fwdMsg to text (2 + (length of targetBuddy)) thru (length of recvText) of recvText
					send fwdMsg to sendBuddy
				end if
			on error err
				# optionally log errors here
			end try
		end if
		
		# make messages happy
		return true
	end message received
end using terms from

# Nothing you put here will get executed - only what's inside the event handler block runs
