# IT Diagnostics and Troubleshooting Lab

A Linux troubleshooting portfolio project built with Bash and Python to demonstrate system-health diagnostics, network troubleshooting, simulated failure testing, logging, and post-fix verification.

## Overview

This project provides a small troubleshooting lab for practicing a structured IT-support workflow.

The scripts inspect Linux system resources, test network connectivity, validate DNS resolution, test TCP connectivity, safely simulate a DNS-style failure, verify recovery, and generate diagnostic logs.


## Features

### Linux System Health Diagnostics

The Bash system-health script checks:

- Hostname
- Current user
- Date and time
- System uptime
- CPU core count
- Load average
- Memory usage
- Disk usage
- Top CPU-consuming processes
- Top memory-consuming processes
- Failed services
- Memory threshold warnings
- Disk threshold warnings

### Network Diagnostics

The Python diagnostic script checks:

- Local hostname
- Local IP address
- Direct IP connectivity
- DNS hostname resolution
- TCP connectivity on port 443

### Safe Failure Simulation

The project contains a controlled failure simulator that changes only the lab's target hostname.

It does not modify the operating system's real DNS settings.

The failure demonstrates how the diagnostic script responds when hostname resolution fails.

### Recovery Verification

A recovery script restores the valid test hostname and automatically reruns the diagnostic checks to confirm:

- DNS resolution
- TCP connectivity
- Overall recovery status

### Diagnostic Logging

Generated diagnostic results are stored locally in:

```text
logs/system_health.log
logs/network_diagnostics.log
```

Log files are excluded from Git because they are generated during each run.

## Technologies

- Linux
- Bash
- Python
- TCP/IP
- DNS
- ICMP
- TCP sockets
- Git
- GitHub

## Project Architecture

```text
Reported Issue
     ↓
System Health Check
     ↓
Network Check
     ↓
DNS Check
     ↓
TCP Check
     ↓
Identify Failing Layer
     ↓
Correct Issue
     ↓
Post-Fix Verification
     ↓
Documentation / Handoff
```

## Project Structure

```text
it-diagnostics-troubleshooting-lab/
├── README.md
├── scripts/
│   ├── network_diagnostics.py
│   ├── simulate_failure.sh
│   ├── system_health.sh
│   └── verify_recovery.sh
├── docs/
│   ├── handoff-guide.md
│   └── troubleshooting-runbook.md
└── test-data/
    └── network_target.txt
```

Generated logs are excluded from version control.

## Requirements

The project was built for a Linux environment and can also be run using WSL on Windows.

Common commands and utilities used include:

- `bash`
- `python3`
- `ping`
- `systemctl`
- `free`
- `df`
- `ps`
- `uptime`
- `hostname`

## Clone the Repository

```bash
git clone https://github.com/GeorgeChriz101/it-diagnostics-troubleshooting-lab.git
```

Enter the project:

```bash
cd it-diagnostics-troubleshooting-lab
```

## Run System Health Diagnostics

Make the script executable if necessary:

```bash
chmod +x scripts/system_health.sh
```

Run:

```bash
./scripts/system_health.sh
```

The generated report is stored locally at:

```text
logs/system_health.log
```

## Run Network Diagnostics

Run:

```bash
python3 scripts/network_diagnostics.py
```

The diagnostic performs direct-IP, DNS, and TCP tests.

The generated report is stored locally at:

```text
logs/network_diagnostics.log
```

## Run the Failure Simulation

Make the script executable:

```bash
chmod +x scripts/simulate_failure.sh
```

Run:

```bash
./scripts/simulate_failure.sh
```

The simulator changes the lab target to:

```text
does-not-exist.invalid
```

The network diagnostic should detect the DNS-resolution failure.

## Verify Recovery

Make the script executable:

```bash
chmod +x scripts/verify_recovery.sh
```

Run:

```bash
./scripts/verify_recovery.sh
```

The script restores:

```text
example.com
```

as the valid target and reruns the diagnostic process.

Successful verification reports:

```text
DNS Resolution: PASS
TCP Connectivity: PASS
OVERALL RESULT: PASS
RECOVERY VERIFIED
```

## Troubleshooting Workflow

The project demonstrates the following workflow:

```text
Detect
→ Diagnose
→ Collect Evidence
→ Correct
→ Retest
→ Verify
→ Document
```

## Concepts Demonstrated

### Linux Troubleshooting

- CPU and system load
- Memory utilization
- Disk utilization
- Process inspection
- Service-state inspection
- Threshold-based warnings

### Networking

- IP connectivity
- DNS resolution
- TCP connectivity
- Port 443 testing
- Network-layer isolation

### Operations

- Diagnostic logging
- Failure simulation
- Post-fix verification
- Troubleshooting documentation
- Technician handoff

## Documentation

The detailed troubleshooting process is available in:

```text
docs/troubleshooting-runbook.md
```

The technician handoff process is available in:

```text
docs/handoff-guide.md
```

## Safety

The simulated failure does not change the computer's real DNS configuration, Wi-Fi settings, routing configuration, or internet connection.

It changes only the hostname stored in:

```text
test-data/network_target.txt
```

This makes it possible to demonstrate failure detection without intentionally disrupting the host system.
