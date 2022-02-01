BEGIN{
 total_bytes_sent=0;
 total_bytes_received=0;
}
{
if ($1=="r" && $4=="1" && $5=="tcp") total_bytes_received+=$6;
if ($1=="+" && $3=="0" && $5=="tcp") total_bytes_sent+=$6;
}
END{
printf("\n Transmission time required to transfer th efile %f",$2);
printf("\n Actual data sent from the server is %fmbps",total_bytes_sent/1000000);
printf("\n Actual data received by the client is %fmbps\n",total_bytes_received/1000000);
}
