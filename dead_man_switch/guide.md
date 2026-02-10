Those two scripts are the most important. Don’t forget to set their permissions as executable. Next you need to decide how often you want the switch to be triggered. You can set it to be as frequent as you wish but remember if the switch isn’t deactivated each time before trigger.sh runs it will publish the private key. The last thing you want is to accidentally trigger the switch. Phoenixnap.com has a great knowledge base article on using Cron. Here’s an example that triggers the switch monthly at 00:00 hrs:

@monthly /home/[user]/trigger.sh

And finally the client command to disarm the switch is:

torify ssh [user]@[address.onion] disarm.sh




Reminder

As an added bonus you could use Cron to schedule a script notifying you before the DMS is triggered. For instance if the DMS needs to be disarmed on a monthly basis you could write a script that emails you a week in advance a reminder to deactivate it. Again a DMS is only effective if you don’t forget to disarm it, so I wouldn’t create a DMS without a notification script.

That’s it. That’s all you need to set up your own DMS.

