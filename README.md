# CN Lab

NS2 network simulation programs from my computer networks lab.

## What's inside

- `CLIENT SERVER` - client-server communication (`lp4.tcl`), with awk scripts that measure transfer time and throughput from the trace
- `DISTANCE VECTOR` - distance vector routing (`lp3.tcl`)
- `FTP` - file transfer over the simulated network (`lp2.tcl`), with an awk script that computes received throughput
- `Multicasting` - multicast routing (`lp5.tcl`)
- `TCP` - TCP vs UDP sharing a bottleneck link (`lp1.tcl`), with an awk script that counts received/dropped packets; `cwnd.dat` holds the congestion-window-over-time data for plotting
- `aodv.tcl`, `dsdv.tcl`, `dsr.tcl` - ad hoc routing protocols (AODV, DSDV, DSR)
- `error.tcl` - error model

## Running

These are OTcl scripts for NS2. Run one with:

```bash
ns aodv.tcl
```

Each simulation writes a `.tr` trace file (and a `.nam` file for the nam animator). The awk scripts analyze the traces.

## Sample run

NS2 is not installed here, so the simulations themselves were not re-run. But the repo ships the trace files from earlier runs, and the awk analysis scripts were run against them for real with `awk -f`:

TCP vs UDP over the bottleneck (`TCP/lp1.awk` on `TCP/lp1.tr`):

```
TCP receive 3588
UDP receive 744
TCP drop 0
UDP drop 0
```

Client-server file transfer (`CLIENT SERVER/4transfer.awk` on `CLIENT SERVER/4.tr`):

```
Transmission time required to transfer the file 9.999200
 Actual data sent from the server is 0.400440mbps
 Actual data received by the client is 0.369640mbps
```

FTP throughput (`FTP/lp2.awk` on `FTP/2.tr`, after fixing a `Cbr_sz`/`cbr_sz` typo in the script):

```
9.996587 3.37024
9.996587 0 32.3917
```
