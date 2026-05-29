# Exchange Server PowerShell Runbook

A Windows Server Exchange runbook that uses PowerShell to complete common Exchange administration and troubleshooting tasks.

## Features

* Verifies Exchange Server installation prerequisites
* Checks Exchange service health
* Creates and manages user mailboxes
* Creates and manages shared mailboxes
* Configures mailbox permissions
* Creates and manages distribution groups
* Adds and removes distribution group members
* Configures mailbox aliases and email addresses
* Exports mailbox reports
* Exports distribution group membership reports
* Configures mailbox size limits
* Configures automatic replies (Out of Office)
* Configures mailbox forwarding
* Tracks email delivery using message tracking logs
* Monitors and manages Exchange mail queues
* Verifies send and receive connector configuration
* Checks Exchange SSL/TLS certificates
* Performs Exchange database health checks
* Performs Exchange mail flow testing
* Performs compliance and mailbox searches
* Restarts Exchange transport services
* Performs IIS resets for Exchange web services

## How it works

The script is written as a PowerShell runbook for a small Exchange Server environment within Aston Villa FC.

The example environment contains:

* An Active Directory domain
* An Exchange Server
* User mailboxes
* Shared mailboxes
* Distribution groups
* Exchange databases
* Mail flow services

The runbook demonstrates how common Exchange administration, support and troubleshooting tasks can be performed using PowerShell.

## Example Environment

### Domain Controller

* DC01.astonvilla.local

### Exchange Server

* EX01.astonvilla.local

### Domain

* astonvilla.local

### Example Users

* Ollie Watkins
* John McGinn
* Emiliano Martinez
* Tyrone Mings
* Ezri Konsa
* Morgan Rogers

## Files

* `exchange-admin-runbook.ps1` - main runbook containing Exchange installation notes, mailbox administration, mail flow troubleshooting and Exchange health checks

## Technologies and Concepts

* Microsoft Exchange Server
* Exchange Management Shell
* PowerShell
* Active Directory
* Mailbox Administration
* Shared Mailboxes
* Distribution Groups
* Mail Flow
* Message Tracking
* Send Connectors
* Receive Connectors
* Exchange Databases
* SSL/TLS Certificates
* Exchange Transport Services
* IIS
* Compliance Searches

## Common Tasks Covered

### Mailbox Administration

* Create mailboxes
* Disable mailboxes
* Remove mailboxes
* Configure aliases
* Configure forwarding
* Configure mailbox size limits

### User Support

* Configure Out of Office replies
* Grant mailbox permissions
* Manage shared mailbox access
* Troubleshoot email delivery

### Distribution Groups

* Create distribution groups
* Add members
* Remove members
* Export membership reports

### Troubleshooting

* Check Exchange services
* Verify database health
* Review mail queues
* Track messages
* Test mail flow
* Review certificates
* Restart Exchange transport services

## Notes

* Built for a Windows Server Exchange Server lab
* Uses Exchange Management Shell PowerShell cmdlets
* Demonstrates common helpdesk and sysadmin Exchange tasks
* Covers mailbox administration, mail flow and troubleshooting
* Includes examples of compliance and mailbox searches
* Includes Exchange certificate management examples
* Includes Exchange database health verification examples
* Sections are commented so they can be reviewed individually
* Example passwords, domains and users are for lab purposes only and should not be used in production