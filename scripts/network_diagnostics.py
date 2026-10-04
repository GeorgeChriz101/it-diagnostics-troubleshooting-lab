import socket


print("=" * 40)
print("NETWORK DIAGNOSTICS TEST")
print("=" * 40)

hostname = socket.gethostname()

print(f"Hostname: {hostname}")

ip_address = socket.gethostbyname(hostname)

print(f"Local IP Address: {ip_address}")

print("Python network diagnostics are working.")