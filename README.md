# PG Notify Demo

This is a demo project for the LISTEN/NOTIFY feature built in to recent versions of PostgreSQL. For more information, see:

* http://www.postgresql.org/docs/9.4/static/sql-notify.html
* http://www.postgresql.org/docs/9.4/static/sql-listen.html

Quick start:

    git clone https://github.com/masonjm/pg_notify_demo
    bin/setup
    foreman start

If you want to play with multiple senders/receivers, run something like:

    foreman start -c notifier=2,listener=3

## Random Notes

* There's not a lot of security around this. If you can connect to a PG database you can send and receive notifications on any channel.
* All listeners receive all notifications on the channel. Keep this in mind if you're running multiple listeners and you don't want duplicate work.
* There are at least two ruby gems that use this feature for processing background jobs. [QueueClassic][1] is one.
* Real code needs error handling. Connections go away; they time out; duplicate data gets sent; etc. I've found it helpful to have a "keepalive" notifier that sends a blank message every second.
* A single connection can listen to multiple channels. This is handy when you have a keepalive channel.
* The data sent with a notify is just a string. You can stick whatever you want in there, but it's up to you to do it sanely and safely. I've seen several recommendations to put data into a table rather than the notify message, and just use the notify message as a trigger to check the table.
* Postgres will not queue notifications for a listener that's disconnected.

[1]: https://github.com/QueueClassic/queue_classic
