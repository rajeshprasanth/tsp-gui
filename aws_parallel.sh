#!/bin/bash
sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
sudo yum update
sudo yum -y install wget unzip sed gcc quantum-espresso* make htop
wget https://vicerveza.homeunix.net/~viric/soft/ts/ts-1.0.tar.gz
tar zxvf ts-1.0.tar.gz
cd ts-1.0
make
cp ts /usr/bin/tsp
cd ~/
echo "export PATH=/usr/lib64/openmpi/bin:\$PATH" >> ~/.bashrc
echo "localhost slots=32" >> ~/hostfile
source ~/.bashrc

cat >/usr/bin/alertscreen<< EOF
#!/bin/bash
#
# Alert Screen for task spooler
#
#
AUTOREFRESHTIME=10


echo -e "\e[3J"
while true
    do
        tput clear
        echo -e "\e[3J"
        printf "+=======================================================+\n"
        printf "|                   Task Spooler                        |\n"
        printf "|                Monitoring System                      |\n"
        printf "+=======================================================+\n"
        printf " Date :: $(date +"%D %T")\n"
        printf "+-------------------------------------------------------+\n"
        abort=`tsp -l |grep finished|gawk '{ if ( $4 != "0" ) print; }'|wc -l`
        completed=`tsp -l |grep finished|gawk '{ if ( $4 == "0" ) print; }'|wc -l`
        running=`tsp -l |grep running|wc -l`
        queued=`tsp -l |grep queued|wc -l`
        printf " Aborted Jobs # $(tsp -l |grep finished|gawk '{ if ( $4 != "0" ) print; }'|wc -l)\n" 
        printf " Completed Jobs # $(tsp -l |grep finished|gawk '{ if ( $4 == "0" ) print; }'|wc -l)\n" 
        printf " Running Jobs # $(tsp -l |grep running|wc -l)\n" 
        printf " Queued Jobs # $(tsp -l |grep queued|wc -l) \n"
        printf ""
        sleep $AUTOREFRESHTIME
    done


EOF


cat > /usr/bin/monitorworkflow << EOF
#!/bin/bash
#
#========================================#
# Monitoring script for batch processing #
#========================================#
#
#
AUTOREFRESH=Y
AUTOREFRESHTIME=5
FUNC=$1
#
#
print_finished_normally() {
    tput clear
    echo -e "\e[3J"
    printf "+=============================================================================+\n"
    printf "|                                   Task Spooler                              |\n"
    printf "|                                Monitoring System                            |\n"
    printf "+=============================================================================+\n"
    printf "                             LIST OF COMPLETED JOBS\n"
    printf "+=============================================================================+\n"
    tsp|head -n 1
    printf "+=============================================================================+\n"
    tsp -l |grep finished|gawk '{ if ( $4 =="0" ) print; }'
    #tsp -l |grep finished|gawk '{ if ( $4 =="0" ) print; }'
    
    sleep $1
}

print_finished_abnormally() {
    tput clear
    echo -e "\e[3J"
    printf "+=============================================================================+\n"
    printf "|                                   Task Spooler                              |\n"
    printf "|                                Monitoring System                            |\n"
    printf "+=============================================================================+\n"
    printf "                               LIST OF ABORTED JOBS\n"
    printf "+=============================================================================+\n"
    tsp|head -n 1
    printf "+=============================================================================+\n"
    tsp -l |grep finished|gawk '{ if ( $4 != "0" ) print; }'
    #tsp -l |grep finished|gawk '{ if ( $4 =="0" ) print; }'
    
    sleep $1
}

print_queued() {
    tput clear
    echo -e "\e[3J"
    printf "+=============================================================================+\n"
    printf "|                                   Task Spooler                              |\n"
    printf "|                                Monitoring System                            |\n"
    printf "+=============================================================================+\n"
    printf "                                LIST OF QUEUED JOBS\n"
    printf "+=============================================================================+\n"
    tsp|head -n 1
    printf "+=============================================================================+\n"
    tsp -l |grep queued
    sleep $1
}

print_running() {
    tput clear
    echo -e "\e[3J"
    printf "+=============================================================================+\n"
    printf "|                                   Task Spooler                              |\n"
    printf "|                                Monitoring System                            |\n"
    printf "+=============================================================================+\n"
    printf "                               LIST OF RUNNING JOBS\n"
    printf "+=============================================================================+\n"
    tsp|head -n 1
    printf "+=============================================================================+\n"
    tsp -l |grep running
    sleep $1
}

call_func () {
    echo -e "\e[3J"
    while true
    do
        $1 $AUTOREFRESHTIME
    done
}


if [$# -ne 1 ]
then
    echo "Fatal Error :: Incorrect arguments:::"
    exit 1
fi

if [ $FUNC = "running" ]
then
    call_func print_running

elif [ $FUNC = "queued" ]
then
    call_func print_queued
    
elif [ $FUNC = "normally" ]
then
    call_func print_finished_normally
    
elif [ $FUNC = "abnormally" ]
then
    call_func print_finished_abnormally

else
    echo "Incorrect arguments"
 
fi














EOF



cd ~
mkdir pseudo
cd pseudo
wget https://www.quantum-espresso.org/upf_files/Mg.pbe-mt_fhi.UPF
wget https://www.quantum-espresso.org/upf_files/Si.pbe-mt_fhi.UPF
wget https://www.quantum-espresso.org/upf_files/Ge.pbe-mt_fhi.UPF
wget https://www.quantum-espresso.org/upf_files/Sn.pbe-mt_fhi.UPF
wget https://www.quantum-espresso.org/upf_files/Sb.pbe-mt_fhi.UPF

wget https://www.quantum-espresso.org/upf_files/Mg.pw-mt_fhi.UPF
wget https://www.quantum-espresso.org/upf_files/Si.pw-mt_fhi.UPF
wget https://www.quantum-espresso.org/upf_files/Ge.pw-mt_fhi.UPF
wget https://www.quantum-espresso.org/upf_files/Sn.pw-mt_fhi.UPF
wget https://www.quantum-espresso.org/upf_files/Sb.pbe-mt_fhi.UPF

wget https://www.quantum-espresso.org/upf_files/Ca.pbe-mt_fhi.UPF
wget https://www.quantum-espresso.org/upf_files/Ca.pw-mt_fhi.UPF
cd ~
mkdir run
