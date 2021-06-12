# snmp_user_enum
Simple SNMPv3 user enumeration script. The script takes two positional arguments: a text file containing target IPv4 addresses and a text file containing usernames to test. In both files, entries should be separated by a newline. The script tests credentials for each security level supported by SNMPv3 with certain defaults assumed for certain levels, e.g. MD5 hashing for authNoPriv.

## example target input file content
127.0.0.1  
127.0.0.2  
127.0.0.3

## example user input file content
admin  
root  
bobfromaccounting

## example usage
./snmp_user_enum.sh compiled_target_list.txt compiled_username_guesses.txt

## example output
target : **127.0.0.1**  
username : **admin**  
security level : **noAuthNoPriv**  
snmpwalk: Unknown user name

target : **127.0.0.1**  
username : **admin**  
security level : **authNoPriv**  
snmpwalk: Unknown user name

target : **127.0.0.1**  
username : **admin**  
security level : **authPriv**  
snmpwalk: Unknown user name
