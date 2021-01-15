# frozen_string_literal: true

%w[clickhouse].each do |app|
  logrotate_app app do
    path "/var/log/#{app}/*.log"
    options %w[missingok compress copytruncate notifempty]
    frequency 'hourly'
    maxsize '10M'
    rotate  10
  end
end

logrotate_app 'rsyslog' do
  path [
    '/var/log/syslog',
    '/var/log/mail.info',
    '/var/log/mail.warn',
    '/var/log/mail.err',
    '/var/log/mail.log',
    '/var/log/daemon.log',
    '/var/log/kern.log',
    '/var/log/auth.log',
    '/var/log/user.log',
    '/var/log/lpr.log',
    '/var/log/cron.log',
    '/var/log/debug',
    '/var/log/messages'
  ]
  options %w[missingok compress copytruncate]
  frequency 'hourly'
  rotate 7
  su 'root syslog'
end

file '/etc/cron.d/logrotate' do
  content ['MAILTO=""', '*/30 * * * * root /etc/cron.hourly/logrotate', ''].join("\n")
end
