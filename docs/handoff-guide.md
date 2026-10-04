# IT Troubleshooting Handoff Guide

## Purpose

This guide provides a simple structure for handing an unresolved or recently resolved technical issue to another technician or support team.

A good handoff should allow the next person to continue troubleshooting without repeating all previous work.

## Required Handoff Information

Include the following information whenever possible.

### 1. Problem Summary

Provide a short description of the issue.

Example:

```text
User is unable to access a network service because the target hostname is not resolving.
```

### 2. Impact

Document who or what is affected.

Examples:

- One user
- One workstation
- One server
- Multiple users
- Multiple systems
- Business-critical service

### 3. Time Detected

Record when the problem was reported or first observed.

### 4. System Information

Include relevant information such as:

- Hostname
- IP address
- Operating system
- Location
- Application or service
- Relevant equipment

### 5. Diagnostic Results

Summarize the checks already performed.

Examples:

```text
System Health: PASS
Memory: Normal
Disk: Normal
Failed Services: None
Direct IP Connectivity: PASS
DNS Resolution: FAIL
TCP Connectivity: Not tested because DNS failed
```

### 6. Troubleshooting Actions Performed

Document each significant action.

Example:

```text
1. Ran system health diagnostics.
2. Confirmed CPU, memory, and disk were within expected levels.
3. Ran network diagnostics.
4. Confirmed network connectivity.
5. DNS resolution failed for the configured target.
```

### 7. Corrective Action

If a correction was attempted, document exactly what changed.

Example:

```text
Restored the diagnostic target from the intentionally invalid hostname to example.com.
```

### 8. Post-Fix Verification

Record whether verification succeeded.

Example:

```text
DNS Resolution: PASS
TCP Connectivity: PASS
Recovery Verification: PASS
```

### 9. Current Status

Use a clear status such as:

- Investigating
- Monitoring
- Escalated
- Resolved

### 10. Recommended Next Action

If the issue is unresolved, clearly state what should happen next.

Example:

```text
Escalate to the network team to review DNS resolver availability and configuration.
```

## Example Handoff

### Incident

Network hostname resolution failure.

### Impact

Diagnostic target could not be reached by hostname.

### Initial Findings

System resource checks were normal.

Direct IP connectivity was available.

DNS resolution failed.

TCP testing could not continue because the hostname could not be resolved.

### Action Taken

The invalid test hostname was replaced with the valid test hostname.

### Verification

DNS resolution passed.

TCP port 443 connectivity passed.

Recovery verification completed successfully.

### Status

Resolved.

### Final Notes

The incident demonstrated a DNS-layer failure rather than a general system resource problem. Post-fix testing confirmed normal connectivity.

## Handoff Principle

The next technician should be able to answer these questions immediately:

```text
What is broken?
Who or what is affected?
What has already been checked?
What evidence was collected?
What changes were made?
What is the current status?
What should happen next?
```

A clear handoff reduces duplicate troubleshooting and helps incidents move between technicians efficiently.