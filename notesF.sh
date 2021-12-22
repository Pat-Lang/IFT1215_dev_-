#! /bin/bash
chmod +x notesF.sh
#! notesF.sh script
notesF ()
 {
echo "$1"
while IFS="," read -r  prenom nom ID TP1 TP2 TP3 TP4 Intra Final
  do
    echo "i got : $prenom|$nom |$ID |$TP1 |$TP2 |$TP3 |$TP4|$Intra |$Final"
    IetF 25 35
    #echo $pond
    echo $Intra
    echo $Final
   noteExam "$Intra" "$Final"
    echo "$noteExam"
    noteTp "$TP1" "$TP2" "$TP3" "$TP4"
    echo "$noteTp"
    if "$noteExam" > "$pond";then
       
       total=$( echo "scale=2;$noteTp+$noteExam" | bc)
       echo " final : $prenom| $nom| $ID| $TP1| $TP2| $TP3| $TP4| $noteExam |$total"
    else
     #notesTp $TP1 $TP2 $TP3 $TP4
       total=$( echo "scale=2; $noteExam+($noteTp/2)" | bc)
       echo " final : $prenom|$nom |$ID |$TP1 |$TP2 |$TP3 |$TP4 |$noteExam |$total"
    
    fi
     
done >> "liste.csv"
echo "end"

 }


IetF()
{
     z=$1+$2
     pond=$( echo "scale=2; ($z)/2" | bc)
    #echo $pond
}
noteTp ()
{
    pTp=$( echo "scale=2; 10/100" | bc) 
    Tp1=$( echo "scale=2; $1*$pTp" | bc)
    Tp2=$( echo "scale=2; $2*$pTp" | bc)
    Tp3=$( echo "scale=2; $3*$pTp" | bc)
    Tp4=$( echo "scale=2; $4*$pTp" | bc)
    noteTp=$( echo "scale=2; $Tp1+$Tp2+$Tp3+$Tp4" | bc )
}

noteExam ()
{
 intraPond=$( echo "scale=2; $1*25/100" | bc)
 finalPond=$( echo "scale=2; $2*35/100"| bc) 
 noteExam=$( echo "scale=2; $intraPond+$finalPond" | bc)
 #echo $noteExam


}
notesF listeNotes.csv
