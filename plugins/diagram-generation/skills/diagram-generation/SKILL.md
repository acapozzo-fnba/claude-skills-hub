---
name: diagram-generation
description: Generate technical network topology diagrams, infrastructure diagrams, and architecture visualizations using gemimg CLI with optimized prompts for technically-minded audiences.
version: 1.0.0
tags: [diagram, network-topology, infrastructure, architecture, technical, gemimg]
---

# Diagram Generation Skill

## Purpose

This skill generates professional technical diagrams for network infrastructure, system architecture, and topology visualizations. It uses the `gemimg` CLI tool with carefully crafted prompts optimized for technically-minded audiences who need clear, informative diagrams rather than marketing infographics.

## Prerequisites

- `gemimg` CLI installed (`pipx install git+https://github.com/minimaxir/gemimg.git`)
- `GEMINI_API_KEY` environment variable set
- For troubleshooting, see: https://github.com/minimaxir/gemimg

## CRITICAL: Always Use This Model

```bash
--model gemini-3-pro-image-preview
```

**Never omit the model flag.** This uses Nano Banana Pro for best results.

## Diagram Types

### 1. Network Topology Diagrams

For firewall deployments, routing infrastructure, and network segmentation:

```bash
gemimg "Technical network topology diagram of [DEVICE TYPE] deployment. Clean technical illustration style with labeled components. Center: [CENTRAL DEVICE] with interface labels. Left side INTERNAL: [INTERNAL ZONES] with subnet annotations. Right side EXTERNAL: [EXTERNAL CONNECTIONS] with failover indicators. Top: [VPN/WAN CONNECTIONS]. Bottom: [DMZ/SERVICE ZONES]. Include zone labels, IP subnet annotations, and protocol indicators ([PROTOCOLS]). Network diagram style with clean lines, dark background, color coding for zones, white labels, no photorealistic elements." --model gemini-3-pro-image-preview --aspect-ratio 16:9 -o diagram.png
```

### 2. Infrastructure Architecture Diagrams

For cloud, datacenter, or hybrid deployments:

```bash
gemimg "Technical infrastructure architecture diagram. Clean technical illustration style. Show [INFRASTRUCTURE COMPONENTS] with connection lines. Include [SERVICES/APPLICATIONS]. Label all components with names and specifications. Use layered architecture (presentation, application, data tiers). Dark background, blue/green/orange color coding, white labels, no photorealistic elements, engineering diagram style." --model gemini-3-pro-image-preview --aspect-ratio 16:9 -o architecture.png
```

### 3. Security Zone Diagrams

For firewall zone architecture and security boundaries:

```bash
gemimg "Technical security zone diagram showing network segmentation. Zones: [ZONE LIST] with color coding. Show traffic flow arrows between zones with permit/deny indicators. Include firewall rules summary. Security boundaries clearly marked. Dark background, green for trusted, red for untrusted, orange for DMZ, blue for management. Clean lines, white labels, technical diagram style." --model gemini-3-pro-image-preview --aspect-ratio 16:9 -o zones.png
```

### 4. VPN/Tunnel Topology Diagrams

For site-to-site VPN mesh or hub-spoke architectures:

```bash
gemimg "Technical VPN topology diagram showing [TOPOLOGY TYPE: mesh/hub-spoke]. Sites: [SITE LIST] with location labels. Show IPSec/IKEv2 tunnel connections with encryption indicators. Include tunnel interface IPs and peer addresses. Primary and backup path indicators. Dark background, connection lines with protocol labels, site icons as simple building shapes, technical diagram style." --model gemini-3-pro-image-preview --aspect-ratio 16:9 -o vpn-topology.png
```

### 5. Routing Protocol Diagrams

For OSPF, BGP, or multi-protocol environments:

```bash
gemimg "Technical routing diagram showing [PROTOCOL] topology. Areas/AS numbers labeled. Router icons with interface IPs. Show adjacencies and peering relationships. Include route redistribution points. Metric/cost annotations on links. Dark background, protocol-specific color coding, white labels, network engineering diagram style." --model gemini-3-pro-image-preview --aspect-ratio 16:9 -o routing.png
```

## Template: Palo Alto Firewall Diagram

Based on the EL-PA firewall analysis, here's a reusable template:

```bash
gemimg "Technical network topology diagram of a Palo Alto firewall deployment. Clean technical illustration style with labeled components. Center: PA-series firewall with interface labels (eth1/1-eth1/8). Left side INTERNAL: Trusted-Internal zone (OSPF Area 0.0.0.1) connecting to core switch, server VLANs, printer VLAN (10.102.x.x), management VLANs (mgmt-241, mgmt-dev, mgmt-lab). Right side EXTERNAL: Untrusted-External zone with dual ISP connections (ACD primary, USSignal backup) showing failover arrows. Top: IPSec VPN tunnels to remote sites (GR, TC, EW, DC1) with tunnel IDs. Bottom: DMZ zone connecting to Jack Henry banking core and FedLine router. Show BGP peering between VR-EL and VR-Printer virtual routers. Include zone labels, IP subnet annotations, and protocol indicators (OSPF, BGP, IKEv2). Network diagram style with clean lines, dark background, green/blue/orange color coding for zones, white labels, no photorealistic elements." --model gemini-3-pro-image-preview --aspect-ratio 16:9 -o palo-alto-topology.png
```

## Prompt Engineering for Technical Diagrams

### Key Phrases for Technical Style

Always include these phrases to avoid infographic/marketing style:

- "Technical [type] diagram"
- "Clean technical illustration style"
- "Network diagram style with clean lines"
- "No photorealistic elements"
- "Engineering diagram style"
- "White labels"
- "Dark background"

### Zone Color Coding Convention

| Zone Type | Color | Usage |
|-----------|-------|-------|
| Trusted/Internal | Green | Corporate networks, trusted VLANs |
| Untrusted/External | Blue or Red | Internet, WAN, external connections |
| DMZ | Orange | Demilitarized zones, service networks |
| Management | Purple | Out-of-band management networks |
| Guest/IoT | Yellow | Isolated guest or IoT networks |

### Component Labeling Best Practices

Always request:
- Interface labels (eth1/1, ge-0/0/0, etc.)
- IP subnet annotations (10.0.0.0/24)
- Protocol indicators (OSPF, BGP, IKEv2)
- Zone names
- Device hostnames
- Connection types (primary/backup)

## Common Options

```bash
--model gemini-3-pro-image-preview  # REQUIRED - Nano Banana Pro
--aspect-ratio 16:9                  # Widescreen for presentations
--aspect-ratio 4:3                   # Standard for documentation
--aspect-ratio 1:1                   # Square for icons/symbols
--image_size 4K                      # High resolution for printing
--image_size 2K                      # Default, good for screens
-n 3                                 # Generate multiple variations
-o filename.png                      # Output filename
```

## Quick Reference Commands

### Generate Network Topology
```bash
gemimg "Technical network topology diagram of [YOUR NETWORK]. Clean technical illustration style. [ZONES AND COMPONENTS]. Dark background, color-coded zones, white labels, no photorealistic elements." --model gemini-3-pro-image-preview --aspect-ratio 16:9 -o topology.png
```

### Generate with Multiple Variations
```bash
gemimg "Technical [DIAGRAM TYPE] diagram. [DESCRIPTION]" --model gemini-3-pro-image-preview --aspect-ratio 16:9 -n 3 --output-dir ./diagrams/
```

### Generate High-Resolution for Print
```bash
gemimg "Technical [DIAGRAM TYPE] diagram. [DESCRIPTION]" --model gemini-3-pro-image-preview --aspect-ratio 16:9 --image_size 4K -o diagram-print.png
```

## Workflow: Analyzing Config to Diagram

1. **Read the configuration** (firewall, router, etc.)
2. **Extract key elements:**
   - Zones/VLANs/segments
   - Interfaces and IPs
   - Routing protocols
   - VPN tunnels
   - External connections
   - Security policies (high-level)
3. **Build the prompt** using templates above
4. **Generate diagram** with gemimg
5. **Iterate** if needed (adjust prompt, regenerate)

## Example: From Palo Alto Config to Diagram

### Step 1: Identify Components from Config

From `host_vars/firewall.yml`:
- Zones: Trusted-Internal, Untrusted-External, DMZ-Zone, Printer, mgmt-*
- Interfaces: ethernet1/1-1/8 with VLANs
- VPNs: IPSec tunnels to GR, TC sites
- Routing: OSPF + BGP between virtual routers
- External: Dual ISP (ACD, USSignal)

### Step 2: Build Prompt

Map components to prompt sections:
- Center: "PA-series firewall with interface labels"
- Left (Internal): Trusted zones, VLANs, OSPF
- Right (External): ISPs, failover
- Top: VPN tunnels
- Bottom: DMZ, banking connections

### Step 3: Generate

```bash
gemimg "[CONSTRUCTED PROMPT]" --model gemini-3-pro-image-preview --aspect-ratio 16:9 -o firewall-diagram.png
```

## Troubleshooting

### Model Errors (404)
Always use `--model gemini-3-pro-image-preview`. Check https://github.com/minimaxir/gemimg/releases for updates.

### Diagram Too "Marketing-Style"
Add these phrases:
- "Technical diagram style"
- "No photorealistic elements"
- "Engineering illustration"
- "Clean lines, white labels"

### Missing Labels/Annotations
Be explicit: "Include IP subnet annotations", "Label all interfaces", "Show protocol indicators"

### Wrong Aspect Ratio
- `16:9` for presentations/widescreen
- `4:3` for documentation
- `3:4` for portrait/mobile

## Resources

- **gemimg Repository**: https://github.com/minimaxir/gemimg
- **Gemini API Docs**: https://ai.google.dev/gemini-api/docs
- **Google AI Studio**: https://aistudio.google.com/

## Version History

- **v1.0.0** (2025-12-03): Initial release with network topology, infrastructure, security zone, VPN, and routing diagram templates. Includes Palo Alto firewall example.
