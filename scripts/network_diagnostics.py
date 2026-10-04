import socket
import subprocess
from datetime import datetime
from pathlib import Path


LOG_FILE = Path("logs/network_diagnostics.log")
TARGET_FILE = Path("test-data/network_target.txt")

DIRECT_IP_TEST = "1.1.1.1"
TCP_PORT = 443


def write_log(message=""):
    print(message)

    with LOG_FILE.open("a") as log:
        log.write(message + "\n")


def ping_host(host):
    result = subprocess.run(
        [
            "ping",
            "-c",
            "2",
            "-W",
            "2",
            host
        ],
        capture_output=True,
        text=True
    )

    return result.returncode == 0


def resolve_hostname(host):
    try:
        ip_address = socket.gethostbyname(host)

        return True, ip_address

    except socket.gaierror:
        return False, None


def test_tcp_connection(host, port):
    try:
        connection = socket.create_connection(
            (host, port),
            timeout=5
        )

        connection.close()

        return True

    except OSError:
        return False


def load_target():
    if TARGET_FILE.exists():
        return TARGET_FILE.read_text().strip()

    return "example.com"


def main():
    LOG_FILE.parent.mkdir(
        parents=True,
        exist_ok=True
    )

    # Start a new log for every diagnostic run.
    LOG_FILE.write_text("")

    target = load_target()

    write_log("=" * 50)
    write_log("NETWORK AND DNS DIAGNOSTIC REPORT")
    write_log("=" * 50)
    write_log()

    write_log(
        f"Diagnostic Time: "
        f"{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}"
    )

    write_log(
        f"Target Host: {target}"
    )

    write_log()

    # ---------------------------------------------
    # LOCAL SYSTEM INFORMATION
    # ---------------------------------------------

    write_log("-" * 50)
    write_log("LOCAL SYSTEM INFORMATION")
    write_log("-" * 50)

    hostname = socket.gethostname()

    write_log(
        f"Hostname: {hostname}"
    )

    try:
        local_ip = socket.gethostbyname(
            hostname
        )

        write_log(
            f"Local IP Address: {local_ip}"
        )

    except socket.gaierror:
        write_log(
            "Local IP Address: "
            "Unable to determine"
        )

    write_log()

    # ---------------------------------------------
    # DIRECT IP CONNECTIVITY
    # ---------------------------------------------

    write_log("-" * 50)
    write_log("DIRECT IP CONNECTIVITY")
    write_log("-" * 50)

    direct_ip_result = ping_host(
        DIRECT_IP_TEST
    )

    if direct_ip_result:
        write_log(
            f"[PASS] Ping to "
            f"{DIRECT_IP_TEST} succeeded."
        )
    else:
        write_log(
            f"[WARNING] Ping to "
            f"{DIRECT_IP_TEST} failed."
        )

        write_log(
            "ICMP may be blocked, so this "
            "alone does not prove the "
            "network is unavailable."
        )

    write_log()

    # ---------------------------------------------
    # DNS RESOLUTION
    # ---------------------------------------------

    write_log("-" * 50)
    write_log("DNS RESOLUTION")
    write_log("-" * 50)

    dns_success, resolved_ip = (
        resolve_hostname(target)
    )

    if dns_success:
        write_log(
            f"[PASS] {target} resolved to "
            f"{resolved_ip}."
        )
    else:
        write_log(
            f"[FAIL] DNS could not resolve "
            f"{target}."
        )

    write_log()

    # ---------------------------------------------
    # TCP CONNECTIVITY
    # ---------------------------------------------

    write_log("-" * 50)
    write_log("TCP CONNECTIVITY")
    write_log("-" * 50)

    if dns_success:
        tcp_success = test_tcp_connection(
            target,
            TCP_PORT
        )

        if tcp_success:
            write_log(
                f"[PASS] TCP connection to "
                f"{target}:{TCP_PORT} succeeded."
            )
        else:
            write_log(
                f"[FAIL] TCP connection to "
                f"{target}:{TCP_PORT} failed."
            )

    else:
        tcp_success = False

        write_log(
            "[SKIPPED] TCP test could not "
            "run because DNS resolution failed."
        )

    write_log()

    # ---------------------------------------------
    # SUMMARY
    # ---------------------------------------------

    write_log("=" * 50)
    write_log("DIAGNOSTIC SUMMARY")
    write_log("=" * 50)

    if dns_success:
        write_log(
            "DNS Resolution: PASS"
        )
    else:
        write_log(
            "DNS Resolution: FAIL"
        )

    if tcp_success:
        write_log(
            "TCP Connectivity: PASS"
        )
    else:
        write_log(
            "TCP Connectivity: FAIL"
        )

    write_log()

    if dns_success and tcp_success:
        write_log(
            "OVERALL RESULT: PASS"
        )

        write_log(
            "Target network path is "
            "operating normally."
        )

        exit_code = 0

    else:
        write_log(
            "OVERALL RESULT: FAIL"
        )

        write_log(
            "Further troubleshooting is required."
        )

        exit_code = 1

    write_log()

    write_log(
        f"Report saved to: {LOG_FILE}"
    )

    return exit_code


if __name__ == "__main__":
    raise SystemExit(main())