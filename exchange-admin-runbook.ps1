# Exchange Server PowerShell Administration Runbook

# Company: Aston Villa FC
# Domain: astonvilla.local

# Example users:
# Ollie Watkins
# John McGinn
# Emiliano Martinez
# Tyrone Mings
# Ezri Konsa
# Morgan Rogers

# This runbook demonstrates how to install Exchange Server and some common administration tasks performed by systems administrators.

# Exchange Server Installation Overview
# Exchange installation is usually performed after

# 1. Installing Windows Server
# 2. Joining the server to the domain
# 3. Configuring DNS
# 4. Installing required Windows features
# 5. Extending the Active Directory schema
# 6. Installing Exchange

# Example Environment
# Domain Controller:
# DC01.astonvilla.local

# Exchange Server:
# EX01.astonvilla.local
#
# Domain:
# astonvilla.local

# Verify Domain Membership
Get-ComputerInfo |
Select CsDomain

# Install IIS
Install-WindowsFeature `
Web-Server `
-IncludeManagementTools

# Install Exchange Prerequisites
Install-WindowsFeature `
Server-Media-Foundation

# Verify Active Directory
Get-ADDomain

Get-ADForest

# Example Schema Preparation

# Usually run from Exchange installation media.

# Setup.exe /PrepareSchema
# Setup.exe /PrepareAD
# Setup.exe /PrepareAllDomains

# Example Exchange Installation

# Setup.exe /Mode:Install

# Actual installation is normally completed using the Exchange setup wizard.

# Verify Exchange Server
Get-ExchangeServer

# Exchange Server Information
Get-ExchangeServer

# Exchange Services - displays all Exchange-related services running on the server
Get-Service *Exchange*

# Service Health - verifies critical Exchange services are running. Common troubleshooting step when users report email issues.
Test-ServiceHealth

# Mailbox Databases - checks mailbox database status and health.
Get-MailboxDatabase

Get-MailboxDatabaseCopyStatus

# Mount a mailbox database
Mount-Database DB01

# Dismount a mailbox database
Dismount-Database DB01

# Create Mailboxes
New-Mailbox `
-Name "Ollie Watkins" `
-Alias owatkins `
-UserPrincipalName owatkins@astonvilla.local `
-Password (ConvertTo-SecureString "Password123!" -AsPlainText -Force)

New-Mailbox `
-Name "John McGinn" `
-Alias jmcginn `
-UserPrincipalName jmcginn@astonvilla.local `
-Password (ConvertTo-SecureString "Password123!" -AsPlainText -Force)

# View Mailboxes
Get-Mailbox

# View a specific mailbox
Get-Mailbox owatkins

# Mailbox Statistics - checking mailbox size and usage.
Get-MailboxStatistics owatkins
Get-MailboxStatistics jmcginn

# Mailbox Reporting
Get-Mailbox |
Select Name,PrimarySmtpAddress |
Export-Csv mailbox-report.csv -NoTypeInformation

# Disable Mailbox - used during employee offboarding.
Disable-Mailbox owatkins

# Remove Mailbox - permanently removes a mailbox.
Remove-Mailbox owatkins

# Shared Mailboxes
New-Mailbox `
-Shared `
-Name "IT Support"

Get-Mailbox `
-RecipientTypeDetails SharedMailbox

# Mailbox Permissions
Add-MailboxPermission `
-Identity "IT Support" `
-User jmcginn `
-AccessRights FullAccess

Get-MailboxPermission "IT Support"

# View mailbox size
Get-MailboxStatistics owatkins |
Select DisplayName,TotalItemSize

# View mailbox permissions
Get-MailboxPermission owatkins

# Distribution Groups - used to send email to multiple users simultaneously.
New-DistributionGroup `
-Name "First Team"

New-DistributionGroup `
-Name "Coaching Staff"

New-DistributionGroup `
-Name "Commercial Team"

# Distribution Group Membership
Add-DistributionGroupMember `
-Identity "First Team" `
-Member owatkins

Add-DistributionGroupMember `
-Identity "First Team" `
-Member jmcginn

# View group members
Get-DistributionGroupMember `
-Identity "First Team"

# Export Group Membership Report
Get-DistributionGroupMember "First Team" |
Export-Csv distribution-group-report.csv -NoTypeInformation

# Email Addresses and Aliases - users often require additional email aliases.
Get-Mailbox owatkins |
Select EmailAddresses

Set-Mailbox `
-Identity owatkins `
-EmailAddresses @{Add="ollie.watkins@astonvillafc.com"}

# Message Tracking - allows administrators to trace messages through Exchange.
Get-MessageTrackingLog `
-Start (Get-Date).AddHours(-24)

Get-MessageTrackingLog `
-Sender owatkins@astonvilla.local

# Mail Queues - when Exchange cannot immediately deliver a message it is placed into a queue.
# i.e DNS problems, Internet connectivity issues, Connector problems, Mail server issues
Get-Queue

Get-Queue |
Format-Table

Retry-Queue

# Send Connectors - control how outbound email leaves the organisation. Common troubleshooting  when users cannot send emails externally.

Get-SendConnector

# Receive Connectors = control how Exchange accepts incoming email. Common troubleshooting area
# i.e SMTP relay, Application mail delivery, External email issues
Get-ReceiveConnector

# Exchange Certificates - uses SSL/TLS certificates to secure
# Outlook Web App (OWA), Exchange Admin Center (EAC), SMTP TLS communications
# i.e. DigiCert, Sectigo, GlobalSign
# Administrators should regularly check certificate expiry dates.
Get-ExchangeCertificate

# Outlook Web App - Users access webmail through OWA.
# https://mail.astonvilla.local/owa

# Exchange Admin Center - Main web administration portal.
# https://mail.astonvilla.local/ecp

# Exchange Transport Service - responsible for moving email through Exchange.
# If users report delayed or stuck email, checking this service is a common first step.
Get-Service MSExchangeTransport

Restart-Service MSExchangeTransport

# IIS Reset - often used when troubleshooting OWA issues, EAC issues and Authentication problems
iisreset

# Daily Health Checks - common checks performed by Exchange administrators.
Test-ServiceHealth

Get-MailboxDatabaseCopyStatus

Get-Queue

Get-ExchangeCertificate

# Mailbox Size Limits - used to control mailbox growth
Get-Mailbox owatkins |
Select ProhibitSendQuota

Set-Mailbox `
-Identity owatkins `
-IssueWarningQuota 45GB `
-ProhibitSendQuota 48GB `
-ProhibitSendReceiveQuota 50GB

# Automatic Replies
Set-MailboxAutoReplyConfiguration `
-Identity owatkins `
-AutoReplyState Enabled `
-InternalMessage "I am currently out of office." `
-ExternalMessage "I am currently out of office."

Get-MailboxAutoReplyConfiguration owatkins

# Mailbox Forwarding
Set-Mailbox `
-Identity owatkins `
-ForwardingAddress jmcginn

Get-Mailbox owatkins |
Select ForwardingAddress

# Compliance Searches
New-ComplianceSearch `
-Name "PlayerTransferSearch" `
-ExchangeLocation All `
-ContentMatchQuery 'transfer'

Start-ComplianceSearch `
-Identity "PlayerTransferSearch"

Get-ComplianceSearch

# Mailbox Search - search mailbox content for specific messages.
Search-Mailbox `
-Identity owatkins `
-SearchQuery 'Subject:"Contract Renewal"' `
-EstimateResultOnly

# Mail Flow Testing - verifies Exchange can process email correctly.
Test-Mailflow

# Database Health Check - verify mailbox databases are healthy.
Get-MailboxDatabaseCopyStatus

Test-ServiceHealth

# Hide mailbox from Global Address List (GAL)
Set-Mailbox `
-Identity owatkins `
-HiddenFromAddressListsEnabled $true

# Show mailbox (unhide) in Global Address List (GAL)
Set-Mailbox `
-Identity owatkins `
-HiddenFromAddressListsEnabled $false

# View Exchange services
Get-Service *Exchange*

# Start Exchange Transport Service
Start-Service MSExchangeTransport

# Stop Exchange Transport Service
Stop-Service MSExchangeTransport

# Restart Exchange Transport Service
Restart-Service MSExchangeTransport

# Check DNS resolution
Resolve-DnsName astonvilla.local

# Test MX record lookup
Resolve-DnsName -Type MX astonvilla.local

# View recent Exchange application events
Get-EventLog `
-LogName Application `
-Newest 50

# Common Exchange backup products i.e Veeam, Rubrik, Commvault, Windows Server Backup
# Always test restores, not just backups.










