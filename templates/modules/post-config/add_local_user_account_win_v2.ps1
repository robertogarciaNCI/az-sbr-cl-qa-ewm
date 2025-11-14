$ticketRef = "22116655"

$inp_source_cloud = @"
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
"@

$inp_source_ops = @"
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
Valentina Martinez Adm,NCI Operations,adm.ext.ve.martinez
Cesar Ramiro Beltran Hernandez Adm,NCI Operations,adm.cesar.beltran
Kevin Hadir Rincon Suarez Adm,NCI Operations,adm.kevin.rincon
Maria Camila Tobon Torres Adm,NCI Operations,adm.maria.tobon
Cielo Ann Abolencia,NCI Operations,adm.cielo.abolencia
Hernando Hernandez,NCI Operations,adm.H.Hernandez
"@

$inp_source_secops = @"
Abegail Lapuz Adm,NCI SecOps,adm.abegail.lapuz
Diego Ramos Adm,NCI SecOps,adm.diego.ramos
Eliana Rodriguez Adm,NCI SecOps,adm.eliana.rodriguez
Patricia Denise Cruz Adm,NCI SecOps,adm.patriciad.cruz
Patricia Jhane Cruz Adm,NCI SecOps,adm.PatriciaJ.Cruz
Shanaya Suarez Adm,NCI SecOps,adm.shanaya.suarez
Valeria Garcia Adm,NCI SecOps,adm.valeria.garcia
Yinzza Shirley Suarez Shanaya adm,NCI SecOps,adm.Yinzza.Shanaya
"@

$result = @()
$inpFile = @($inp_source_cloud,$inp_source_ops,$inp_source_secops)
$inpFile = $inpFile | convertfrom-csv -header Name,Description,UserId

foreach($u in $inpFile) {
    $npass=(-join ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_/\!@#`$%^".tochararray() | get-random -count 24 | foreach-Object {[char]$_} ))
    $pass = ConvertTo-SecureString $npass -AsPlainText -Force
    try {
        if ( $null -ne $ticketRef ) { 
            $desc = "$($u.Description)" + " - $ticketRef" 
        } else {
            $desc = $($u.Description)
        }
        If ( $($u.UserId).Length -gt 20 ) {
            $userid=$($u.UserId).trimend().substring(0,20)
        } else {
            $userid=$($u.userid)
        }
        $testUser = New-LocalUser -Name $userid -Password $pass -Description "$desc" -FullName "$($u.Name)" -ErrorAction SilentlyContinue
        if ( $null -ne $testUser ) {
            $creds = "$userid" + ':' + "*************" 
        } else {
            $creds = ""
            write-output "User account $userid already exists. Skipping..."
        }
        Add-LocalGroupMember -Group 'Administrators' -Member $userid -ErrorAction SilentlyContinue
        $result += $creds
    } catch {
        write-output 'User account might exist already...'
    }
}
