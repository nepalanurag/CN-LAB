BEGIN{
tcp_count=0;
udp_count=0;
tcp_r_count=0;
udp_r_count=0;
}{
if ($1=="d" && $5=="tcp") tcp_count++;
if ($1=="d" && $5=="cbr") udp_count++;
if ($1=="r" && $5=="tcp") tcp_r_count++;
if ($1=="r" && $5=="cbr") udp_r_count++;
}
END{
printf("TCP receive %d\n",tcp_r_count);
printf("UDP receive %d\n",udp_r_count);
printf("TCP drop %d\n",tcp_count);
printf("UDP drop %d\n",udp_count);
}
