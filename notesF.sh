#! /bin/bash
chmod +x notesF.sh
#! notesF.sh script
notesF ()
 {
while IFS="," read -ers  prenom nom ID TP1 TP2 TP3 TP4 Intra Final extra
  do
    IetF 25 35
    Exam "$Intra" "$Final"
    noteTp "$TP1" "$TP2" "$TP3" "$TP4"
   if (( $(bc <<<"$noteExam > $pond") )); then 
      total=$( echo "scale=2;$noteTp+$noteExam" | bc)
      echo " final : $prenom| $nom| $ID| $TP1| $TP2| $TP3| $TP4| $noteExam |$total"
      echo " "
   else
      noteTp $TP1 $TP2 $TP3 $TP4
      total=$( echo "scale=2; $noteExam+($noteTp/2)" | bc)
      echo "final: $prenom|$nom |$ID |$TP1 |$TP2 |$TP3 |$TP4 |$Intra |$Final |$noteExam |$total"
      echo " "
    
   fi
     
done < "$1"
echo "end"

 }


IetF()
{
     z=$1+$2
     pond=$( echo "scale=2; ($z)/2" | bc)
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
Exam ()
{
noteExam=$( echo "scale=2; $Intra*25/100+$Final*35/100" | bc)
}

notesF listeNotes.csv