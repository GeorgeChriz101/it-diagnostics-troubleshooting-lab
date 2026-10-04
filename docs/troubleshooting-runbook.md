# IT Diagnostics and Troubleshooting Runbook

## Purpose

This runbook provides a simple, repeatable process for diagnosing common Linux system and network problems.

## Troubleshooting Process

Use the following general workflow:

1. Confirm the reported problem.
2. Collect system information.
3. Check system resource health.
4. Check network connectivity.
5. Check DNS resolution.
6. Check TCP connectivity.
7. Identify the most likely failing layer.
8. Apply or simulate the correction.
9. Run post-fix verification.
10. Document the result and handoff information.

## 1. Confirm the Problem

Before making changes, collect basic information.

Record:

- User or system affected
- Time the issue started
- Reported symptoms
- Error messages
- Recent changes
- Whether the problem affects one user or multiple users
- Whether the problem is constant or intermittent

Avoid making changes before collecting enough evidence to understand the issue.

## 2. Run System Health Diagnostics

Run:

```bash
./scripts/system_health.sh
```

The script checks:

- Hostname
- Current user
- Date and time
- System uptime
- CPU core count
- Load average
- Memory usage
- Disk usage
- Highest CPU-consuming processes
- Highest memory-consuming processes
- Failed system services
- Memory and disk warning thresholds

Results are also written to:

```text
logs/system_health.log
```

## 3. Review Memory Usage

The lab uses an 80% memory threshold as a simple demonstration warning level.

If memory usage is high:

1. Review the top memory-consuming processes.
2. Identify unexpected processes.
3. Determine whether the usage is temporary or sustained.
4. Check whether the application or process should be restarted or investigated further.
5. Avoid terminating production processes without understanding their purpose and impact.

## 4. Review Disk Usage

The system-health script checks root filesystem utilization.

If disk usage is greater than or equal to the lab threshold:

1. Identify the affected filesystem.
2. Determine which directories or files are consuming space.
3. Check for large logs, temporary files, application data, or old artifacts.
4. Confirm whether cleanup is safe before deleting anything.
5. Run the health check again after corrective action.

## 5. Review CPU and Load

Review:

- Load average
- Top CPU-consuming processes
- Number of CPU cores

High CPU usage may indicate:

- Heavy application workload
- A runaway process
- Background processing
- Too many concurrent tasks
- Insufficient system capacity

Resource usage should be evaluated against the normal baseline of the system.

## 6. Review Failed Services

The script attempts to run:

```bash
systemctl --failed --no-pager
```

If failed services appear:

1. Identify the service name.
2. Review the service status.
3. Inspect relevant logs.
4. Determine the cause before restarting the service.
5. Restart or escalate according to the environment's operating procedures.
6. Verify the service after corrective action.

## 7. Run Network Diagnostics

Run:

```bash
python3 scripts/network_diagnostics.py
```

The script performs:

- Local hostname check
- Local IP-address check
- Direct IP connectivity test
- DNS resolution test
- TCP connection test on port 443

Results are written to:

```text
logs/network_diagnostics.log
```

## 8. Interpret Network Results

### Direct IP Connectivity

The script attempts to ping a direct IP address.

If this fails, possible causes include:

- Network connectivity failure
- Routing problems
- Firewall restrictions
- ICMP being blocked

A failed ping alone does not prove that the network is unavailable because some networks block ICMP.

### DNS Resolution

If direct network connectivity appears available but hostname resolution fails, investigate DNS.

Possible causes include:

- Invalid hostname
- DNS server problem
- DNS configuration problem
- Temporary resolver issue

### TCP Connectivity

If DNS succeeds but the TCP connection fails, investigate:

- Remote service availability
- Firewall rules
- Port accessibility
- Routing
- Application availability

The lab tests TCP port 443.

## 9. Safe Failure Simulation

Run:

```bash
./scripts/simulate_failure.sh
```

This script changes only the lab's diagnostic target from:

```text
example.com
```

to:

```text
does-not-exist.invalid
```

It does not modify the operating system's real DNS configuration or disconnect the computer from the network.

The network diagnostic should report:

```text
DNS Resolution: FAIL
TCP Connectivity: FAIL
OVERALL RESULT: FAIL
```

This demonstrates that the diagnostic tool can identify a DNS-style failure.

## 10. Correct and Verify

Run:

```bash
./scripts/verify_recovery.sh
```

The script restores:

```text
example.com
```

as the valid diagnostic target.

It then reruns the network diagnostics.

Successful recovery should report:

```text
DNS Resolution: PASS
TCP Connectivity: PASS
OVERALL RESULT: PASS
```

followed by:

```text
RECOVERY VERIFIED
```

## 11. Post-Fix Verification

Never assume that a corrective action worked.

After any change:

1. Repeat the original diagnostic check.
2. Confirm that the failure condition is gone.
3. Confirm that the expected service works.
4. Review logs for remaining errors.
5. Confirm that no additional issue was introduced.
6. Record the final result.

## 12. Escalation

Escalate the issue when:

- The root cause cannot be identified.
- The required change is outside your authorization.
- A production service is at risk.
- A security issue is suspected.
- Multiple systems are affected.
- The issue continues after reasonable troubleshooting.
- Specialized application or infrastructure knowledge is required.

Before escalation, provide the next technician with the evidence already collected.

## Troubleshooting Principle

A useful troubleshooting pattern is:

```text
Problem
   ↓
Collect Evidence
   ↓
Identify Failing Layer
   ↓
Apply Correction
   ↓
Retest
   ↓
Verify Recovery
   ↓
Document and Handoff
```

The goal is not simply to make the error disappear. The goal is to identify what failed, collect evidence, apply a controlled correction, and confirm that normal operation has been restored.