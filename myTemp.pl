#!/usr/bin/perl
$mods = `cat /proc/modules`;
if ($mods =~ /w1_gpio/ && $mods =~ /w1_therm/) {
   #print "w1 modules already loaded \n";
}
else {
   #print "loading w1 modules \n";
   $mod_gpio = `sudo modprobe w1-gpio`;
   $mod_them = `sudo modprobe w1-therm`;
}

$date_time = `date +%D\\ %R`;
chomp($date_time);
print $date_time;
for my $sensor ( "28-000005b34b42", "28-000005b39bfb", "28-000005b3cf22" ) {
   #print "$sensor: ";
   $sensor_temp{$sensor} = `cat /sys/bus/w1/devices/$sensor/w1_slave 2>&1`;
   if ($sensor_temp{$sensor} !~ /No such file or directory/) {
      if ($sensor_temp{$sensor} !~ /NO/) {
         $sensor_temp{$sensor} =~ /t=(\d+)/i;
         my $raw_temp = $1;
         $temperature = ($1/1000);
         $fah = (9 * $temperature/5) + 32;
         #print "= $fah ($temperature) ($raw_temp)\n";
         print ",$fah"
      } else {
         die "Error locating sensor file or sensor CRC was invalid";
      }
   }
}
print "\n";
exit;
