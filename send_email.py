#!/usr/bin/env python3

from smtplib import SMTP
from os import environ
from sys import argv

with SMTP(environ['MAIL_HOST'], int(environ['MAIL_PORT'])) as conn:
    if environ['MAIL_STARTTLS']:
        conn.starttls()
    conn.login(environ['MAIL_USERNAME'], environ['MAIL_PASSWORD'])
    message = f"""From: {environ['MAIL_EMAIL']}
To: {environ['ADMIN_NOTIFY_ADDRESS']}
Subject: {argv[1]}

{argv[2]}
"""
    conn.sendmail(environ['MAIL_EMAIL'], [environ['ADMIN_NOTIFY_ADDRESS']], message)
