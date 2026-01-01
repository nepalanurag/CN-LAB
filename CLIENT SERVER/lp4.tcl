set ns [new Simulator]
set tf [open 4.tr w]
$ns trace-all $tf
set nf [open 4.nam w]
$ns namtrace-all $nf

set n0 [$ns node]
set n1 [$ns node]

$n0 label "Client"
$n1 label "Server"

$ns duplex-link $n0 $n1 0.3Mb 10ms DropTail
set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n1 $sink
$tcp set packetSize_ 1500
$ns connect $tcp $sink

set ftp [new Application/FTP]
$ftp attach-agent $tcp

$ns at 0.1 "$ftp start"
$ns at 10.0 "finish"

proc finish {} {
global ns tf nf cwind
$ns flush-trace
close $tf
close $nf
puts "running nam..."
exec nam 4.nam &
exec awk -f 4transfer.awk 4.tr &
exec awk -f 4convert.awk 4.tr > a1.tr &
exec xgraph a1.tr
exit 0
}
$ns run
