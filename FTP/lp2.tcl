set ns [new Simulator]

set tf [open 2.tr w]
$ns trace-all $tf

set nf [open 2.nam w]
$ns namtrace-all $nf

set cwind [open win2.tr w]


set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$ns duplex-link $n0 $n2 5Mb 2ms DropTail
$ns duplex-link $n1 $n2 5Mb 2ms DropTail
$ns duplex-link $n2 $n3 0.4Mb 10ms DropTail
$ns duplex-link $n3 $n4 1.5Mb 2ms DropTail
$ns duplex-link $n3 $n5 1.5Mb 2ms DropTail
$ns queue-limit $n2 $n3 10

set tcp0 [new Agent/TCP]
set sink0 [new Agent/TCPSink]
set ftp0 [new Application/FTP]
$ns attach-agent $n0 $tcp0
$ns attach-agent $n5 $sink0
$ns connect $tcp0 $sink0
$ftp0 attach-agent $tcp0
$ns at 1.2 "$ftp0 start"

set tcp1 [new Agent/TCP]
set sink1 [new Agent/TCPSink]
set telnet [new Application/Telnet]
$ns attach-agent $n1 $tcp1
$ns attach-agent $n4 $sink1
$ns connect $tcp1 $sink1
$telnet attach-agent $tcp1

$ns at 1.5 "$telnet start"


$ns at 10.0 "finish"

proc plotWindow {tcpSource file} {
global ns
set time 0.01
set now [$ns now]
set cwnd [$tcpSource set cwnd_]
puts $file "$now $cwnd"
$ns at [expr $now+$time] "plotWindow $tcpSource $file"
}
$ns at 2.0 "plotWindow $tcp0 $cwind"
#$ns at 5.5 "plotWindow $tcp1 $cwind"

proc finish {} {
 global ns tf nf cwind
 $ns flush-trace
 close $tf
 close $nf
 puts "running nam..."
 puts "FTP Packets..."
 puts "Telnet Packets...."
 exec nam 2.nam &
 exec xgraph win2.tr &
 exit 0
}
$ns run
