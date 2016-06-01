# AutoForwardIMessageText.applescript
# - Supports 2-way relaying of iMessage to/from another chat service
# - To send iMessage, each outgoing iMessage must be formatted as: "[iMessage destination] Message"

# References
# https://discussions.apple.com/thread/5214769?start=0&tstart=0
# https://46b.it/2012/hacking-with-imessage
# http://stackoverflow.com/questions/34170906/error-in-applescript-for-imessage-can-t-get-service-of-text-chat-id - Forum on bug in El Capitan. Currently at same conclusion.

# You can enumerate all your chat accounts on Messages like this:
(*
tell application "Messages"
get name of every service
end tell
*)
# Example result: {"Bonjour", "Facebook Chat", "AIM", "E:you@me.com"}

# What's your iMessage/iCloud/Apple ID? Note the format
# This must be the same as what's listed under Accounts
property myIMsgService : "E:myIMessage@me.com"

# Remember the iMessage that just came in
property recvService : ""
property recvText : ""
property recvBuddy : ""

# Account to use for forwarding
# (This is the "friendly" name in the Accounts list)
property fwdService : "Fowarding Chat Acct"

# The buddy to receive the forwarded message - presumably your primary chat acct
# To send to an SMS, enter as format "+15555551212"
property fwdServiceBuddy : "myPrimary@gmail.com"

# What ultimately gets forwarded
property fwdMsg : ""

# Event handler
using terms from application "Messages"
	#Handler for parsing string. termRequested is which parsed word is requested from the string (e.g. first, second, third...etc.)
	on parse(delimiter, stringToParse, termRequested)
		set oldDelims to AppleScript's text item delimiters
		set AppleScript's text item delimiters to {delimiter}
		set stringToReturn to text item termRequested of stringToParse
		set AppleScript's text item delimiters to oldDelims
		
		return stringToReturn
	end parse
	
	on message received theText from theBuddy for theChat
		# get what we need
		# Apparent bug in OSX El Capitan where service properties for theChat are not present -> theBuddy is used instead
		set recvService to name of service of theBuddy # theBuddy used instead of theChat
		set recvText to theText
		set recvBuddy to name of theBuddy as text
		
		# fwd
		if recvText /= "" then
			try
				if recvService = myIMsgService then # incoming iMessage
					# recvBuddyId is ABCDEFGH-IJKL-MNOP-QRST-UVWXYZABCDEF:+17894560123
					set recvBuddyId to id of theBuddy as text
					set recvBuddyId to my parse(":", recvBuddyId, 2)
					# now recvBuddyId is +17894560123
					
					# e.g. SMS looks like "[John Doe] [example@gmail.com] [MessageText]"
					set fwdMsg to "[" & recvBuddy & "] [" & recvBuddyId & "] [" & recvText & "]"
					set sendServiceName to name of 1st service whose name = fwdService
					set myid to get id of service sendServiceName
					set sendBuddy to buddy fwdServiceBuddy of service id myid
					send fwdMsg to sendBuddy
				else if recvService = fwdService then # outgoing iMessage
					# send iMessage using user's primary iMessage account.
					set sendServiceName to name of 1st service whose name = myIMsgService
					set myid to get id of service sendServiceName
					
					# Message looks like "[emailToSendTo@example.com] MessageText"
					# Chop off first [ and then retrieve email address to send to
					set targetBuddy to text 2 thru (length of recvText) of recvText
					set targetBuddy to my parse("]", targetBuddy, 1)
					
					set sendBuddy to buddy targetBuddy of service id myid
					# chop out targetBuddy from recvText
					set fwdMsg to text (3 + (length of targetBuddy)) thru (length of recvText) of recvText
					send fwdMsg to sendBuddy
				end if
			on error err
				# optionally log errors here
			end try
		end if
		
		# make messages happy
		return true
	end message received
	
	# The following are unused but need to be defined to avoid an error
	# I don't fully understand why, but all the Apple examples in Mavericks
	# have this now as well.
	
	on message sent theMessage for theChat
		
	end message sent
	
	on active chat message received
		
	end active chat message received
	
	on chat room message received theMessage from theBuddy for theChat
		
	end chat room message received
	
	on addressed chat room message received theMessage from theBuddy for theChat
		
	end addressed chat room message received
	
	on addressed message received theMessage from theBuddy for theChat
		
	end addressed message received
	
	on av chat started
		
	end av chat started
	
	on av chat ended
		
	end av chat ended
	
	on login finished for theService
		
	end login finished
	
	on logout finished for theService
		
	end logout finished
	
	on buddy became available theBuddy
		
	end buddy became available
	
	on buddy became unavailable theBuddy
		
	end buddy became unavailable
	
	on completed file transfer
		
	end completed file transfer
	
end using terms from

# Nothing you put here will get executed - only what's inside the event handler block runs
