set ns [new Simulator]
set tf [open lp1.tr w]
$ns trace-all $tf
set nf [open lp1.nam w]
$ns namtrace-all $nf


set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
$ns duplex-link $n0 $n2 10Mb 2ms DropTail
$ns duplex-link $n1 $n2 10Mb 2ms DropTail
$ns duplex-link $n2 $n3 10Mb 10ms DropTail
$ns queue-limit $n2 $n3 5

set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0
set null0 [new Agent/Null]
$ns attach-agent $n3 $null0
$ns connect $udp0 $null0
set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0
$ns at 1.1 "$cbr0 start"

set tcp1 [new Agent/TCP]
$ns attach-agent $n1 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n3 $sink1
$ns connect $tcp1 $sink1
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1

$ns at 0.1 "$ftp1 start"
$ns at 2.5 "finish"

proc finish {} {
global ns nf tf
$ns flush-trace
close $nf
close $tf
puts "running nam...."
exec nam lp1.nam &
exit 0
}

$ns run

