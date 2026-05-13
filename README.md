# WireGuard VPN Server with WGDashboard & Experimental Device Validation

Self-hosted WireGuard VPN server setup using WGDashboard for peer management, along with an experimental machine-bound access validation system built using Python, Flask, Gunicorn, and Linux networking tools.

---

# Overview

This project demonstrates:

- WireGuard VPN server setup on Ubuntu
- WGDashboard installation and peer management
- Full-tunnel VPN routing
- Mobile and laptop VPN connectivity
- Experimental device-bound validation system
- Machine-ID based access validation
- Production-style Flask API deployment using Gunicorn + systemd

The goal of the experimental validation layer was to explore ways of restricting a VPN configuration to a single approved machine.

---

# Features

## WireGuard VPN Server

- Self-hosted VPN server
- Secure encrypted tunnels
- Mobile and desktop client support
- Full internet routing through VPN server
- WGDashboard web management UI

## Experimental Device Validation System

- Machine-ID based first-device registration
- Centralized validation API
- Custom VPN launcher script
- Device mismatch detection
- Gunicorn + systemd production deployment

---

# Architecture

## WireGuard VPN Flow

```text
Client Device
    ↓
Encrypted WireGuard Tunnel
    ↓
Ubuntu VPN Server
    ↓
Internet
```

## Experimental Validation Flow

```text
Client Device
    ↓
Custom Validation Script
    ↓
Validation API Server
    ↓
Machine-ID Verification
    ↓
VPN Allowed / Blocked
```

---

# Technologies Used

| Technology | Purpose |
|---|---|
| WireGuard | Core VPN protocol used to create secure encrypted tunnels between client devices and the VPN server |
| WGDashboard | Web-based management panel used for creating, managing, and monitoring WireGuard peers |
| Python | Used to build the experimental device validation logic and backend services |
| Flask | Lightweight Python web framework used to create the machine validation API |
| Gunicorn | Production-grade WSGI server used to run the Flask API reliably in the background |
| systemd | Linux service manager used to automatically start and manage VPN-related services |
| Ubuntu Linux | Operating system used to host the WireGuard server and backend services |
| Bash Scripting | Used for VPN automation, validation workflows, and custom connection scripts |
| iptables | Linux firewall and NAT tool used for packet forwarding and internet routing |
| Linux Networking | Used for routing, tunneling, IP forwarding, firewalling, and VPN traffic management |

---

# Project Structure

```text
.
├── README.md
├── company-vpn-connect.sh
├── server.py
├── company-vpn.service
├── example-client.conf
├── example-wg0.conf
└── docs/
```

---

# Installation

## 1. Install WireGuard

```bash
sudo apt update
sudo apt install wireguard -y
```

---

## 2. Configure VPN Server

Create:

```text
/etc/wireguard/wg0.conf
```

Enable IP forwarding and NAT.

Start WireGuard:

```bash
sudo systemctl enable wg-quick@wg0
sudo systemctl start wg-quick@wg0
```

---

## 3. Install WGDashboard

Official project:

```text
https://github.com/donaldzou/WGDashboard
```

Install and configure WGDashboard for peer management.

---

# Experimental Device Validation Setup

## Validation API

The validation API stores and verifies machine IDs.

Run with Gunicorn:

```bash
gunicorn -w 2 -b 0.0.0.0:5005 server:app
```

---

## systemd Service

```bash
sudo systemctl enable company-vpn
sudo systemctl start company-vpn
```

---

## Client Validation Script

Start VPN using:

```bash
~/company-vpn-connect.sh test4_wg0
```

Instead of directly using:

```bash
wg-quick up test4_wg0
```

---

# Testing

## VPN Testing

- Mobile VPN connection
- Ubuntu laptop connection
- Public IP verification
- Internet routing through VPN server

## Validation Testing

- First-device registration
- Machine-ID matching
- Device mismatch blocking
- Registry updates

---

# Important Limitation

The experimental machine-binding system works only through the custom validation launcher script.

Direct imports into standard WireGuard clients/apps can bypass the validation layer because WireGuard itself does not natively support device identity enforcement.

This project was primarily built as a proof-of-concept and learning experiment around VPN access control and device validation concepts.

---

# Future Improvements

- Headscale + Tailscale integration
- Device approval workflow
- Zero Trust architecture
- TPM-backed device identity
- SSO/MFA integration
- Centralized device management
- Server-side enforcement

---

# Demo Video

## :movie_camera: Project Demo

This video demonstrates:
- How WireGuard Conf script connects
- VPN got connected
- WGDashboard with Peers
- IP address Before and After

:point_right: Watch Demo: https://drive.google.com/file/d/173ZM_Vx_rZ8LK6kF4SktsdZ0nM5h72wJ/view?usp=sharing


---

# Learning Objectives

This project helped explore:

- VPN architecture
- Linux networking
- WireGuard
- Secure tunneling
- Device validation concepts
- Production deployment practices
- Zero Trust access ideas
- Experimental access-control workflows
