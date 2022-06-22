# How To - Linux - Ports [^1]

## Well-known ports

| Port | TCP | UDP | Description |
|------|:---:|:---:|:-----------:|
| 0 | X | X | In programming APIs (not in communication between hosts), requests a system-allocated (dynamic) port |
| 1 | X | X | TCP Port Service Multiplexer (TCPMUX). Historic. Both TCP and UDP have been assigned to TCPMUX by IANA, but by design only TCP is specified. |
| 2 | X | X | compressnet (Management Utility) |
| 3 | X | X | compressnet (Compression Process) |
| 5 | X | X | Remote Job Entry was historically using socket 5 in its old socket form, while MIB PIM has identified it as TCP/5 and IANA has assigned both TCP and UDP 5 to it. |
| 7 | X | X | Echo Protocol |
| 9 | X | X | Discard Protocol |
| 10 |  | X | Wake-on-LAN |
| 11 | X | X | Active Users (systat service) |
| 13 | X | X | Daytime Protocol |
| 15 | X |  | Previously netstat service |
| 17 | X | X | Quote of the Day (QOTD) |
| 18 | X | X | Message Send Protocol |
| 19 | X | X | Character Generator Protocol (CHARGEN) |
| 20 | X | X | File Transfer Protocol (FTP) data transfer |
| 21 | X | X | File Transfer Protocol (FTP) control (command) |
| 22 | X | X | Secure Shell (SSH), secure logins, file transfers (scp, sftp) and port forwarding |
| 23 | X | X | Telnet protocol—unencrypted text communications |
| 25 | X | X | Simple Mail Transfer Protocol (SMTP), used for email routing between mail servers |
| 27 | X | X | NSW User System FE |
| 28 | X |  | Palo Alto Networks' Panorama High Availability (HA) sync encrypted port. |
| 29 | X | X | MSG ICP |
| 31 | X | X | MSG Authentication |
| 33 | X | X | Display Support Protocol |
| 37 | X | X | Time Protocol |
| 38 | X | X | Route Access Protocol |
| 39 | X | X | Resource Location Protocol |
| 41 | X | X | Graphics |
| 42 | X | X | Host Name Server Protocol |
| 43 | X | X | WHOIS protocol |
| 44 | X | X | MPM FLAGS Protocol |
| 45 | X | X | MPM (recv) |
| 46 | X | X | MPM (default send) |
| 48 | X | X | Digital Audit Daemon |
| 49 | X | X | TACACS Login Host protocol. TACACS+, still in draft which is an improved but distinct version of TACACS, only uses TCP 49. |
| 50 | X | X | Remote Mail Checking Protocol |
| 51 | X | X | Historically used for Interface Message Processor logical address management, entry has been removed by IANA on 2013-05-25 |
| 52 | X | X | Xerox Network Systems (XNS) Time Protocol. Despite this port being assigned by IANA, the service is meant to work on SPP (ancestor of IPX/SPX), instead of TCP/IP. |
| 53 | X | X | Domain Name System (DNS) |
| 54 | X | X | Xerox Network Systems (XNS) Clearinghouse (Name Server). Despite this port being assigned by IANA, the service is meant to work on SPP (ancestor of IPX/SPX), instead of TCP/IP. |
| 55 | X | X | ISI Graphics Language |
| 56 | X | X | Xerox Network Systems (XNS) Authentication Protocol. Despite this port being assigned by IANA, the service is meant to work on SPP (ancestor of IPX/SPX), instead of TCP/IP. |
| 58 | X | X | Xerox Network Systems (XNS) Mail. Despite this port being assigned by IANA, the service is meant to work on SPP (ancestor of IPX/SPX), instead of TCP/IP. |
| 61 | X | X | Historically assigned to the NIFTP-Based Mail protocol, but was never documented in the related IEN. The port number entry was removed from IANA's registry on 2017-05-18. |
| 62 | X | X | ACA Services |
| 63 | X | X | whois++ |
| 64 | X | X | covia |
| 65 | X | X | TACACS-Database Service |
| 66 | X | X | Oracle SQL*NET |
| 67 | X | X | Bootstrap Protocol (BOOTP) server; also used by Dynamic Host Configuration Protocol (DHCP) |
| 68 | X | X | Bootstrap Protocol (BOOTP) client; also used by Dynamic Host Configuration Protocol (DHCP) |
| 69 | X | X | Trivial File Transfer Protocol (TFTP) |
| 70 | X | X | Gopher protocol |
| 71–74 | X | X | NETRJS protocol |
| 76 | X | X | Distributed External Object Store |
| 78 | X | X | vettcp |
| 79 | X | X | Finger protocol |
| 80 | X | X | Hypertext Transfer Protocol (HTTP) uses TCP in versions 1.x and 2. HTTP/3 uses QUIC, a transport protocol on top of UDP. |
| 81 | X |  | TorPark onion routing |
| 82 |  | X | TorPark control |
| 83 | X | X | MIT ML Device, networking file system |
| 84 | X | X | Common Trace Facility |
| 85 | X | X | MIT ML Device |
| 86 | X | X | Micro Focus Cobol |
| 88 | X | X | Kerberos authentication system |
| 89 | X | X | SU/MIT Telnet Gateway |
| 90 | X | X | PointCast (dotcom) |
| 91 | X | X | MIT Dover Spooler |
| 92 | X | X | Network Printing Protocol |
| 93 | X | X | Device Control Protocol |
| 94 | X | X | Tivoli Object Dispatcher |
| 95 | X | X | SUPDUP, terminal-independent remote login |
| 96 | X | X | DIXIE Protocol |
| 97 | X | X | Swift Remote Virtual File Protocol |
| 98 | X | X | TAC News |
| 99 | X | X | Metagram Relay |
| 101 | X | X | NIC host name |
| 102 | X | X | ISO Transport Service Access Point (TSAP) Class 0 protocol; |
| 103 | X | X | Genesis Point-to-Point Trans Net |
| 104 | X | X | Digital Imaging and Communications in Medicine (DICOM; also port 11112) |
| 105 | X | X | CCSO Nameserver |
| 106 | X |  | macOS Server, (macOS) password server |
| 107 | X | X | Remote User Telnet Service (RTelnet) |
| 108 | X | X | IBM Systems Network Architecture (SNA) gateway access server |
| 109 | X | X | Post Office Protocol, version 2 (POP2) |
| 110 | X | X | Post Office Protocol, version 3 (POP3) |
| 111 | X | X | Open Network Computing Remote Procedure Call (ONC RPC, sometimes referred to as Sun RPC) |
| 112 | X | X | McIDAS Data Transmission Protocol |
| 113 | X |  | Ident, authentication service/identification protocol, used by IRC servers to identify users |
| 113 | X | X | Authentication Service (auth), the predecessor to identification protocol. Used to determine a user's identity of a particular TCP connection. |
| 115 | X | X | Simple File Transfer Protocol |
| 116 | X | X | ANSA REX Notify |
| 117 | X | X | UUCP Mapping Project (path service) |
| 118 | X | X | Structured Query Language (SQL) Services |
| 119 | X | X | Network News Transfer Protocol (NNTP), retrieval of newsgroup messages |
| 120 | X | X | CFDPTKT |
| 121 | X | X | Encore Expedited Remote Pro.Call |
| 122 | X | X | SMAKYNET |
| 123 | X | X | Network Time Protocol (NTP), used for time synchronization |
| 124 | X | X | ANSA REX Trader |
| 125 | X | X | Locus PC-Interface Net Map Ser |
| 126 | X | X | Formerly Unisys Unitary Login, renamed by Unisys to NXEdit. Used by Unisys Programmer's Workbench for Clearpath MCP, an IDE for Unisys MCP software development |
| 127 | X | X | Locus PC-Interface Conn Server |
| 128 | X | X | GSS X License Verification |
| 129 | X | X | Password Generator Protocol |
| 130 | X | X | Cisco FNATIVE |
| 131 | X | X | Cisco TNATIVE |
| 132 | X | X | Cisco SYSMAINT |
| 133 | X | X | Statistics Service (statsrv) |
| 134 | X | X | INGRES-NET Service |
| 135 | X | X | DCE endpoint resolution |
| 135 | X | X | Microsoft EPMAP (End Point Mapper), also known as DCE/RPC Locator service, used to remotely manage services including DHCP server, DNS server and WINS. Also used by DCOM |
| 136 | X | X | PROFILE Naming System |
| 137 | X | X | NetBIOS Name Service, used for name registration and resolution |
| 138 | X | X | NetBIOS Datagram Service |
| 139 | X | X | NetBIOS Session Service |
| 140 | X | X | EMFIS Data Service |
| 141 | X | X | EMFIS Control Service |
| 142 | X | X | Britton-Lee IDM |
| 143 | X | X | Internet Message Access Protocol (IMAP), management of electronic mail messages on a server |
| 144 | X | X | Universal Management Architecture |
| 145 | X | X | UAAC Protocol |
| 146 | X | X | ISO-IP0 |
| 147 | X | X | ISO-IP |
| 148 | X | X | Jargon |
| 149 | X | X | AED 512 Emulation Service |
| 150 | X | X | SQL-NET |
| 151 | X | X | HEMS |
| 152 | X | X | Background File Transfer Program (BFTP) |
| 153 | X | X | Simple Gateway Monitoring Protocol (SGMP), a protocol for remote inspection and alteration of gateway management information |
| 154 | X | X | netsc-prod |
| 155 | X | X | netsc-dev |
| 156 | X | X | Structured Query Language (SQL) Service |
| 157 | X | X | KNET/VM Command/Message Protocol |
| 158 | X | X | Distributed Mail System Protocol (DMSP, sometimes referred to as Pcmail) |
| 159 | X | X | NSS-Routing |
| 160 | X | X | SGMP-TRAPS |
| 161 | X | X | Simple Network Management Protocol (SNMP) |
| 162 | X | X | Simple Network Management Protocol Trap (SNMPTRAP) |
| 163 | X | X | CMIP/TCP Manager |
| 164 | X | X | CMIP/TCP Agent |
| 165 | X | X | Xerox |
| 166 | X | X | Sirius Systems |
| 167 | X | X | NAMP |
| 168 | X | X | RSVD |
| 169 | X | X | SEND |
| 170 | X | X | Network PostScript print server |
| 171 | X | X | Network Innovations Multiplex |
| 172 | X | X | Network Innovations CL/1 |
| 173 | X | X | Xyplex |
| 174 | X | X | MAILQ |
| 175 | X | X | VMNET |
| 176 | X | X | GENRAD-MUX |
| 177 | X | X | X Display Manager Control Protocol (XDMCP), used for remote logins to an X Display Manager server |
| 178 | X | X | NextStep Window Server |
| 179 | X | X | Border Gateway Protocol (BGP), used to exchange routing and reachability information among autonomous systems (AS) on the Internet |
| 180 | X | X | ris |
| 181 | X | X | Unify |
| 182 | X | X | Unisys Audit SITP |
| 183 | X | X | OCBinder |
| 184 | X | X | OCServer |
| 185 | X | X | Remote-KIS |
| 186 | X | X | KIS Protocol |
| 187 | X | X | Application Communication Interface |
| 188 | X | X | Plus Five's MUMPS |
| 189 | X | X | Queued File Transport |
| 190 | X | X | Gateway Access Control Protocol |
| 191 | X | X | Prospero Directory Service |
| 192 | X | X | OSU Network Monitoring System |
| 193 | X | X | Spider Remote Monitoring Protocol |
| 194 | X | X | Internet Relay Chat (IRC) |
| 195 | X | X | DNSIX Network Layer Module Audit |
| 196 | X | X | DNSIX Session Mgt Module Audit Redir |
| 197 | X | X | Directory Location Service |
| 198 | X | X | Directory Location Service Monitor |
| 199 | X | X | SNMP Unix Multiplexer (SMUX) |
| 200 | X | X | IBM System Resource Controller |
| 201 | X | X | AppleTalk Routing Maintenance |
| 209 | X | X | Quick Mail Transfer Protocol |
| 210 | X | X | ANSI Z39.50 |
| 213 | X | X | Internetwork Packet Exchange (IPX) |
| 218 | X | X | Message posting protocol (MPP) |
| 220 | X | X | Internet Message Access Protocol (IMAP), version 3 |
| 259 | X | X | Efficient Short Remote Operations (ESRO) |
| 262 | X | X | Arcisdms |
| 264 | X | X | Border Gateway Multicast Protocol (BGMP) |
| 280 | X | X | http-mgmt |
| 300 | X |  | ThinLinc Web Access |
| 308 | X |  | Novastor Online Backup |
| 311 | X | X | macOS Server Admin (officially AppleShare IP Web administration) |
| 312 | X |  | macOS Xsan administration |
| 318 | X | X | PKIX Time Stamp Protocol (TSP) |
| 319 |  | X | Precision Time Protocol (PTP) event messages |
| 320 |  | X | Precision Time Protocol (PTP) general messages |
| 350 | X | X | Mapping of Airline Traffic over Internet Protocol (MATIP) type A |
| 351 | X | X | MATIP type B |
| 356 | X | X | cloanto-net-1 (used by Cloanto Amiga Explorer and VMs) |
| 366 | X | X | On-Demand Mail Relay (ODMR) |
| 369 | X | X | Rpc2portmap |
| 370 | X | X | codaauth2, Coda authentication server |
| 370 |  | X | securecast1, outgoing packets to NAI's SecureCast serversAs of 2000 |
| 371 | X | X | ClearCase albd |
| 376 | X | X | Amiga Envoy Network Inquiry Protocol |
| 383 | X | X | HP data alarm manager |
| 384 | X | X | A Remote Network Server System |
| 387 | X | X | AURP (AppleTalk Update-based Routing Protocol) |
| 388 | X | X | Unidata LDM near real-time data distribution protocol |
| 389 | X | X | Lightweight Directory Access Protocol (LDAP) |
| 399 | X | X | Digital Equipment Corporation DECnet+ (Phase V) over TCP/IP (RFC1859) |
| 401 | X | X | Uninterruptible power supply (UPS) |
| 427 | X | X | Service Location Protocol (SLP) |
| 433 | X | X | NNTP, part of Network News Transfer Protocol |
| 434 | X | X | Mobile IP Agent (RFC 5944) |
| 443 | X | X | Hypertext Transfer Protocol Secure (HTTPS) uses TCP in versions 1.x and 2. HTTP/3 uses QUIC, a transport protocol on top of UDP. |
| 444 | X | X | Simple Network Paging Protocol (SNPP), RFC 1568 |
| 445 | X | X | Microsoft-DS (Directory Services) Active Directory, Windows shares |
| 445 | X | X | Microsoft-DS (Directory Services) SMB file sharing |
| 464 | X | X | Kerberos Change/Set password |
| 465 | X |  | SMTP over implicit SSL (obsolete) |
| 465 | X |  | URL Rendezvous Directory for Cisco SSM (primary usage assignment) |
| 465 | X |  | Authenticated SMTP over TLS/SSL (SMTPS) (alternative usage assignment) |
| 475 | X | X | tcpnethaspsrv, Aladdin Knowledge Systems Hasp services |
| 476–490 | X | X | Centro Software ERP ports |
| 491 | X |  | GO-Global remote access and application publishing software |
| 497 | X | X | Retrospect |
| 500 | X | X | Internet Security Association and Key Management Protocol (ISAKMP) / Internet Key Exchange (IKE) |
| 502 | X | X | Modbus Protocol |
| 504 | X | X | Citadel, multiservice protocol for dedicated clients for the Citadel groupware system |
| 510 | X | X | FirstClass Protocol (FCP), used by FirstClass client/server groupware system |
| 512 | X |  | Rexec, Remote Process Execution |
| 512 |  | X | comsat, together with biff |
| 513 | X |  | rlogin |
| 513 |  | X | Who |
| 514 | X |  | Remote Shell, used to execute non-interactive commands on a remote system (Remote Shell, rsh, remsh) |
| 514 |  | X | Syslog, used for system logging |
| 515 | X | X | Line Printer Daemon (LPD), print service |
| 517 |  | X | Talk |
| 518 |  | X | NTalk |
| 520 | X |  | efs, extended file name server |
| 520 |  | X | Routing Information Protocol (RIP) |
| 521 |  | X | Routing Information Protocol Next Generation (RIPng) |
| 524 | X | X | NetWare Core Protocol (NCP) is used for a variety things such as access to primary NetWare server resources, Time Synchronization, etc. |
| 525 |  | X | Timed, Timeserver |
| 530 | X | X | Remote procedure call (RPC) |
| 532 | X | X | netnews |
| 533 |  | X | netwall, for emergency broadcasts |
| 540 | X |  | Unix-to-Unix Copy Protocol (UUCP) |
| 542 | X | X | commerce (Commerce Applications) |
| 543 | X |  | klogin, Kerberos login |
| 544 | X |  | kshell, Kerberos Remote shell |
| 546 | X | X | DHCPv6 client |
| 547 | X | X | DHCPv6 server |
| 548 | X | X | Apple Filing Protocol (AFP) over TCP |
| 550 | X | X | new-rwho, new-who |
| 554 | X | X | Real Time Streaming Protocol (RTSP) |
| 556 | X |  | Remotefs, RFS, rfs_server |
| 560 |  | X | rmonitor, Remote Monitor |
| 561 |  | X | monitor |
| 563 | X | X | NNTP over TLS/SSL (NNTPS) |
| 564 | X |  | 9P (Plan 9) |
| 585 |  |  | Previously assigned for use of Internet Message Access Protocol over TLS/SSL (IMAPS), now deregisterd in favour of port 993. |
| 587 | X | X | email message submission (SMTP) |
| 591 | X |  | FileMaker 6.0 (and later) Web Sharing (HTTP Alternate, also see port 80) |
| 593 | X | X | HTTP RPC Ep Map, Remote procedure call over Hypertext Transfer Protocol, often used by Distributed Component Object Model services and Microsoft Exchange Server |
| 601 | X |  | Reliable Syslog Service — used for system logging |
| 604 | X |  | TUNNEL profile, a protocol for BEEP peers to form an application layer tunnel |
| 623 |  | X | ASF Remote Management and Control Protocol (ASF-RMCP) & IPMI Remote Management Protocol |
| 625 | X |  | Open Directory Proxy (ODProxy) |
| 631 | X | X | Internet Printing Protocol (IPP) |
| 631 | X | X | Common Unix Printing System (CUPS) administration console (extension to IPP) |
| 635 | X | X | RLZ DBase |
| 636 | X | X | Lightweight Directory Access Protocol over TLS/SSL (LDAPS) |
| 639 | X | X | Multicast Source Discovery Protocol, MSDP |
| 641 | X | X | SupportSoft Nexus Remote Command (control/listening), a proxy gateway connecting remote control traffic |
| 643 | X | X | SANity |
| 646 | X | X | Label Distribution Protocol (LDP), a routing protocol used in MPLS networks |
| 647 | X |  | DHCP Failover protocol |
| 648 | X |  | Registry Registrar Protocol (RRP) |
| 651 | X | X | IEEE-MMS |
| 653 | X | X | SupportSoft Nexus Remote Command (data), a proxy gateway connecting remote control traffic |
| 654 | X |  | Media Management System (MMS) Media Management Protocol (MMP) |
| 655 | X | X | Tinc VPN daemon |
| 657 | X | X | IBM RMC (Remote monitoring and Control) protocol, used by System p5 AIX Integrated Virtualization Manager (IVM) and Hardware Management Console to connect managed logical partitions (LPAR) to enable dynamic partition reconfiguration |
| 660 | X | X | macOS Server administration, version 10.4 and earlier |
| 666 | X | X | Doom, first online first-person shooter |
| 666 | X |  | airserv-ng, aircrack-ng's server for remote-controlling wireless devices |
| 674 | X |  | Application Configuration Access Protocol (ACAP) |
| 688 | X | X | REALM-RUSD (ApplianceWare Server Appliance Management Protocol) |
| 690 | X | X | Velneo Application Transfer Protocol (VATP) |
| 691 | X |  | MS Exchange Routing |
| 694 | X | X | Linux-HA high-availability heartbeat |
| 695 | X |  | IEEE Media Management System over SSL (IEEE-MMS-SSL) |
| 698 |  | X | Optimized Link State Routing (OLSR) |
| 700 | X |  | Extensible Provisioning Protocol (EPP), a protocol for communication between domain name registries and registrars (RFC 5734) |
| 701 | X |  | Link Management Protocol (LMP), a protocol that runs between a pair of nodes and is used to manage traffic engineering (TE) links |
| 702 | X |  | IRIS (Internet Registry Information Service) over BEEP (Blocks Extensible Exchange Protocol) (RFC 3983) |
| 706 | X |  | Secure Internet Live Conferencing (SILC) |
| 711 | X |  | Cisco Tag Distribution Protocol—being replaced by the MPLS Label Distribution Protocol |
| 712 | X |  | Topology Broadcast based on Reverse-Path Forwarding routing protocol (TBRPF; RFC 3684) |
| 749 | X | X | Kerberos administration |
| 750 |  | X | kerberos-iv, Kerberos version IV |
| 751 | X | X | kerberos_master, Kerberos authentication |
| 752 |  | X | passwd_server, Kerberos password (kpasswd) server |
| 753 | X | X | Reverse Routing Header (RRH) |
| 753 |  | X | userreg_server, Kerberos userreg server |
| 754 | X | X | tell send |
| 754 | X |  | krb5_prop, Kerberos v5 slave propagation |
| 760 | X | X | krbupdate , Kerberos registration |
| 782 | X |  | Conserver serial-console management server |
| 783 | X |  | SpamAssassin spamd daemon |
| 800 | X | X | mdbs-daemon |
| 802 | X | X | MODBUS/TCP Security |
| 808 | X |  | Microsoft Net.TCP Port Sharing Service |
| 829 | X | X | Certificate Management Protocol |
| 830 | X | X | NETCONF over SSH |
| 831 | X | X | NETCONF over BEEP |
| 832 | X | X | NETCONF for SOAP over HTTPS |
| 833 | X | X | NETCONF for SOAP over BEEP |
| 843 | X |  | Adobe Flash |
| 847 | X |  | DHCP Failover protocol |
| 848 | X | X | Group Domain Of Interpretation (GDOI) protocol |
| 853 | X |  | DNS over TLS (RFC 7858) |
| 853 |  | X | DNS over QUIC or DNS over DTLS |
| 860 | X |  | iSCSI (RFC 3720) |
| 861 | X | X | OWAMP control (RFC 4656) |
| 862 | X | X | TWAMP control (RFC 5357) |
| 873 | X |  | rsync file synchronization protocol |
| 888 | X |  | cddbp, CD DataBase (CDDB) protocol (CDDBP) |
| 888 | X |  | IBM Endpoint Manager Remote Control |
| 897 | X | X | Brocade SMI-S RPC |
| 898 | X | X | Brocade SMI-S RPC SSL |
| 902 | X | X | VMware ESXi |
| 903 | X |  | VMware ESXi |
| 953 | X | X | BIND remote name daemon control (RNDC) |
| 981 | X |  | Remote HTTPS management for firewall devices running embedded Check Point VPN-1 software |
| 987 |  | X | Sony PlayStation Wake On Lan |
| 987 | X |  | Microsoft Remote Web Workplace, a feature of Windows Small Business Server |
| 988 | X |  | Lustre (file system) Protocol (data). |
| 989 | X | X | FTPS Protocol (data), FTP over TLS/SSL |
| 990 | X | X | FTPS Protocol (control), FTP over TLS/SSL |
| 991 | X | X | Netnews Administration System (NAS) |
| 992 | X | X | Telnet protocol over TLS/SSL |
| 993 | X | X | Internet Message Access Protocol over TLS/SSL (IMAPS) |
| 994 | X | X | Previously assigned to Internet Relay Chat over TLS/SSL (IRCS), but was not used in common practice. |
| 995 | X | X | Post Office Protocol 3 over TLS/SSL (POP3S) |
| 1010 | X |  | ThinLinc web-based administration interface |
| 1023 | X | X | z/OS Network File System (NFS) (potentially ports 991–1023) |

## Registered ports

| Port | TCP | UDP | Description |
|------|:---:|:---:|:-----------:|
| 1025 | X | X | Teradata database management system (Teradata) server |
| 1027 |  | X | Native IPv6 behind IPv4-to-IPv4 NAT Customer Premises Equipment (6a44) |
| 1029 | X |  | Microsoft DCOM services |
| 1058 | X | X | nim, IBM AIX Network Installation Manager (NIM) |
| 1059 | X | X | nimreg, IBM AIX Network Installation Manager (NIM) |
| 1080 | X | X | SOCKS proxy |
| 1085 | X | X | WebObjects |
| 1098 | X | X | rmiactivation, Java remote method invocation (RMI) activation |
| 1099 | X | X | rmiregistry, Java remote method invocation (RMI) registry |
| 1113 | X | X | Licklider Transmission Protocol (LTP) delay tolerant networking protocol |
| 1119 | X | X | Battle.net chat/game protocol, used by Blizzard's games |
| 1167 | X | X | Cisco IP SLA (Service Assurance Agent) |
| 1194 | X | X | OpenVPN |
| 1198 | X | X | The cajo project Free dynamic transparent distributed computing in Java |
| 1212 | X | X | EqualSocial Fediverse |
| 1214 | X | X | Kazaa |
| 1220 | X | X | QuickTime Streaming Server administration |
| 1234 | X | X | Infoseek search agent |
| 1234 |  | X | VLC media player default port for UDP/RTP stream |
| 1241 | X | X | Nessus Security Scanner |
| 1242 | X |  | ArchiSteamFarm software |
| 1270 | X | X | Microsoft System Center Operations Manager (SCOM) (formerly Microsoft Operations Manager (MOM)) agent |
| 1293 | X | X | Internet Protocol Security (IPSec) |
| 1311 | X | X | Windows RxMon.exe |
| 1311 | X |  | Dell OpenManage HTTPS |
| 1314 | X |  | Festival Speech Synthesis System server |
| 1319 | X | X | AMX ICSP (Protocol for communications with AMX control systems devices) |
| 1337 | X | X | Men&Mice DNS |
| 1337 | X |  | Strapi |
| 1337 | X |  | Sails.js default port |
| 1341 | X | X | Qubes (Manufacturing Execution System) |
| 1344 | X | X | Internet Content Adaptation Protocol |
| 1352 | X | X | IBM Lotus Notes/Domino (RPC) protocol |
| 1360 | X | X | Mimer SQL |
| 1414 | X | X | IBM WebSphere MQ (formerly known as MQSeries) |
| 1417 | X | X | Timbuktu Service 1 Port |
| 1418 | X | X | Timbuktu Service 2 Port |
| 1419 | X | X | Timbuktu Service 3 Port |
| 1420 | X | X | Timbuktu Service 4 Port |
| 1431 | X |  | Reverse Gossip Transport Protocol (RGTP), used to access a General-purpose Reverse-Ordered Gossip Gathering System (GROGGS) bulletin board, such as that implemented on the Cambridge University's Phoenix system |
| 1433 | X | X | Microsoft SQL Server database management system (MSSQL) server |
| 1434 | X | X | Microsoft SQL Server database management system (MSSQL) monitor |
| 1476 | X | X | WiFi Pineapple Hak5. |
| 1481 | X | X | AIRS data interchange. |
| 1492 | X |  | Sid Meier's CivNet, a multiplayer remake of the original Sid Meier's Civilization game |
| 1494 | X | X | Citrix Independent Computing Architecture (ICA) |
| 1500 | X |  | IBM Tivoli Storage Manager server |
| 1501 | X |  | IBM Tivoli Storage Manager client scheduler |
| 1503 | X | X | Windows Live Messenger (Whiteboard and Application Sharing) |
| 1512 | X | X | Microsoft's Windows Internet Name Service (WINS) |
| 1513 | X | X | Garena game client |
| 1521 | X | X | nCUBE License Manager |
| 1521 | X |  | Oracle database default listener, in future releases official port 2483 (TCP/IP) and 2484 (TCP/IP with SSL) |
| 1524 | X | X | ingreslock, ingres |
| 1527 | X | X | Oracle Net Services, formerly known as SQL*Net |
| 1527 | X |  | Apache Derby Network Server |
| 1533 | X | X | IBM Sametime Virtual Places Chat |
| 1534 |  | X | Eclipse Target Communication Framework |
| 1540 | X | X | 1C:Enterprise server agent (ragent) |
| 1541 | X | X | 1C:Enterprise master cluster manager (rmngr) |
| 1542 | X | X | 1C:Enterprise configuration repository server |
| 1545 | X | X | 1C:Enterprise cluster administration server (RAS) |
| 1547 | X | X | Laplink |
| 1550 | X | X | 1C:Enterprise debug server |
| 1550 | X |  | Gadu-Gadu (direct client-to-client) |
| 1560–1590 | X | X | 1C:Enterprise cluster working processes |
| 1581 | X | X | MIL STD 2045-47001 VMF |
| 1581 | X |  | IBM Tivoli Storage Manager web client |
| 1582–1583 | X |  | IBM Tivoli Storage Manager server web interface |
| 1583 | X |  | Pervasive PSQL |
| 1589 | X | X | Cisco VLAN Query Protocol (VQP) |
| 1604 | X | X | DarkComet remote administration tool (RAT) |
| 1626 | X |  | iSketch |
| 1627 | X |  | iSketch |
| 1628 | X | X | LonTalk normal |
| 1629 | X | X | LonTalk urgent |
| 1645 |  | X | Early deployment of RADIUS before RFC standardization was done using UDP port number 1645. Enabled for compatibility reasons by default on Cisco and Juniper Networks RADIUS servers. Official port is 1812. TCP port 1645 must not be used. |
| 1646 |  | X | Old radacct port, RADIUS accounting protocol. Enabled for compatibility reasons by default on Cisco and Juniper Networks RADIUS servers. Official port is 1813. TCP port 1646 must not be used. |
| 1666 | X |  | Perforce |
| 1677 | X | X | Novell GroupWise clients in client/server access mode |
| 1688 | X |  | Microsoft Key Management Service (KMS) for Windows Activation |
| 1701 | X | X | Layer 2 Forwarding Protocol (L2F) |
| 1701 | X | X | Layer 2 Tunneling Protocol (L2TP) |
| 1707 | X | X | Windward Studios games (vdmplay) |
| 1707 |  | X | L2TP/IPsec, for establish an initial connection |
| 1714–1764 | X | X | KDE Connect |
| 1716 |  | X | America's Army, a massively multiplayer online game (MMO) |
| 1719 | X | X | H.323 registration and alternate communication |
| 1720 | X | X | H.323 call signaling |
| 1723 | X | X | Point-to-Point Tunneling Protocol (PPTP) |
| 1755 | X | X | Microsoft Media Services (MMS, ms-streaming) |
| 1761 | X | X | Novell ZENworks |
| 1776 | X |  | Emergency management information system |
| 1783 | X |  | "Decomissioned  Port 04/14/00, ms" |
| 1801 | X | X | Microsoft Message Queuing |
| 1812 | X | X | RADIUS authentication protocol, radius |
| 1813 | X | X | RADIUS accounting protocol, radius-acct |
| 1863 | X | X | Microsoft Notification Protocol (MSNP), used by the Microsoft Messenger service and a number of instant messaging Messenger clients |
| 1880 | X |  | Node-RED |
| 1883 | X | X | MQTT (formerly MQ Telemetry Transport) |
| 1900 | X | X | Simple Service Discovery Protocol (SSDP), discovery of UPnP devices |
| 1935 | X | X | Macromedia Flash Communications Server MX, the precursor to Adobe Flash Media Server before Macromedia's acquisition by Adobe on December 3, 2005 |
| 1935 | X | X | Real Time Messaging Protocol (RTMP), primarily used in Adobe Flash |
| 1965 | X |  | Gemini, a lightweight, collaboratively designed protocol, striving to fill the gap between Gopher and HTTP |
| 1967 |  | X | Cisco IOS IP Service Level Agreements (IP SLAs) Control Protocol |
| 1970 | X | X | Netop Remote Control |
| 1972 | X | X | InterSystems Caché |
| 1984 | X | X | Big Brother |
| 1985 | X | X | Cisco Hot Standby Router Protocol (HSRP) |
| 1998 | X | X | Cisco X.25 over TCP (XOT) service |
| 2000 | X | X | Cisco Skinny Client Control Protocol (SCCP) |
| 2010 | X |  | Artemis: Spaceship Bridge Simulator |
| 2033 | X | X | Civilization IV multiplayer |
| 2049 | X | X | Network File System (NFS) |
| 2056 | X | X | Civilization IV multiplayer |
| 2080 | X | X | Autodesk NLM (FLEXlm) |
| 2082 | X |  | cPanel default |
| 2083 | X | X | Secure RADIUS Service (radsec) |
| 2083 | X |  | cPanel default SSL |
| 2086 | X | X | GNUnet |
| 2086 | X |  | WebHost Manager default |
| 2087 | X |  | WebHost Manager default SSL |
| 2095 | X |  | cPanel default web mail |
| 2096 | X |  | cPanel default SSL web mail |
| 2100 | X |  | Warzone 2100 multiplayer |
| 2101 | X |  | Networked Transport of RTCM via Internet Protocol (NTRIP) |
| 2102 | X | X | Zephyr Notification Service server |
| 2103 | X | X | Zephyr Notification Service serv-hm connection |
| 2104 | X | X | Zephyr Notification Service hostmanager |
| 2123 | X | X | GTP control messages (GTP-C) |
| 2142 | X | X | TDMoIP (TDM over IP) |
| 2152 | X | X | GTP user data messages (GTP-U) |
| 2159 | X | X | GDB remote debug port |
| 2181 | X | X | EForward-document transport system |
|  | X |  | Apache ZooKeeper default client port |
| 2195 | X |  | Apple Push Notification Service |
| 2196 | X |  | Apple Push Notification Service, feedback service |
| 2210 | X | X | NOAAPORT Broadcast Network |
| 2211 | X | X | EMWIN |
| 2221 | X |  | ESET anti-virus updates |
| 2222 | X | X | EtherNet/IP implicit messaging for IO data |
| 2222 | X |  | DirectAdmin Access |
| 2222–2226 | X |  | ESET Remote administrator |
| 2240 | X | X | General Dynamics Remote Encryptor Configuration Information Protocol (RECIPe) |
| 2261 | X | X | CoMotion master |
| 2262 | X | X | CoMotion backup |
| 2302 |  | X | ArmA multiplayer |
| 2302 |  | X | Halo: Combat Evolved multiplayer host |
| 2303 |  | X | ArmA multiplayer (default port for game +1) |
| 2303 |  | X | Halo: Combat Evolved multiplayer listener |
| 2305 |  | X | ArmA multiplayer (default port for game +3) |
| 2351 | X |  | AIM game LAN network port |
| 2368 | X |  | Ghost (blogging platform) |
| 2369 | X |  | Default for BMC Control-M/Server Configuration Agent |
| 2370 | X |  | Default for BMC Control-M/Server, to allow the Control-M/Enterprise Manager to connect to the Control-M/Server |
| 2372 | X |  | Default for K9 Web Protection/parental controls, content filtering agent |
| 2375 | X | X | Docker REST API (plain) |
| 2376 | X | X | Docker REST API (SSL) |
| 2377 | X | X | Docker Swarm cluster management communications |
| 2379 | X | X | CoreOS etcd client communication |
| 2379 | X |  | KGS Go Server |
| 2380 | X | X | CoreOS etcd server communication |
| 2389 | X | X | OpenView Session Mgr |
| 2399 | X | X | FileMaker Data Access Layer (ODBC/JDBC) |
| 2401 | X | X | CVS version control system password-based server |
| 2404 | X | X | IEC 60870-5-104, used to send electric power telecontrol messages between two systems via directly connected data circuits |
| 2424 | X |  | OrientDB database listening for binary client connections |
| 2427 | X | X | Media Gateway Control Protocol (MGCP) media gateway |
| 2447 | X | X | ovwdb—OpenView Network Node Manager (NNM) daemon |
| 2456 | X | X | Valheim |
| 2459 | X | X | XRPL |
| 2480 | X |  | OrientDB database listening for HTTP client connections |
| 2483 | X | X | Oracle database listening for insecure client connections to the listener, replaces port 1521 |
| 2484 | X | X | Oracle database listening for SSL client connections to the listener |
| 2500 | X | X | NetFS communication |
| 2501 |  | X | NetFS probe |
| 2535 | X | X | Multicast Address Dynamic Client Allocation Protocol (MADCAP). All standard messages are UDP datagrams. |
| 2541 | X | X | LonTalk/IP |
| 2546–2548 | X | X | EVault data protection services |
| 2593 | X | X | Ultima Online servers |
| 2598 | X |  | Citrix Independent Computing Architecture (ICA) with Session Reliability; port 1494 without session reliability |
| 2599 | X | X | Ultima Online servers |
| 2628 | X | X | DICT |
| 2638 | X | X | SQL Anywhere database server |
| 2710 | X | X | XBT Tracker. UDP tracker extension is considered experimental. |
| 2727 | X | X | Media Gateway Control Protocol (MGCP) media gateway controller (call agent) |
| 2775 | X | X | Short Message Peer-to-Peer (SMPP) |
| 2809 | X | X | corbaloc:iiop URL, per the CORBA 3.0.3 specification |
| 2811 | X | X | gsi ftp, per the GridFTP specification |
| 2827 | X |  | I2P BOB Bridge |
| 2944 | X | X | Megaco text H.248 |
| 2945 | X | X | Megaco binary (ASN.1) H.248 |
| 2947 | X | X | gpsd, GPS daemon |
| 2948–2949 | X | X | WAP push Multimedia Messaging Service (MMS) |
| 2967 | X | X | Symantec System Center agent (SSC-AGENT) |
| 3000 | X |  | Ruby on Rails development default |
| 3000 | X |  | Meteor development default |
| 3000 | X | X | Resilio Sync, spun from BitTorrent Sync. |
| 3000 | X |  | Create React App, script to create single-page React applications |
| 3000 | X |  | GOGS (self-hosted GIT service)  |
| 3004 | X |  | iSync |
| 3020 | X | X | Common Internet File System (CIFS). See also port 445 for Server Message Block (SMB), a dialect of CIFS. |
| 3050 | X | X | gds-db (Interbase/Firebird databases) |
| 3052 | X | X | APC PowerChute Network |
| 3074 | X | X | Xbox LIVE and Games for Windows – Live |
| 3101 | X |  | BlackBerry Enterprise Server communication protocol |
| 3128 | X |  | Squid caching web proxy |
| 3225 | X | X | Fibre Channel over IP (FCIP) |
| 3233 | X | X | WhiskerControl research control protocol |
| 3260 | X | X | iSCSI |
| 3268 | X | X | msft-gc, Microsoft Global Catalog (LDAP service which contains data from Active Directory forests) |
| 3269 | X | X | msft-gc-ssl, Microsoft Global Catalog over SSL (similar to port 3268, LDAP over SSL) |
| 3283 | X | X | Net Assistant, a predecessor to Apple Remote Desktop |
| 3283 | X | X | Apple Remote Desktop 2.0 or later |
| 3290 |  | X | Virtual Air Traffic Simulation (VATSIM) network voice communication |
| 3305 | X | X | Odette File Transfer Protocol (OFTP) |
| 3306 | X | X | MySQL database system |
| 3323 | X | X | DECE GEODI Server |
| 3332 |  | X | Thundercloud DataPath Overlay Control |
| 3333 | X |  | Eggdrop, an IRC bot default port |
| 3333 | X |  | Network Caller ID server |
| 3333 | X |  | CruiseControl.rb |
| 3333 | X |  | OpenOCD (gdbserver) |
| 3351 | X |  | Pervasive PSQL |
| 3386 | X | X | GTP' 3GPP GSM/UMTS CDR logging protocol |
| 3389 | X | X | Microsoft Terminal Server (RDP) officially registered as Windows Based Terminal (WBT) |
| 3396 | X | X | Novell NDPS Printer Agent |
| 3412 | X | X | xmlBlaster |
| 3423 | X |  | Xware xTrm Communication Protocol |
| 3424 | X |  | Xware xTrm Communication Protocol over SSL |
| 3435 | X | X | Pacom Security User Port |
| 3455 | X | X | Resource Reservation Protocol (RSVP) |
| 3478 | X | X | STUN, a protocol for NAT traversal |
| 3478 | X | X | TURN, a protocol for NAT traversal (extension to STUN) |
| 3478 | X | X | STUN Behavior Discovery. See also port 5349. |
| 3479 | X | X | PlayStation Network |
| 3480 | X | X | PlayStation Network |
| 3483 |  | X | Slim Devices discovery protocol |
| 3483 | X |  | Slim Devices SlimProto protocol |
| 3493 | X | X | Network UPS Tools (NUT) |
| 3503 | X | X | MPLS LSP-echo Port |
| 3516 | X | X | Smartcard Port |
| 3527 |  | X | Microsoft Message Queuing |
| 3535 | X |  | SMTP alternate |
| 3544 |  | X | Teredo tunneling |
| 3551 | X | X | Apcupsd Information Port  |
| 3601 | X |  | SAP Message Server Port |
| 3632 | X | X | Distcc, distributed compiler |
| 3645 | X | X | Cyc |
| 3659 | X | X | Apple SASL, used by macOS Server Password Server |
| 3659 |  | X | Battlefield 4 |
| 3667 | X | X | Information Exchange |
| 3671 | X | X | KNXnet/IP(EIBnet/IP) |
| 3689 | X | X | Digital Audio Access Protocol (DAAP), used by Apple's iTunes and AirPlay |
| 3690 | X | X | Subversion (SVN) version control system |
| 3702 | X | X | Web Services Dynamic Discovery (WS-Discovery), used by various components of Windows Vista and later |
| 3724 | X | X | Some Blizzard games |
| 3724 | X |  | Club Penguin Disney online game for kids |
| 3725 | X | X | Netia NA-ER Port |
| 3749 | X | X | CimTrak registered port |
| 3768 | X | X | RBLcheckd server daemon |
| 3784 |  | X | Bidirectional Forwarding Detection (BFD)for IPv4 and IPv6 (Single Hop) (RFC 5881) |
| 3785 |  | X | VoIP program used by Ventrilo |
| 3799 |  | X | RADIUS change of authorization |
| 3804 | X | X | Harman Professional HiQnet protocol |
| 3825 | X |  | RedSeal Networks client/server connection |
| 3826 | X | X | WarMUX game server |
| 3826 | X |  | RedSeal Networks client/server connection |
| 3835 | X |  | RedSeal Networks client/server connection |
| 3830 | X | X | System Management Agent, developed and used by Cerner to monitor and manage solutions |
| 3856 | X | X | ERP Server Application used by F10 Software |
| 3880 | X | X | IGRS |
| 3868 | X |  | Diameter base protocol (RFC 3588) |
| 3872 | X |  | Oracle Enterprise Manager Remote Agent |
| 3900 | X |  | udt_os, IBM UniData UDT OS |
| 3960 |  | X | Warframe online interaction |
| 3962 |  | X | Warframe online interaction |
| 3978 | X | X | OpenTTD game (masterserver and content service) |
| 3978 | X |  | Palo Alto Networks' Panorama management of firewalls and log collectors & pre-PAN-OS 8.0 Panorama-to-managed devices software updates. |
| 3979 | X | X | OpenTTD game |
| 3999 | X | X | Norman distributed scanning service |
| 4000 | X | X | Diablo II game |
| 4001 | X |  | Microsoft Ants game |
| 4001 | X |  | CoreOS etcd client communication |
| 4018 | X | X | Protocol information and warnings |
| 4035 | X |  | IBM Rational Developer for System z Remote System Explorer Daemon |
| 4045 | X | X | Solaris lockd NFS lock daemon/manager |
| 4050 | X |  | Mud Master Chat protocol (MMCP) - Peer-to-peer communications between MUD clients. |
| 4069 |  | X | Minger Email Address Verification Protocol |
| 4070 | X | X | Amazon Echo Dot (Amazon Alexa) streaming connection with Spotify |
| 4089 | X | X | OpenCORE Remote Control Service |
| 4090 | X | X | Kerio |
| 4093 | X | X | PxPlus Client server interface ProvideX |
| 4096 | X | X | Ascom Timeplex Bridge Relay Element (BRE) |
| 4105 | X | X | Shofar (ShofarNexus) |
| 4111 | X | X | Xgrid |
| 4116 | X | X | Smartcard-TLS |
| 4125 | X |  | Microsoft Remote Web Workplace administration |
| 4172 | X | X | Teradici PCoIP |
| 4190 | X |  | ManageSieve |
| 4195 | X | X | AWS protocol for cloud remoting solution |
| 4197 | X | X | Harman International's HControl protocol for control and monitoring of Audio, Video, Lighting and Control equipment |
| 4198 | X | X | Couch Potato Android app |
| 4200 | X |  | Angular app |
| 4201 | X |  | TinyMUD and various derivatives |
| 4222 | X |  | NATS server default port |
| 4226 | X | X | Aleph One, a computer game |
| 4242 | X |  | Orthanc – DICOM server |
| 4242 | X |  | Quassel distributed IRC client |
| 4243 | X |  | Docker implementations, redistributions, and setups default |
| 4243 | X |  | CrashPlan |
| 4244 | X | X | Viber |
| 4303 | X | X | Simple Railroad Command Protocol (SRCP) |
| 4307 | X |  | TrueConf Client - TrueConf Server media data exchange |
| 4321 | X |  | Referral Whois (RWhois) Protocol |
| 4444 | X | X | Oracle WebCenter Content: Content Server—Intradoc Socket port. (formerly known as Oracle Universal Content Management). |
| 4444 | X |  | Metasploit's default listener port |
| 4444 | X | X | Xvfb X server virtual frame buffer service |
| 4444 | X |  | OpenOCD (Telnet) |
| 4444–4445 | X |  | I2P HTTP/S proxy |
| 4486 | X | X | Integrated Client Message Service (ICMS) |
| 4488 | X | X | Apple Wide Area Connectivity Service, used by Back to My Mac |
| 4500 | X | X | IPSec NAT Traversal (RFC 3947, RFC 4306) |
| 4502–4534 | X |  | Microsoft Silverlight connectable ports under non-elevated trust |
| 4505–4506 | X |  | Salt master |
| 4534 |  | X | Armagetron Advanced server default |
| 4560 | X |  | default Log4j socketappender port |
| 4567 | X |  | Sinatra default server port in development mode (HTTP) |
| 4569 |  | X | Inter-Asterisk eXchange (IAX2) |
| 4604 | X |  | Identity Registration Protocol |
| 4605 | X |  | Direct End to End Secure Chat Protocol |
| 4610–4640 | X |  | QualiSystems TestShell Suite Services |
| 4662 | X | X | OrbitNet Message Service |
| 4662 | X |  | Default for older versions of eMule |
| 4664 | X |  | Google Desktop Search |
| 4672 |  | X | Default for older versions of eMule |
| 4711 | X |  | eMule optional web interface |
| 4713 | X |  | PulseAudio sound server |
| 4723 | X |  | Appium open source automation tool |
| 4724 | X |  | Default bootstap port to use on device to talk to Appium |
| 4728 | X |  | Computer Associates Desktop and Server Management (DMP)/Port Multiplexer |
| 4730 | X | X | Gearman's job server |
| 4739 | X | X | IP Flow Information Export |
| 4747 | X |  | Apprentice |
| 4753 | X | X | SIMON (service and discovery) |
| 4789 |  | X | Virtual eXtensible Local Area Network (VXLAN) |
| 4791 |  | X | IP Routable RocE (RoCEv2) |
| 4840 | X | X | OPC UA Connection Protocol (TCP) and OPC UA Multicast Datagram Protocol (UDP) for OPC Unified Architecture from OPC Foundation |
| 4843 | X | X | OPC UA TCP Protocol over TLS/SSL for OPC Unified Architecture from OPC Foundation |
| 4847 | X | X | Web Fresh Communication, Quadrion Software & Odorless Entertainment |
| 4848 | X |  | Java, Glassfish Application Server administration default |
| 4894 | X | X | LysKOM Protocol A |
| 4944 |  | X | DrayTek DSL Status Monitoring |
| 4949 | X |  | Munin Resource Monitoring Tool |
| 4950 | X | X | Cylon Controls UC32 Communications Port |
| 5000 | X |  | UPnP—Windows network device interoperability |
| 5000 | X | X | VTun, VPN Software |
| 5000 | X |  | ASP.NET Core — Development Webserver |
| 5000 |  | X | FlightGear multiplayer |
| 5000 | X |  | Synology Inc. Management Console, File Station, Audio Station |
| 5000 | X |  | Flask Development Webserver |
| 5000 | X |  | Heroku console access |
| 5000 | X |  | Docker Registry |
| 5000 | X |  | AT&T U-verse public, educational, and government access (PEG) streaming over HTTP |
| 5000 | X |  | High-Speed SECS Message Services |
| 5000 | X |  | 3CX Phone System Management Console/Web Client (HTTP) |
| 5000 | X |  | RidgeRun GStreamer Daemon (GSTD)  |
| 5000 | X |  | Apple's AirPlay Receiver |
| 5000–5500 |  | X | League of Legends, a multiplayer online battle arena video game |
| 5001 | X |  | Slingbox and Slingplayer |
| 5001 | X | X | Iperf (Tool for measuring TCP and UDP bandwidth performance) |
| 5001 | X |  | Synology Inc. Secured Management Console, File Station, Audio Station |
| 5001 | X |  | 3CX Phone System Management Console/Web Client (HTTPS) |
| 5002 | X |  | ASSA ARX access control system |
| 5003 | X | X | FileMaker – name binding and transport |
| 5004 | X | X | Real-time Transport Protocol media data (RTP) (RFC 3551, RFC 4571) |
| 5005 | X | X | Real-time Transport Protocol control protocol (RTCP) (RFC 3551, RFC 4571) |
| 5007 | X |  | Palo Alto Networks - User-ID agent |
| 5010 | X | X | Registered to: TelePath (the IBM FlowMark workflow-management system messaging platform) |
| 5010 |  |  | The TCP port is now used for: IBM WebSphere MQ Workflow |
| 5011 | X | X | TelePath (the IBM FlowMark workflow-management system messaging platform) |
| 5025 | X | X | scpi-raw Standard Commands for Programmable Instruments |
| 5029 |  | X | Sonic Robo Blast 2 and Sonic Robo Blast 2 Kart servers |
| 5031 | X | X | AVM CAPI-over-TCP (ISDN over Ethernet tunneling) |
| 5037 | X |  | Android ADB server |
| 5044 | X |  | Standard port in Filebeats/Logstash implementation of Lumberjack protocol. |
| 5048 | X |  | Texai Message Service |
| 5050 | X |  | Yahoo! Messenger |
| 5051 | X |  | ita-agent Symantec Intruder Alert |
| 5060 | X | X | Session Initiation Protocol (SIP) |
| 5061 | X[220] |  | Session Initiation Protocol (SIP) over TLS |
| 5062 | X | X | Localisation access |
| 5064 | X | X | EPICS Channel Access server |
| 5065 | X | X | EPICS Channel Access repeater beacon |
| 5070 | X |  | Binary Floor Control Protocol (BFCP) |
| 5080 | X | X | List of telephone switches#NEC NEC SV8100 and SV9100 MLC Phones Default iSIP Port |
| 5084 | X | X | EPCglobal Low Level Reader Protocol (LLRP) |
| 5085 | X | X | EPCglobal Low Level Reader Protocol (LLRP) over TLS |
| 5090 | X | X | 3CX Phone System 3CX Tunnel Protocol, 3CX App API, 3CX Session Border Controller |
| 5093 |  | X | SafeNet, Inc Sentinel LM, Sentinel RMS, License Manager, client-to-server |
| 5099 | X | X | SafeNet, Inc Sentinel LM, Sentinel RMS, License Manager, server-to-server |
| 5104 | X |  | IBM Tivoli Framework NetCOOL/Impact HTTP Service |
| 5121 | X |  | Neverwinter Nights |
| 5124 | X | X | TorgaNET (Micronational Darknet) |
| 5125 | X | X | TorgaNET (Micronational Intelligence Darknet) |
| 5150 | X | X | ATMP Ascend Tunnel Management Protocol |
| 5151 | X |  | ESRI SDE Instance |
| 5151 |  | X | ESRI SDE Remote Start |
| 5154 | X | X | BZFlag |
| 5172 | X |  | PC over IP Endpoint Management |
| 5190 | X | X | AOL Instant Messenger protocol. The chat app is defunct as of 15 December 2017. |
| 5198 |  | X | EchoLink VoIP Amateur Radio Software (Voice) |
| 5199 |  | X | EchoLink VoIP Amateur Radio Software (Voice) |
| 5200 | X |  | EchoLink VoIP Amateur Radio Software (Information) |
| 5201 | X | X | Iperf3 (Tool for measuring TCP and UDP bandwidth performance) |
| 5222 | X | X | Extensible Messaging and Presence Protocol (XMPP) client connection |
| 5223 | X |  | Apple Push Notification Service |
| 5223 | X |  | Extensible Messaging and Presence Protocol (XMPP) client connection over SSL |
| 5228 | X |  | HP Virtual Room Service |
| 5228 | X |  | Google Play, Android Cloud to Device Messaging Service, Google Cloud Messaging |
| 5242 | X | X | Viber |
| 5243 | X | X | Viber |
| 5246 |  | X | Control And Provisioning of Wireless Access Points (CAPWAP) CAPWAP control |
| 5247 |  | X | Control And Provisioning of Wireless Access Points (CAPWAP) CAPWAP data |
| 5269 | X |  | Extensible Messaging and Presence Protocol (XMPP) server-to-server connection |
| 5280 | X |  | Extensible Messaging and Presence Protocol (XMPP) |
| 5281 | X |  | Extensible Messaging and Presence Protocol (XMPP) |
| 5298 | X | X | Extensible Messaging and Presence Protocol (XMPP) |
| 5310 | X | X | Outlaws, a 1997 first-person shooter video game |
| 5318 | X | X | Certificate Management over CMS |
| 5349 | X | X | STUN over TLS/DTLS, a protocol for NAT traversal |
| 5349 | X | X | TURN over TLS/DTLS, a protocol for NAT traversal |
| 5349 | X | X | STUN Behavior Discovery over TLS. See also port 3478. |
| 5351 | X | X | NAT Port Mapping Protocol and Port Control Protocol—client-requested configuration for connections through network address translators and firewalls |
| 5353 | X | X | Multicast DNS (mDNS) |
| 5355 | X | X | Link-Local Multicast Name Resolution (LLMNR), allows hosts to perform name resolution for hosts on the same local link (only provided by Windows Vista and Server 2008) |
| 5357 | X | X | Web Services for Devices (WSDAPI) (only provided by Windows Vista, Windows 7 and Server 2008) |
| 5358 | X | X | WSDAPI Applications to Use a Secure Channel (only provided by Windows Vista, Windows 7 and Server 2008) |
| 5394 |  | X | Kega Fusion, a Sega multi-console emulator |
| 5402 | X | X | Multicast File Transfer Protocol (MFTP) |
| 5405 | X | X | NetSupport Manager |
| 5412 | X | X | IBM Rational Synergy (Telelogic Synergy) (Continuus CM) Message Router |
| 5413 | X | X | Wonderware SuiteLink service |
| 5417 | X | X | SNS Agent |
| 5421 | X | X | NetSupport Manager |
| 5432 | X | X | PostgreSQL database system |
| 5433 | X |  | Bouwsoft file/webserver |
| 5445 |  | X | Cisco Unified Video Advantage |
| 5450 | X | X | OSIsoft PI Server Client Access  |
| 5457 | X |  | OSIsoft PI Asset Framework Client Access  |
| 5458 | X |  | OSIsoft PI Notifications Client Access  |
| 5480 | X |  | VMware VAMI (Virtual Appliance Management Infrastructure)—used for initial setup of various administration settings on Virtual Appliances designed using the VAMI architecture. |
| 5481 | X |  | Schneider Electric's ClearSCADA (SCADA implementation for Windows) — used for client-to-server communication. |
| 5495 | X |  | IBM Cognos TM1 Admin server |
| 5498 | X |  | Hotline tracker server connection |
| 5499 |  | X | Hotline tracker server discovery |
| 5500 | X |  | Hotline control connection |
| 5500 | X |  | VNC Remote Frame Buffer RFB protocol—for incoming listening viewer |
| 5501 | X |  | Hotline file transfer connection |
| 5517 | X |  | Setiqueue Proxy server client for SETI@Home project |
| 5550 | X |  | Hewlett-Packard Data Protector |
| 5554 | X | X | Fastboot default wireless port |
| 5555 | X | X | Oracle WebCenter Content: Inbound Refinery—Intradoc Socket port. (formerly known as Oracle Universal Content Management). Port though often changed during installation |
| 5555 | X |  | Freeciv versions up to 2.0, Hewlett-Packard Data Protector, McAfee EndPoint Encryption Database Server, SAP, Default for Microsoft Dynamics CRM 4.0, Softether VPN default port |
| 5556 | X | X | Freeciv, Oracle WebLogic Server Node Manager |
| 5568 | X | X | Session Data Transport (SDT), a part of Architecture for Control Networks (ACN) |
| 5601 | X |  | Kibana |
| 5631 | X |  | pcANYWHEREdata, Symantec pcAnywhere (version 7.52 and later) data |
| 5632 |  | X | pcANYWHEREstat, Symantec pcAnywhere (version 7.52 and later) status |
| 5656 | X |  | IBM Lotus Sametime p2p file transfer |
| 5666 | X |  | NRPE (Nagios) |
| 5667 | X |  | NSCA (Nagios) |
| 5670 | X |  | FILEMQ ZeroMQ File Message Queuing Protocol |
| 5670 |  | X | ZRE-DISC ZeroMQ Realtime Exchange Protocol (Discovery) |
| 5671 | X | X | Advanced Message Queuing Protocol (AMQP) over TLS |
| 5672 | X | X | Advanced Message Queuing Protocol (AMQP) |
| 5683 | X | X | Constrained Application Protocol (CoAP) |
| 5684 | X | X | Constrained Application Protocol Secure (CoAPs) |
| 5693 | X |  | Nagios Cross Platform Agent (NCPA) |
| 5701 | X |  | Hazelcast default communication port |
| 5718 | X |  | Microsoft DPM Data Channel (with the agent coordinator) |
| 5719 | X |  | Microsoft DPM Data Channel (with the protection agent) |
| 5722 | X | X | Microsoft RPC, DFSR (SYSVOL) Replication Service |
| 5723 | X |  | System Center Operations Manager |
| 5724 | X |  | Operations Manager Console |
| 5741 | X | X | IDA Discover Port 1 |
| 5742 | X | X | IDA Discover Port 2 |
| 5800 | X |  | VNC Remote Frame Buffer RFB protocol over HTTP |
| 5800 | X |  | ProjectWise Server |
| 5900 | X | X | Remote Frame Buffer protocol (RFB) |
| 5900 | X |  | Virtual Network Computing (VNC) Remote Frame Buffer RFB protocol |
| 5905 | X |  | Windows service "C:\Program Files\Intel\Intel(R) Online Connect Access\IntelTechnologyAccessService.exe" that listens on 127.0.0.1 |
| 5931 | X | X | AMMYY admin Remote Control |
| 5938 | X | X | TeamViewer remote desktop protocol |
| 5984 | X | X | CouchDB database server |
| 5985 | X |  | Windows PowerShell Default psSession Port Windows Remote Management Service (WinRM-HTTP) |
| 5986 | X |  | Windows PowerShell Default psSession Port Windows Remote Management Service (WinRM-HTTPS) |
| 5988–5989 | X |  | CIM-XML (DMTF Protocol) |
| 6000–6063 | X | X | X11—used between an X client and server over the network |
| 6005 | X |  | Default for BMC Software Control-M/Server—Socket used for communication between Control-M processes—though often changed during installation |
| 6005 | X |  | Default for Camfrog chat & cam client |
| 6009 | X |  | JD Edwards EnterpriseOne ERP system JDENet messaging client listener |
| 6050 | X |  | Arcserve backup |
| 6051 | X |  | Arcserve backup |
| 6086 | X |  | Peer Distributed Transfer Protocol (PDTP), FTP like file server in a P2P network |
| 6100 | X |  | Vizrt System |
| 6100 | X |  | Ventrilo authentication for version 3 |
| 6101 | X |  | Backup Exec Agent Browser |
| 6110 | X | X | softcm, HP Softbench CM |
| 6111 | X | X | spc, HP Softbench Sub-Process Control |
| 6112 | X | X | dtspcd, execute commands and launch applications remotely |
| 6112 | X | X | Blizzard's Battle.net gaming service and some games, ArenaNet gaming service, Relic gaming service |
| 6112 | X |  | Club Penguin Disney online game for kids |
| 6113 | X |  | Club Penguin Disney online game for kids, Used by some Blizzard games |
| 6136 | X |  | ObjectDB database server |
| 6159 | X |  | ARINC 840 EFB Application Control Interface |
| 6200 | X |  | Oracle WebCenter Content Portable: Content Server (With Native UI) and Inbound Refinery |
| 6201 | X | X | Thermo-Calc Software AB: Management of service nodes in a processing grid for thermodynamic calculations |
| 6201 | X |  | Oracle WebCenter Content Portable: Admin |
| 6225 | X |  | Oracle WebCenter Content Portable: Content Server Web UI |
| 6227 | X |  | Oracle WebCenter Content Portable: JavaDB |
| 6240 | X |  | Oracle WebCenter Content Portable: Capture |
| 6244 | X | X | Oracle WebCenter Content Portable: Content Server—Intradoc Socket port |
| 6255 | X | X | Oracle WebCenter Content Portable: Inbound Refinery—Intradoc Socket port |
| 6257 |  | X | WinMX (see also 6699) |
| 6260 | X | X | planet M.U.L.E. |
| 6262 | X |  | Sybase Advantage Database Server |
| 6343 |  | X | SFlow, sFlow traffic monitoring |
| 6346 | X | X | gnutella-svc, gnutella (FrostWire, Limewire, Shareaza, etc.) |
| 6347 | X | X | gnutella-rtr, Gnutella alternate |
| 6350 | X | X | App Discovery and Access Protocol |
| 6379 | X |  | Redis key-value data store |
| 6389 | X |  | EMC CLARiiON |
| 6432 | X |  | PgBouncer—A connection pooler for PostgreSQL |
| 6436 | X |  | Leap Motion Websocket Server TLS |
| 6437 | X |  | Leap Motion Websocket Server |
| 6443 | X |  | Kubernetes API server  |
| 6444 | X | X | Sun Grid Engine Qmaster Service |
| 6445 | X | X | Sun Grid Engine Execution Service |
| 6463–6472 | X |  | Discord RPC |
| 6464 | X | X | Port assignment for medical device communication in accordance to IEEE 11073-20701 |
| 6502 | X | X | Netop Remote Control |
| 6513 | X |  | NETCONF over TLS |
| 6514 | X |  | Syslog over TLS |
| 6515 | X | X | Elipse RPC Protocol (REC) |
| 6516 | X |  | Windows Admin Center |
| 6543 | X |  | Pylons project#Pyramid Default Pylons Pyramid web service port |
| 6556 | X |  | Check MK Agent |
| 6566 | X |  | SANE (Scanner Access Now Easy)—SANE network scanner daemon |
| 6560–6561 | X |  | Speech-Dispatcher daemon |
| 6571 | X |  | Windows Live FolderShare client |
| 6600 | X |  | Microsoft Hyper-V Live |
| 6600 | X |  | Music Player Daemon (MPD) |
| 6601 | X |  | Microsoft Forefront Threat Management Gateway |
| 6602 | X |  | Microsoft Windows WSS Communication |
| 6619 | X | X | odette-ftps, Odette File Transfer Protocol (OFTP) over TLS/SSL |
| 6622 | X | X | Multicast FTP |
| 6653 | X | X | OpenFlow |
| 6660–6664 | X |  | Internet Relay Chat (IRC) |
| 6665–6669 | X |  | Internet Relay Chat (IRC) |
| 6679 | X | X | Osorno Automation Protocol (OSAUT) |
| 6679 | X |  | Internet Relay Chat (IRC) SSL (Secure Internet Relay Chat)—often used |
| 6690 | X |  | Synology Cloud station |
| 6697 | X |  | IRC SSL (Secure Internet Relay Chat)—often used |
| 6699 | X |  | WinMX (see also 6257) |
| 6715 | X |  | AberMUD and derivatives default port |
| 6771 |  | X | BitTorrent Local Peer Discovery |
| 6783–6785 | X |  | Splashtop Remote server broadcast |
| 6801 | X | X | ACNET Control System Protocol |
| 6881–6887 | X | X | BitTorrent beginning of range of ports used most often |
| 6888 | X | X | MUSE |
| 6888 | X | X | BitTorrent continuation of range of ports used most often |
| 6889–6890 | X | X | BitTorrent continuation of range of ports used most often |
| 6891–6900 | X | X | BitTorrent continuation of range of ports used most often |
| 6891–6900 | X | X | Windows Live Messenger (File transfer) |
| 6901 | X | X | Windows Live Messenger (Voice) |
| 6901 | X | X | BitTorrent continuation of range of ports used most often |
| 6902–6968 | X | X | BitTorrent continuation of range of ports used most often |
| 6924 | X | X | split-ping, ping with RX/TX latency/loss split |
| 6969 | X | X | acmsoda |
| 6969 | X |  | BitTorrent tracker |
| 6970–6999 | X | X | BitTorrent end of range of ports used most often |
| 6970–6999 |  | X | QuickTime Streaming Server |
| 7000 | X |  | Default for Vuze's built-in HTTPS Bittorrent tracker |
| 7000 | X |  | Avira Server Management Console |
| 7001 | X |  | Avira Server Management Console |
| 7001 | X |  | Default for BEA WebLogic Server's HTTP server, though often changed during installation |
| 7002 | X |  | Default for BEA WebLogic Server's HTTPS server, though often changed during installation |
| 7005 | X |  | Default for BMC Software Control-M/Server and Control-M/Agent for Agent-to-Server, though often changed during installation |
| 7006 | X |  | Default for BMC Software Control-M/Server and Control-M/Agent for Server-to-Agent, though often changed during installation |
| 7010 | X |  | Default for Cisco AON AMC (AON Management Console) |
| 7022 | X |  | Database mirroring endpoints |
| 7023 |  | X | Bryan Wilcutt T2-NMCS Protocol for SatCom Modems |
| 7025 | X |  | Zimbra LMTP —local mail delivery |
| 7047 | X |  | Zimbra conversion server |
| 7070 | X | X | Real Time Streaming Protocol (RTSP), used by QuickTime Streaming Server. TCP is used by default, UDP is used as an alternate. |
| 7133 | X |  | Enemy Territory: Quake Wars |
| 7144 | X |  | Peercast |
| 7145 | X |  | Peercast |
| 7171 | X |  | Tibia |
| 7262 | X | X | CNAP (Calypso Network Access Protocol) |
| 7272 | X | X | WatchMe - WatchMe Monitoring |
| 7306 | X |  | Zimbra mysql  |
| 7307 | X |  | Zimbra mysql  |
| 7312 |  | X | Sibelius License Server |
| 7396 | X |  | Web control interface for Folding@home v7.3.6 and later |
| 7400 | X | X | RTPS (Real Time Publish Subscribe) DDS Discovery |
| 7401 | X | X | RTPS (Real Time Publish Subscribe) DDS User-Traffic |
| 7402 | X | X | RTPS (Real Time Publish Subscribe) DDS Meta-Traffic |
| 7471 | X |  | Stateless Transport Tunneling (STT) |
| 7473 | X |  | Rise: The Vieneo Province |
| 7474 | X |  | Neo4J Server webadmin |
| 7478 | X |  | Default port used by Open iT Server. |
| 7542 | X | X | Saratoga file transfer protocol |
| 7547 | X | X | CPE WAN Management Protocol (CWMP) Technical Report 069 |
| 7575 |  | X | Populous: The Beginning server |
| 7624 | X | X | Instrument Neutral Distributed Interface |
| 7631 | X |  | ERLPhase |
| 7634 | X |  | hddtemp—Utility to monitor hard drive temperature |
| 7652–7654 | X |  | I2P anonymizing overlay network |
| 7655 |  | X | I2P SAM Bridge Socket API |
| 7656–7660 | X |  | I2P anonymizing overlay network |
| 7670 | X |  | BrettspielWelt BSW Boardgame Portal |
| 7680 | X |  | Delivery Optimization for Windows 10 |
| 7687 | X |  | Bolt database connection |
| 7707–7708 |  | X | Killing Floor |
| 7717 |  | X | Killing Floor |
| 7777 | X |  | iChat server file transfer proxy |
| 7777 | X |  | Oracle Cluster File System 2 |
| 7777 | X |  | Windows backdoor program tini.exe default |
| 7777 | X |  | Just Cause 2: Multiplayer Mod Server |
| 7777 | X |  | Terraria default server |
| 7777 |  | X | San Andreas Multiplayer (SA-MP) default port server |
| 7777 |  | X | SCP: Secret Laboratory Multiplayer Server |
| 7777–7788 | X | X | Unreal Tournament series default server |
| 7831 | X |  | Default used by Smartlaunch Internet Cafe Administration software |
| 7880 | X | X | PowerSchool Gradebook Server |
| 7890 | X |  | Default that will be used by the iControl Internet Cafe Suite Administration software |
| 7915 | X |  | Default for YSFlight server |
| 7935 | X |  | Fixed port used for Adobe Flash Debug Player to communicate with a debugger (Flash IDE, Flex Builder or fdb). |
| 7946 | X | X | Docker Swarm communication among nodes |
| 7979 |  | X | Used by SilverBluff Studios for communication between servers and clients. |
| 7990 | X |  | Atlassian Bitbucket (default port) |
| 8000 | X |  | Commonly used for Internet radio streams such as SHOUTcast, Icecast and iTunes Radio |
| 8000 | X |  | DynamoDB Local |
| 8000 | X |  | Django Development Webserver |
| 8000 | X |  | Python 3 http.server |
| 8005 | X |  | Tomcat remote shutdown |
| 8005 | X |  | PLATO ASCII protocol (RFC 600) |
| 8005 | X |  | Windows SCCM HTTP listener service |
| 8006 | X |  | Quest AppAssure 5 API |
| 8006 | X |  | Proxmox Virtual Environment admin web interface |
| 8007 | X |  | Quest AppAssure 5 Engine |
| 8007 | X |  | Proxmox Backup Server admin web interface |
| 8008 | X | X | Alternative port for HTTP. See also ports 80 and 8080. |
| 8008 | X |  | IBM HTTP Server administration default |
| 8008 | X |  | iCal, a calendar application by Apple |
| 8008 | X |  | Matrix homeserver federation over HTTP |
| 8009 | X |  | Apache JServ Protocol (ajp13) |
| 8010 | X |  | Buildbot web status page |
| 8042 | X |  | Orthanc – REST API over HTTP |
| 8069 | X |  | OpenERP 5.0 XML-RPC protocol |
| 8070 | X |  | OpenERP 5.0 NET-RPC protocol |
| 8074 | X | X | Gadu-Gadu |
| 8075 | X |  | Killing Floor web administration interface |
| 8080 | X | X | Alternative port for HTTP. See also ports 80 and 8008. |
| 8080 | X |  | Apache Tomcat |
| 8080 | X |  | Atlassian JIRA applications |
| 8088 | X |  | Asterisk management access via HTTP |
| 8089 | X |  | Splunk daemon management |
| 8089 | X |  | Fritz!Box automatic TR-069 configuration |
| 8090 | X |  | Atlassian Confluence |
| 8090 | X |  | Coral Content Distribution Network (legacy; 80 and 8080 now supported) |
| 8090 | X |  | Matrix identity server |
| 8091 | X |  | CouchBase web administration |
| 8092 | X |  | CouchBase API |
| 8096 | X |  | Emby and Jellyfin HTTP port |
| 8111 | X |  | JOSM Remote Control |
| 8112 | X |  | PAC Pacifica Coin |
| 8116 |  | X | Check Point Cluster Control Protocol |
| 8118 | X |  | Privoxy—advertisement-filtering Web proxy |
| 8123 | X |  | Polipo Web proxy |
| 8123 | X |  | Home Assistant Home automation |
| 8123 | X |  | BURST P2P |
| 8124 | X |  | Standard BURST Mining Pool Software Port |
| 8125 | X |  | BURST Web Interface |
| 8139 | X |  | Puppet (software) Client agent |
| 8140 | X |  | Puppet (software) Master server |
| 8172 | X |  | Microsoft Remote Administration for IIS Manager |
| 8184 | X |  | NCSA Brown Dog Data Access Proxy |
| 8194–8195 | X |  | Bloomberg Terminal |
| 8200 | X |  | GoToMyPC |
| 8200 | X |  | MiniDLNA media server Web Interface |
| 8222 | X |  | VMware VI Web Access via HTTP |
| 8243 | X | X | HTTPS listener for Apache Synapse |
| 8245 | X |  | Dynamic DNS for at least No-IP and DynDNS |
| 8280 | X | X | HTTP listener for Apache Synapse |
| 8281 | X |  | HTTP Listener for Gatecraft Plugin |
| 8291 | X |  | Winbox—Default on a MikroTik RouterOS for a Windows application used to administer MikroTik RouterOS |
| 8303 |  | X | Teeworlds Server |
| 8332 | X |  | Bitcoin JSON-RPC server |
| 8333 | X |  | Bitcoin |
| 8333 | X |  | VMware VI Web Access via HTTPS |
| 8334 | X |  | Filestash server (default)  |
| 8337 | X |  | VisualSVN Distributed File System Service (VDFS) |
| 8384 | X |  | Syncthing web GUI |
| 8388 | X |  | Shadowsocks proxy server |
| 8400 | X |  | Commvault Communications Service (GxCVD, found in all client computers) |
| 8401 | X |  | Commvault Server Event Manager (GxEvMgrS, available in CommServe) |
| 8403 | X |  | Commvault Firewall (GxFWD, tunnel port for HTTP/HTTPS) |
| 8443 | X |  | SW Soft Plesk Control Panel |
| 8443 | X |  | Apache Tomcat SSL |
| 8443 | X |  | Promise WebPAM SSL |
| 8443 | X |  | iCal over SSL |
| 8443 | X |  | MineOs WebUi |
| 8444 | X |  | Bitmessage |
| 8448 | X |  | Matrix homeserver federation over HTTPS |
| 8484 | X |  | MapleStory Login Server |
| 8500 | X |  | Adobe ColdFusion built-in web server |
| 8530 | X |  | Windows Server Update Services over HTTP, when using the default role installation settings in Windows Server 2012 and later versions. |
| 8531 | X |  | Windows Server Update Services over HTTPS, when using the default role installation settings in Windows Server 2012 and later versions. |
| 8555 | X |  | Symantec DLP OCR Engine  |
| 8580 | X |  | Freegate, an Internet anonymizer and proxy tool |
| 8629 | X |  | Tibero database |
| 8642 | X |  | Lotus Notes Traveler auto synchronization for Windows Mobile and Nokia devices |
| 8691 | X |  | Ultra Fractal, a fractal generation and rendering software application – distributed calculations over networked computers |
| 8765 | X |  | Default port of a local GUN relay peer that the Internet Archive and others use as a decentralized mirror for censorship resistance. |
| 8767 |  | X | Voice channel of TeamSpeak 2, a proprietary Voice over IP protocol targeted at gamers |
| 8834 | X |  | Nessus, a vulnerability scanner – remote XML-RPC web server |
| 8840 | X |  | Opera Unite, an extensible framework for web applications |
| 8880 | X |  | Alternate port of CDDB (Compact Disc Database) protocol, used to look up audio CD (compact disc) information over the Internet. See also port 888. |
| 8880 | X |  | IBM WebSphere Application Server SOAP connector |
| 8883 | X | X | Secure MQTT (MQTT over TLS) |
| 8887 | X |  | HyperVM over HTTP |
| 8888 | X |  | HyperVM over HTTPS |
| 8888 | X |  | Freenet web UI (localhost only) |
| 8888 | X |  | Default for IPython / Jupyter notebook dashboards |
| 8888 | X |  | MAMP |
| 8889 | X |  | MAMP |
| 8920 | X |  | Jellyfin HTTPS port |
| 8983 | X |  | Apache Solr |
| 8997 | X |  | Alternate port for I2P Monotone Proxy |
| 8998 | X |  | I2P Monotone Proxy |
| 8999 | X |  | Alternate port for I2P Monotone Proxy |
| 9000 | X |  | SonarQube Web Server |
| 9000 | X |  | ClickHouse default port |
| 9000 | X |  | DBGp |
| 9000 | X |  | SqueezeCenter web server & streaming |
| 9000 |  | X | UDPCast |
| 9000 | X |  | Play Framework web server |
| 9000 | X |  | Hadoop NameNode default port |
| 9000 | X |  | PHP-FPM default port |
| 9000 | X |  | QBittorrent's embedded torrent tracker default port |
| 9001 | X | X | ETL Service Manager |
| 9001 | X |  | Microsoft SharePoint authoring environment |
| 9001 | X |  | cisco-xremote router configuration |
| 9001 | X |  | Tor network default |
| 9001 | X |  | DBGp Proxy |
| 9001 | X |  | HSQLDB default port |
| 9002 | X |  | Newforma Server comms |
| 9006 | X |  | Tomcat in standalone mode |
| 9030 | X |  | Tor often used |
| 9042 | X |  | Apache Cassandra native protocol clients |
| 9043 | X |  | WebSphere Application Server Administration Console secure |
| 9050–9051 | X |  | Tor (SOCKS-5 proxy client) |
| 9060 | X |  | WebSphere Application Server Administration Console |
| 9080 | X | X | glrpc, Groove Collaboration software GLRPC |
| 9080 | X |  | WebSphere Application Server HTTP Transport (port 1) default |
| 9080 | X |  | Remote Potato by FatAttitude, Windows Media Center addon |
| 9080 | X |  | ServerWMC, Windows Media Center addon |
| 9081 | X |  | Zerto ZVM to ZVM communication |
| 9090 | X |  | Prometheus metrics server |
| 9090 | X |  | Openfire Administration Console |
| 9090 | X |  | SqueezeCenter control (CLI) |
| 9090 | X |  | Cherokee Admin Panel |
| 9090 | X |  | Cockpit-Project Web-based graphical interface for servers |
| 9091 | X |  | Openfire Administration Console (SSL Secured) |
| 9091 | X |  | Transmission (BitTorrent client) Web Interface |
| 9092 | X |  | H2 (DBMS) Database Server |
| 9092 | X |  | Apache Kafka A Distributed Streaming Platform |
| 9100 | X | X | PDL Data Stream, used for printing to certain network printers |
| 9101 | X | X | Bacula Director |
| 9102 | X | X | Bacula File Daemon |
| 9103 | X | X | Bacula Storage Daemon |
| 9119 | X | X | MXit Instant Messenger |
| 9150 | X |  | Tor Browser |
| 9191 | X |  | Sierra Wireless Airlink |
| 9199 | X |  | Avtex LLC—qStats |
| 9200 | X |  | Elasticsearch—default Elasticsearch port |
| 9217 | X |  | iPass Platform Service |
| 9293 | X |  | Sony PlayStation RemotePlay |
| 9295 | X | X | Sony PlayStation Remote Play Session creation communication port |
| 9296 |  | X | Sony PlayStation Remote Play |
| 9897 |  | X | Sony PlayStation Remote Play Video stream |
| 9300 | X |  | IBM Cognos BI |
| 9303 |  | X | D-Link Shareport Share storage and MFP printers |
| 9306 | X |  | Sphinx Native API |
| 9309 | X | X | Sony PlayStation Vita Host Collaboration WiFi Data Transfer |
| 9312 | X |  | Sphinx SphinxQL |
| 9332 | X |  | Litecoin JSON-RPC server |
| 9333 | X |  | Litecoin |
| 9339 | X |  | Used by all Supercell games such as Brawl Stars and Clash of Clans, mobile freemium strategy video games |
| 9389 | X | X | adws, Microsoft AD DS Web Services, Powershell uses this port |
| 9392 | X |  | OpenVAS Greenbone Security Assistant web interface |
| 9418 | X | X | git, Git pack transfer service |
| 9419 | X |  | MooseFS distributed file system – master control port |
| 9420 | X |  | MooseFS distributed file system – master command port |
| 9421 | X |  | MooseFS distributed file system – master client port |
| 9422 | X |  | MooseFS distributed file system – Chunkservers |
| 9425 | X |  | MooseFS distributed file system – CGI server |
| 9443 | X |  | VMware Websense Triton console (HTTPS port used for accessing and administrating a vCenter Server via the Web Management Interface) |
| 9443 | X |  | NCSA Brown Dog Data Tilling Service |
| 9535 | X | X | mngsuite, LANDesk Management Suite Remote Control |
| 9536 | X | X | laes-bf, IP Fabrics Surveillance buffering function |
| 9600 |  | X | Factory Interface Network Service (FINS), a network protocol used by Omron programmable logic controllers |
| 9669 | X |  | VGG Image Search Engine VISE |
| 9675 | X | X | Spiceworks Desktop, IT Helpdesk Software |
| 9676 | X | X | Spiceworks Desktop, IT Helpdesk Software |
| 9695 | X |  | Content centric networking (CCN, CCNx) |
| 9735 | X |  | Bitcoin Lightning Network |
| 9785 | X | X | Viber |
| 9800 | X | X | WebDAV Source |
| 9800 | X |  | WebCT e-learning portal |
| 9875 | X |  | Club Penguin Disney online game for kids |
| 9898 | X |  | Tripwire—File Integrity Monitoring Software |
| 9899 |  | X | SCTP tunneling (port number used in SCTP packets encapsulated in UDP, RFC 6951) |
| 9901 | X |  | Banana for Apache Solr |
| 9981 | X |  | Tvheadend HTTP server (web interface) |
| 9982 | X |  | Tvheadend HTSP server (Streaming protocol) |
| 9987 | X |  | TeamSpeak 3 server default (voice) port (for the conflicting service see the IANA list) |
| 9993 |  | X | ZeroTier Default port for ZeroTier |
| 9997 | X |  | Splunk port for communication between the forwarders and indexers |
| 9999 | X |  | Urchin Web Analytics |
| 9999 | X |  | Dash (cryptocurrency) |
| 10000 | X | X | Network Data Management Protocol (NDMP) Control stream for network backup and restore. |
| 10000 | X |  | BackupExec |
| 10000 | X |  | Webmin, Web-based Unix/Linux system administration tool (default port) |
| 10000–20000 |  | X | Used on VoIP networks for receiving and transmitting voice telephony traffic which includes Google Voice via the OBiTalk ATA devices as well as on the MagicJack and Vonage ATA network devices. |
| 10001 |  | X | Ubiquiti UniFi access points broadcast to 255.255.255.255:10001 (UDP) to locate the controller(s) |
| 10009 | X | X | CrossFire, a multiplayer online First Person Shooter |
| 10011 | X |  | TeamSpeak 3 ServerQuery |
| 10024 | X |  | Zimbra smtp —to amavis from postfix |
| 10025 | X |  | Zimbra smtp —back to postfix from amavis |
| 10042 | X |  | Mathoid server  |
| 10050 | X | X | Zabbix agent |
| 10051 | X | X | Zabbix trapper |
| 10110 | X | X | NMEA 0183 Navigational Data. Transport of NMEA 0183 sentences over TCP or UDP |
| 10172 | X |  | Intuit Quickbooks client |
| 10200 | X |  | FRISK Software International's fpscand virus scanning daemon for Unix platforms |
| 10200 | X |  | FRISK Software International's f-protd virus scanning daemon for Unix platforms |
| 10201–10204 | X |  | FRISK Software International's f-protd virus scanning daemon for Unix platforms |
| 10212 | X |  | GE Intelligent Platforms Proficy HMI/SCADA – CIMPLICITY WebView |
| 10308 | X |  | Digital Combat Simulator Dedicated Server  |
| 10480 | X |  | SWAT 4 Dedicated Server |
| 10505 |  | X | BlueStacks (android simulator) broadcast |
| 10514 | X | X | TLS-enabled Rsyslog (default by convention) |
| 10578 | X |  | Skyrim Together multiplayer server for The Elder Scrolls V: Skyrim mod. |
| 10800 | X |  | Touhou fight games (Immaterial and Missing Power, Scarlet Weather Rhapsody, Hisoutensoku, Hopeless Masquerade and Urban Legend in Limbo) |
| 10823 |  | X | Farming Simulator 2011 |
| 10891 | X |  | Jungle Disk (this port is opened by the Jungle Disk Monitor service on the localhost) |
| 10933 | X |  | Octopus Deploy Tentacle deployment agent |
| 11001 | X | X | metasys ( Johnson Controls Metasys java AC control environment ) |
| 11100 |  | X | Risk of Rain multiplayer server |
| 11111 | X |  | RiCcI, Remote Configuration Interface (Redhat Linux) |
| 11112 | X | X | ACR/NEMA Digital Imaging and Communications in Medicine (DICOM) |
| 11211 | X | X | memcached |
| 11214 | X | X | memcached incoming SSL proxy |
| 11215 | X | X | memcached internal outgoing SSL proxy |
| 11235 | X | X | XCOMPUTE numerical systems messaging (Xplicit Computing) |
| 11311 | X | X | Robot Operating System master |
| 11371 | X | X | OpenPGP HTTP key server |
| 11753 | X |  | OpenRCT2 multiplayer |
| 12000 | X | X | CubeForm, Multiplayer SandBox Game |
| 12012 |  | X | Audition Online Dance Battle, Korea Server—Status/Version Check |
| 12013 | X | X | Audition Online Dance Battle, Korea Server |
| 12035 |  | X | Second Life, used for server UDP in-bound |
| 12043 | X |  | Second Life, used for LSL HTTPS in-bound |
| 12046 | X |  | Second Life, used for LSL HTTP in-bound |
| 12201 | X | X | Graylog Extended Log Format (GELF) |
| 12222 |  | X | Light Weight Access Point Protocol (LWAPP) LWAPP data (RFC 5412) |
| 12223 |  | X | Light Weight Access Point Protocol (LWAPP) LWAPP control (RFC 5412) |
| 12307 |  | X | Makerbot UDP Broadcast (client to printer) (JSON-RPC) |
| 12308 |  | X | Makerbot UDP Broadcast (printer to client) (JSON-RPC) |
| 12345 | X | X | Cube World |
| 12345 | X |  | Little Fighter 2 |
| 12345 | X |  | NetBus remote administration tool (often Trojan horse). |
| 12443 | X |  | IBM HMC web browser management access over HTTPS instead of default port 443 |
| 12489 | X |  | NSClient/NSClient++/NC_Net (Nagios) |
| 12975 | X |  | LogMeIn Hamachi (VPN tunnel software; also port 32976)—used to connect to Mediation Server (bibi.hamachi.cc); will attempt to use SSL (TCP port 443) if both 12975 & 32976 fail to connect |
| 13000–13050 |  | X | Second Life, used for server UDP in-bound |
| 13008 | X | X | CrossFire, a multiplayer online First Person Shooter |
| 13075 | X |  | Default for BMC Software Control-M/Enterprise Manager Corba communication, though often changed during installation |
| 13400 | X | X | ISO 13400 Road vehicles — Diagnostic communication over Internet Protocol(DoIP) |
| 13720 | X | X | Symantec NetBackup—bprd (formerly VERITAS) |
| 13721 | X | X | Symantec NetBackup—bpdbm (formerly VERITAS) |
| 13724 | X | X | Symantec Network Utility—vnetd (formerly VERITAS) |
| 13782 | X | X | Symantec NetBackup—bpcd (formerly VERITAS) |
| 13783 | X | X | Symantec VOPIED protocol (formerly VERITAS) |
| 13785 | X | X | Symantec NetBackup Database—nbdb (formerly VERITAS) |
| 13786 | X | X | Symantec nomdb (formerly VERITAS) |
| 14550 |  | X | MAVLink Ground Station Port |
| 14567 |  | X | Battlefield 1942 and mods |
| 14652 | X |  | Repgen DoxBox reporting tool |
| 14800 | X |  | Age of Wonders III p2p port |
| 15000 | X |  | psyBNC |
| 15000 | X |  | Wesnoth |
| 15000 | X |  | Kaspersky Network Agent |
| 15000 |  | X | Teltonika networks remote management system (RMS) |
| 15009 | X | X | Teltonika networks remote management system (RMS) |
| 15010 | X | X | Teltonika networks remote management system (RMS) |
| 15441 | X |  | ZeroNet fileserver |
| 15567 |  | X | Battlefield Vietnam and mods |
| 15345 | X | X | XPilot Contact |
| 15672 | X |  | RabbitMQ management plugin |
| 16000 | X |  | Oracle WebCenter Content: Imaging (formerly known as Oracle Universal Content Management). Port though often changed during installation |
| 16000 | X |  | shroudBNC |
| 16080 | X |  | macOS Server Web (HTTP) service with performance cache |
| 16200 | X |  | Oracle WebCenter Content: Content Server (formerly known as Oracle Universal Content Management). Port though often changed during installation |
| 16225 | X |  | Oracle WebCenter Content: Content Server Web UI. Port though often changed during installation |
| 16250 | X |  | Oracle WebCenter Content: Inbound Refinery (formerly known as Oracle Universal Content Management). Port though often changed during installation |
| 16261 | X | X | Project Zomboid multiplayer. Additional sequential ports used for each player connecting to server. |
| 16300 | X |  | Oracle WebCenter Content: Records Management (formerly known as Oracle Universal Records Management). Port though often changed during installation |
| 16384 |  | X | CISCO Default RTP MIN |
| 16384–16403 |  | X | Real-time Transport Protocol (RTP), RTP Control Protocol (RTCP), used by Apple's iChat for audio and video |
| 16384–16387 |  | X | Real-time Transport Protocol (RTP), RTP Control Protocol (RTCP), used by Apple's FaceTime and Game Center |
| 16393–16402 |  | X | Real-time Transport Protocol (RTP), RTP Control Protocol (RTCP), used by Apple's FaceTime and Game Center |
| 16403–16472 |  | X | Real-time Transport Protocol (RTP), RTP Control Protocol (RTCP), used by Apple's Game Center |
| 16400 | X |  | Oracle WebCenter Content: Capture (formerly known as Oracle Document Capture). Port though often changed during installation |
| 16567 |  | X | Battlefield 2 and mods |
| 16666 | X | X | SITC Port for mobile web traffic |
| 16677 | X | X | SITC Port for mobile web traffic |
| 17011 | X |  | Worms multiplayer |
| 17224 | X | X | Train Realtime Data Protocol (TRDP) Process Data, network protocol used in train communication. |
| 17225 | X | X | Train Realtime Data Protocol (TRDP) Message Data, network protocol used in train communication. |
| 17333 | X |  | CS Server (CSMS), default binary protocol port |
| 17472 | X |  | Tanium Communication Port |
| 17475 | X |  | DMXControl 3 Network Broker |
| 17500 | X | X | Dropbox LanSync Protocol (db-lsp); used to synchronize file catalogs between Dropbox clients on a local network. |
| 17777 | X | X | SITC Port for mobile web traffic |
| 18080 | X |  | Monero P2P network communications |
| 18081 | X |  | Monero incoming RPC calls |
| 18091 | X | X | memcached Internal REST HTTPS for SSL |
| 18092 | X | X | memcached Internal CAPI HTTPS for SSL |
| 18104 | X |  | RAD PDF Service |
| 18200 | X | X | Audition Online Dance Battle, AsiaSoft Thailand Server status/version check |
| 18201 | X | X | Audition Online Dance Battle, AsiaSoft Thailand Server |
| 18206 | X | X | Audition Online Dance Battle, AsiaSoft Thailand Server FAM database |
| 18300 | X | X | Audition Online Dance Battle, AsiaSoft SEA Server status/version check |
| 18301 | X | X | Audition Online Dance Battle, AsiaSoft SEA Server |
| 18306 | X | X | Audition Online Dance Battle, AsiaSoft SEA Server FAM database |
| 18333 | X |  | Bitcoin testnet |
| 18400 | X | X | Audition Online Dance Battle, KAIZEN Brazil Server status/version check |
| 18401 | X | X | Audition Online Dance Battle, KAIZEN Brazil Server |
| 18505 | X | X | Audition Online Dance Battle R4p3 Server, Nexon Server status/version check |
| 18506 | X | X | Audition Online Dance Battle, Nexon Server |
| 18605 | X | X | X-BEAT status/version check |
| 18606 | X | X | X-BEAT |
| 18676 | X | X | YouView |
| 19000 | X | X | Audition Online Dance Battle, G10/alaplaya Server status/version check |
| 19000 |  | X | JACK sound server |
| 19001 | X | X | Audition Online Dance Battle, G10/alaplaya Server |
| 19132 |  | X | Minecraft: Bedrock Edition multiplayer server |
| 19133 |  | X | Minecraft: Bedrock Edition IPv6 multiplayer server |
| 19150 | X | X | Gkrellm Server |
| 19226 | X |  | Panda Software AdminSecure Communication Agent |
| 19294 | X |  | Google Talk Voice and Video connections |
| 19295 |  | X | Google Talk Voice and Video connections |
| 19302 |  | X | Google Talk Voice and Video connections |
| 19531 | X |  | systemd-journal-gatewayd |
| 19532 | X |  | systemd-journal-remote |
| 19788 |  | X | Mesh Link Establishment protocol for IEEE 802.15.4 radio mesh networks |
| 19812 | X |  | 4D database SQL Communication |
| 19813 | X | X | 4D database Client Server Communication |
| 19814 | X |  | 4D database DB4D Communication |
| 19999 | X |  | Distributed Network Protocol—Secure (DNP—Secure), a secure version of the protocol used in SCADA systems between communicating RTU's and IED's |
| 20000 | X |  | Distributed Network Protocol (DNP), a protocol used in SCADA systems between communicating RTU's and IED's |
| 20000 | X |  | Usermin, Web-based Unix/Linux user administration tool (default port) |
| 20000 |  | X | Used on VoIP networks for receiving and transmitting voice telephony traffic which includes Google Voice via the OBiTalk ATA devices as well as on the MagicJack and Vonage ATA network devices. |
| 20560 | X | X | Killing Floor |
| 20582 |  | X | HW Development IoT comms |
| 20583 |  | X | HW Development IoT comms |
| 20595 |  | X | 0 A.D. Empires Ascendant |
| 20808 |  | X | Ableton Link |
| 21025 | X |  | Starbound Server (default), Starbound |
| 21064 | X |  | Default Ingres DBMS server |
| 22000 | X |  | Syncthing (default) |
| 22136 | X |  | FLIR Systems Camera Resource Protocol |
| 22222 | X |  | Davis Instruments, WeatherLink IP |
| 23073 | X |  | Soldat Dedicated Server |
| 23399 | X |  | Skype default protocol |
| 23513 | X |  | Duke Nukem 3D source ports |
| 24441 | X | X | Pyzor spam detection network |
| 24444 | X |  | NetBeans integrated development environment |
| 24465 | X | X | Tonido Directory Server for Tonido which is a Personal Web App and P2P platform |
| 24554 | X | X | BINKP, Fidonet mail transfers over TCP/IP |
| 24800 | X |  | Synergy: keyboard/mouse sharing software |
| 24842 | X |  | StepMania: Online: Dance Dance Revolution Simulator |
| 25565 | X |  | Minecraft (Java Edition) multiplayer server |
| 25565 |  | X | Minecraft (Java Edition) multiplayer server query |
| 25575 |  | X | Minecraft (Java Edition) multiplayer server RCON |
| 25600-25700 | X | X | SamsidParty Operational Ports |
| 25826 |  | X | collectd default port |
| 26000 | X | X | id Software's Quake server |
| 26000 | X |  | EVE Online |
| 26000 |  | X | Xonotic, an open-source arena shooter |
| 26822 |  | X | MSI MysticLight |
| 26900–26901 | X |  | EVE Online |
| 26909–26911 | X |  | Action Tanks Online |
| 27000 | X |  | PowerBuilder SySAM license server |
| 27000–27006 |  | X | id Software's QuakeWorld master server |
| 27000–27009 | X | X | FlexNet Publisher's License server (from the range of default ports) |
| 27000–27015 |  | X | Steam (game client traffic) |
| 27015 |  | X | GoldSrc and Source engine dedicated server port |
| 27015–27018 |  | X | Unturned, a survival game |
| 27015–27030 |  | X | Steam (matchmaking and HLTV) |
| 27015–27030 | X | X | Steam (downloads) |
| 27016 | X |  | Magicka and Space Engineers server port |
| 27017 | X |  | MongoDB daemon process (mongod) and routing service (mongos) |
| 27031–27035 |  | X | Steam (In-Home Streaming) |
| 27036 | X | X | Steam (In-Home Streaming) |
| 27374 | X |  | Sub7 default. |
| 27500–27900 |  | X | id Software's QuakeWorld |
| 27888 |  | X | Kaillera server |
| 27901–27910 |  | X | id Software's Quake II master server |
| 27950 |  | X | OpenArena outgoing |
| 27960–27969 |  | X | Activision's Enemy Territory and id Software's Quake III Arena, Quake III and Quake Live and some ioquake3 derived games, such as Urban Terror (OpenArena incoming) |
| 28000 | X | X | Siemens Digital Industries Software license server |
| 28001 | X |  | Starsiege: Tribes |
| 28015 |  | X | Rust (video game) |
| 28016 |  | X | Rust RCON (video game) |
| 28260 | X |  | Palo Alto Networks' Panorama HA-1 backup unencrypted sync port. |
| 28443 | X |  | Palo Alto Networks' Panorama-to-managed devices software updates, PAN-OS 8.0 and later. |
| 28769 | X |  | Palo Alto Networks' Panorama HA unencrypted sync port. |
| 28770 | X |  | Palo Alto Networks' Panorama HA-1 backup sync port. |
| 28770–28771 |  | X | AssaultCube Reloaded, a video game based upon a modification of AssaultCube |
| 28785–28786 |  | X | Cube 2: Sauerbraten |
| 28852 | X | X | Killing Floor |
| 28910 | X | X | Nintendo Wi-Fi Connection |
| 28960 | X | X | Call of Duty; Call of Duty: United Offensive; Call of Duty 2; Call of Duty 4: Modern Warfare Call of Duty: World at War (PC platform) |
| 29000 | X |  | Perfect World, an adventure and fantasy MMORPG |
| 29070 | X | X | Jedi Knight: Jedi Academy by Ravensoft |
| 29900–29901 | X | X | Nintendo Wi-Fi Connection |
| 29920 | X | X | Nintendo Wi-Fi Connection |
| 30000 |  | X | XLink Kai P2P |
| 30000 |  | X | Minetest server default port |
| 30000 |  | X | Foundry Virtual Tabletop server default port |
| 30033 | X |  | TeamSpeak 3 File Transfer |
| 30120 | X |  | Fivem (Default Port) GTA V multiplayer |
| 30564 | X |  | Multiplicity: keyboard/mouse/clipboard sharing software |
| 31337 | X |  | Back Orifice and Back Orifice 2000 remote administration tools |
| 31337 | X | X | ncat, a netcat alternative |
| 31416 | X |  | BOINC RPC |
| 31438 | X |  | Rocket U2 |
| 31457 | X |  | TetriNET |
| 32137 | X | X | Immunet Protect (UDP in version 2.0, TCP since version 3.0) |
| 32400 | X |  | Plex Media Server |
| 32764 | X |  | A backdoor found on certain Linksys, Netgear and other wireless DSL modems/combination routers |
| 32887 | X |  | Ace of Spades, a multiplayer FPS video game |
| 32976 | X |  | LogMeIn Hamachi, a VPN application; also TCP port 12975 and SSL (TCP 443). |
| 33434 | X | X | traceroute |
| 33848 |  | X | Jenkins, a continuous integration (CI) tool |
| 34000 |  | X | Infestation: Survivor Stories (formerly known as The War Z), a multiplayer zombie video game |
| 34197 |  | X | Factorio, a multiplayer survival and factory-building game |
| 35357 | X |  | OpenStack Identity (Keystone) administration |
| 36330 | X |  | Folding@home Control Port |
| 37008 |  | X | TZSP intrusion detection |
| 40000 | X | X | SafetyNET p – a real-time Industrial Ethernet protocol |
| 41121 | X | X | Tentacle Server - Pandora FMS |
| 41794 | X | X | Crestron Control Port - Crestron Electronics |
| 41795 | X | X | Crestron Terminal Port - Crestron Electronics |
| 41796 | X |  | Crestron Secure Control Port - Crestron Electronics |
| 41797 | X |  | Crestron Secure Terminal Port - Crestron Electronics |
| 42806 |  |  | Discord |
| 43110 | X |  | ZeroNet web UI default port  |
| 43594–43595 | X |  | RuneScape |
| 44405 | X |  | Mu Online Connect Server |
| 44818 | X | X | EtherNet/IP explicit messaging |
| 47808–47823 | X | X | BACnet Building Automation and Control Networks (4780810 = BAC016 to 4782310 = BACF16) |

## Dynamic, private or ephemeral ports
| Port | TCP | UDP | Description |
|------|:---:|:---:|:-----------:|
| 49152–65535 | X |  | Certificate Management over CMS |
| 49160 | X |  | Palo Alto Networks' Panorama. |
| 49190 | X |  | Palo Alto Networks' Panorama. |
| 60000–61000 |  | X | Range from which Mosh – a remote-terminal application similar to SSH – typically assigns ports for ongoing sessions between Mosh servers and Mosh clients. |
| 64738 | X | X | Mumble |

[^1]: https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers