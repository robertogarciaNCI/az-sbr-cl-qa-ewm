#!/bin/bash

ticketNum="22116655"

for grpName in 'nci_cloud' 'nci_support' 'nci_secops'; do
  #grpName='change me <valid values, nci_cloud|nci_support|nci_secops'

  RUSTR="Cmnd_Alias USRMGT = "
  COM1=$(for c1 in useradd usermod userdel groupadd groupmod groupdel vipw vigr visudo su passwd; do
    echo $(which $c1 | tr '\n' ',')
  done)
  RUIO="Cmnd_Alias IOMGT = "
  COM2=$(for c2 in fdisk dd parted gdisk; do
    echo $(which $c2 | tr '\n' ',')
  done)
  case $grpName in
  "nci_support")
    inp_source=$(
      cat <<EOF1 | tr ' ' '_'
Adrian Catubay Adm,NCI Operations,adm.adrian.catubay
Adrian Pascua Adm,NCI Operations,adm.adrian.pascua
Adriana Diaz Adm,NCI Operations,adm.adriana.diaz
Andres Aparicio Adm,NCI Operations,adm.andres.aparicio
Andres Carreno Adm,NCI Operations,adm.andres.carreno
April Calixtro Adm,NCI Operations,adm.april.calixtro
David Flores Adm,NCI Operations,adm.david.flores
Diana Makiling Adm,NCI Operations,adm.diana.makiling
Holman Rodriguez Adm,NCI Operations,adm.holman.rodriguez
jhoan Garcia Adm,NCI Operations,adm.jhoan.garcia
Jules Antonio Adm,NCI Operations,adm.Jules.Antonio
Julian Prias Adm,NCI Operations,adm.julian.prias
Katherine Altamar Adm,NCI Operations,adm.k.altamar
Leydy Ceron Adm,NCI Operations,adm.leydy.ceron
Michole Delvalle Adm,NCI Operations,adm.m.delvalle
Servelle Lopos Adm,NCI Operations,adm.servelle.lopos
Cesar Ramiro Beltran Hernandez Adm,NCI Operations,adm.cesar.beltran
Kevin Hadir Rincon Suarez Adm,NCI Operations,adm.kevin.rincon
Maria Camila Tobon Torres Adm,NCI Operations,adm.maria.tobon
Cielo Ann Abolencia Adm,NCI Operations,adm.cieolo.abolencia
Hernandeo Hernandez Adm,NCI Operations,adm.h.hernandez
Claudia Patino Adm,NCI Operations,adm.claudia.patino
Yenifer Garcia Adm,NCI Operations,adm.yenifer.garcia
Gillian Bravo Adm,NCI Operations,adm.gillian.bravo
EOF1
    )
    ;;
  "nci_cloud")
    inp_source=$(
      cat <<EOF2 | tr ' ' '_'
Edwin Castellanos Adm,NCI Cloud,adm.ei.castellanos
Esteban Martinez Adm,NCI Cloud,adm.esteban.martinez
Fabian Angarita Adm,NCI Cloud,adm.fabian.angarita
Francisco Restrepo Adm,NCI Cloud,adm.fj.Restrepo
Jeremy Dave Adm,NCI Cloud,adm.jeremy.sanchez
Nino Rivamonte Adm,NCI Cloud,adm.nino.rivamonte
Rafael Gellangarin Adm,NCI Cloud,adm.r.gellangarin
Teody Ramos Adm,NCI Cloud,adm.teody.ramos
Jesus Arias Adm,NCI Cloud,adm.jesus.arias
Alfred Torres Adm,NCI Cloud,adm.alfred.torres
Oscar Loaiza Adm,NCI Cloud,adm.oscar.loaiza
Luis Torres Adm,NCI Cloud,adm.luis.torres
James William Adm,NCI Cloud,adm.james.viloria
Cesar Lancheros Adm,NCI Cloud,adm.cesar.lancheros
Andres Chavez Adm,NCI Cloud,adm.andres.chavez
Jojit Gagwis Adm,NCI Cloud,adm.jojit.gagwis
Laura Rodriguez Adm,NCI Cloud,adm.laura.rodriguez
Emily Madrid Adm,NCI Cloud,adm.emily.madrid
John Miraflor Adm,NCI Cloud,adm.john.miraflor
Julian Gomez Adm,NCI Cloud,adm.julian.gomez
Kassandra Evora Adm,NCI Cloud,adm.kassandra.evora
Martin Gutierrez Adm,NCI Cloud,adm.martin.gutierrez
Roberto Garcia Adm,NCI Cloud,adm.roberto.garcia
Ziarene Alba Adm,NCI Cloud,adm.ziarene.alba
Jenskier Tajuda adm,NCI Cloud,adm.jenskier.Tajuda
Sebastian Becerra Adm,NCI Cloud,adm.s.becerra
Maria Ramirez Adm,NCI Cloud,adm.maria.ramirezb
Francy Tibaduiza Adm,NCI Cloud,adm.francy.tibaduiza
Andres Moreno Adm,NCI Cloud,adm.andres.moreno
Juan Galicia Adm,NCI Cloud,adm.juan.galicia
Daniel Bogoya Adm,NCI Cloud,adm.daniel.bogoya
Alex Johan De Moya Munoz Adm,NCI Cloud,adm.alex.demoya
Alexander de Jesus Uribe Munoz,NCI Cloud,adm.alexander.uribe
James Alexander Melo Alfaro Adm,NCI Cloud,adm.james.melo
Shiela May Barcenal,NCI Cloud,adm.shiela.barcenal
Julian Andres Riscanevo Aparicio Adm,NCI Cloud,adm.julian.riscanevo
Felipe Garrido Castillo,NCI Cloud,adm.felipe.garrido
Mario Alberto Beltran Solano,NCI Cloud,adm.mario.beltran
Wilfer Osorio Cardona,NCI Cloud,adm.wilfer.osorio
Alvin Tuazon,NCI Cloud,adm.Alvin.Tuason
Jessa Mae Alogon,NCI Cloud,adm.Jessah.Alogon
Esteeven Gonzalez Pena,NCI Cloud,adm.ever.gonzalez
Jacqueline Yu Adm,NCI Cloud,adm.jacqueline.yu
Jaime Fernandez Jr Adm,NCI Cloud,adm.jaime.fernandezjr
Yesid Puerto Adm,NCI Cloud,adm.yesid.puerto
Gustavo Cordoba Adm,NCI Cloud,adm.gustavo.cordoba
EOF2
    )
    ;;
  "nci_secops")
    inp_source=$(
      cat <<EOF3 | tr ' ' '_'
Abegail Lapuz Adm,NCI SecOps,adm.abegail.lapuz
Diego Ramos Adm,NCI SecOps,adm.diego.ramos
Eliana Rodriguez Adm,NCI SecOps,adm.eliana.rodriguez
Patricia Denise Cruz Adm,NCI SecOps,adm.patriciad.cruz
Patricia Jhane Cruz Adm,NCI SecOps,adm.PatriciaJ.Cruz
Shanaya Suarez Adm,NCI SecOps,adm.shanaya.suarez
Valeria Garcia Adm,NCI SecOps,adm.valeria.garcia
Yinzza Shirley Suarez Shanaya adm,NCI SecOps,adm.Yinzza.Shanaya
EOF3
    )
    ;;
  esac
  $inp_source
  for uc in $inp_source; do
    u=$(echo $uc | awk -F',' '{ printf $3 }' | tr -d " ")
    c=$(echo $uc | awk -F',' '{ print $1 }')
    comment=$(echo $c | tr '_' ' ')$(echo " $grpName-$ticketNum")
    getent group $grpName >/dev/null
    [ $? -gt 0 ] && sudo groupadd $grpName >/dev/null
    getent passwd $u >/dev/null
    [ $? -gt 0 ] && sudo useradd -s /bin/bash -c "$comment" -g "$grpName" $u >/dev/null
    case $grpName in
    "nci_support")
      srule='ALL = (root) NOPASSWD: ALL, !USRMGT'
      ;;
    "nci_cloud")
      srule='ALL = (ALL) NOPASSWD: ALL'
      ;;
    "nci_secops")
      srule='ALL = (root) NOPASSWD: ALL, !USRMGT, !IOMGT'
      ;;
    esac
    [ ! -f /etc/sudoers.d/00_Defaults ] && cat <<-EOF | sudo su -c "EDITOR='tee' visudo -f /etc/sudoers.d/00_Defaults" >/dev/null
                $(echo $RUSTR${COM1:0:-1})
                $(echo $RUIO${COM2:0:-1})
EOF
    [ ! -f /etc/sudoers.d/$grpName ] && echo "%$grpName $srule" | sudo su -c "EDITOR='tee' visudo -f /etc/sudoers.d/$grpName" >/dev/null
    echo "$u:$(
      LC_ALL=C tr -dc '[:graph:]' </dev/urandom | head -c 24
      echo
    )" >>/var/tmp/DELETEME.txt
  done
done
cat /var/tmp/DELETEME.txt | sudo chpasswd
rm /var/tmp/DELETEME.txt
