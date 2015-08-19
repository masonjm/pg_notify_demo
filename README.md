Quick start:

    git clone https://github.com/masonjm/pg_notify_demo
    bin/setup
    foreman start

If you want to play with multiple senders/receivers, run something like:

    foreman start -c notifier=2,listener=3
