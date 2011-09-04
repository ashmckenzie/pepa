Pepa bot
========

IRC bot written using [Cinch](https://github.com/cinchrb/cinch).

What Pepa can do
----------------

`!ping <host>`
  
Pings a given host and tells you if the host is up or down.

    ash: !ping google.com
    [11:34pm] pepa: ash: google.com is up
  
`!ci:status`

Asks the Jenkins CI server for the status of all jobs.

    ash: !ci:status
    [11:35pm] pepa: ash: http://ci-server.local:8080/api/json/job/CI-SomeService-End-to-End, http://ci-server.local:8080/api/json/job/SYSTEST-SomeService-End-to-End are red.
