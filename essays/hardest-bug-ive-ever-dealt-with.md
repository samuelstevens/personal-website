
---
title: Hardest Bug I've Ever Dealt With
author:
    - Sam Stevens
keywords: []
abstract: 
---
# Hardest Bug I've Ever Dealt With

**You want your writing to communicate with maximum effectiveness to its reader, not reveal the exact route you took to reach your conclusions.**

The Hardest Bug I’ve Ever Dealt With™ was actually not a bug in the sense of code not doing what I wanted. It was *email* not doing what I wanted, and then the challenges that came with bending the code to meet the email standards. 

For [TicketBay](https://salty.software/ticketbay), we sent confirmation emails to new users so that only Ohio State students could use the app. These emails included a link with a big hash as a query param so that we could be sure it was unique, only they could click on it, and we could be sure it was their account. Pretty standard stuff, I’m sure everyone has gotten dozens of these emails.

Except nearly *all of our emails went to junk or spam*. And we could not figure out why. We had added rDNS, DKIM, TXT records, all this stuff that was recommended. 

*(I’ll be honest; we did not do as much as a deep dive into mail as I wish we had. Setting up email was a low priority for us, and when I couldn’t get postfix working on a EC2 box in under two days, I called it quits and went with Zoho mail.)*

Eventually I started looking for why email clients would mark emails as spam, and `a` tags (links) were one of the reasons. So I removed all the links from the email, **including the all-important confirmation link**. Still went to spam. Removed the image which was hosted at [salty.software](https://salty.software)

**DID NOT GO TO SPAM!**

That completed finding the cause of the bug. I had sent myself hundreds of emails over 4 hours, and despite the fact that I basically deleted every email as soon as it delivered to my inbox, I could still send an automated email to myself with no links and it would not go to spam. 

Actually *fixing* the bug required building a system where we could send confirmation emails without a link (and eventually ‘I forgot my password’ emails as well). We had been talking about Slack’s magic link login, and all thought that was better than passwords, but we couldn’t send links.

This led us to sending a passcode confirmation email, with some randomly generated passcode of numbers and letters that users could copy-paste into TicketBay when signing up for the first time. 

This system would actually solve a number of problems at once.

1. Confirmation and password emails went to spam.

2. Passwords are dangerous to store because you can accidentally store them in plain text.

3. The forgot password authentication flow was awful and confusing and nobody knew how or why it worked.

With the new confirmation ~~link~~ *passcode* system, emails would not go to spam because there were no links. 

We didn’t need to store user passwords, only a hashed version of the random code we generated. We effectively created much more secure passwords and then just emailed them to users. 

You could never forget your password, because anytime you wanted to log in, you needed to get a new confirmation code generated and sent to you. There was no password to forget.

After deciding on the confirmation code system, the only thing to worry about was implementation, and security assumptions.

We needed to balance security (making the code long enough and with  a large enough set of characters) with ease of use (easy to copy paste, easy to see and understand what was going on). Eventually, we settled on an 18 character passcode that was generated server side and stored as a hash, just like a password. This was long enough to be secure, and short enough to fit on one line for most people’s mobile email clients.

We’re convinced this solution is secure for our users based on several assumptions.

1. A user’s email accounts is secure. Only they have access.

2. Storing a hash of a random 18 character string is secure.

3. The passcode is not logged anywhere in plaintext.

#3 is the only assumption that worried me. We use SendGrid and Zoho mail to send our email, so the passcode is stored in plaintext on their servers (AFAIK). So assumption #3 is really:

3. The passcode is not logged anywhere in plaintext on our server instance.

4. Zoho Mail is secure and trustworthy.

5. SendGrid is secure and trustworthy.

However, based on the scope and security risk of our application, I think we can safely make these assumptions. The most important piece of data we store is user’s phone numbers, which has historically been public information (in the yellow pages). Given this, I think we made the right tradeoff between security, ease of use for our users, and development time.