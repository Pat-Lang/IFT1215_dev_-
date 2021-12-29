#! /bin/bash
chmod +x notesF.sh
#! notesF.sh script


#main branch qui call tout les autres fontion 
# a comme but de prendre des donnees cvs et les compiles pour donner 
# la note final.


notesF ()
 {
     i=0
while IFS="," read -ers  prenom nom ID TP1 TP2 TP3 TP4 Intra Final extra
  do
  
  if (( $(bc <<<"$i == 0") )); then 
    IetF 25 35
    echo " $prenom| $nom| $ID| $TP1| $TP2| $TP3| $TP4| $Intra |$Final |IetF("$pond"%) |Total"
    i=$((i+1))
    
    
  elif (( $(bc <<<"$i == !0") )); then 
      IetF 25 35
      Exam "$Intra" "$Final"
      noteTp "$TP1" "$TP2" "$TP3" "$TP4"
      if (( $(bc <<<"$noteExam > $pond") )); then 
         #echo "pass"
         total=$( echo "scale=2;$noteTp+$noteExam" | bc)
         echo " $prenom| $nom| $ID| $TP1| $TP2| $TP3| $TP4|$Intra |$Final |$noteExam |$total"
      else
         #echo "fail"
         noteTp $TP1 $TP2 $TP3 $TP4
         total=$( echo "scale=2; $noteExam+($noteTp/2)" | bc)
         echo " $prenom|$nom |$ID |$TP1 |$TP2 |$TP3 |$TP4 |$Intra |$Final |$noteExam |$total"
    
      fi
   fi
     
done < "$1"
echo "end"

 }

# IetF {pond intra} {pond final} calacul la ponderation des deux
    # et retourne la note de passage requise
IetF()
{
     z=$1+$2
     pond=$( echo "scale=2; ($z)/2" | bc)
     
}
# la fonction noteTp {note TP1}{note TP2}{note TP3}{note TP4}
    #applique la ponderation de 10% et sum les notes
noteTp ()
{
    pTp=$( echo "scale=2; 10/100" | bc) 
    Tp1=$( echo "scale=2; $1*$pTp" | bc)
    Tp2=$( echo "scale=2; $2*$pTp" | bc)
    Tp3=$( echo "scale=2; $3*$pTp" | bc)
    Tp4=$( echo "scale=2; $4*$pTp" | bc)
    noteTp=$( echo "scale=2; $Tp1+$Tp2+$Tp3+$Tp4" | bc )
}
 # la fontion exam prend {note Intra}{note final} et renvoi 
    #le combiné des deux notes ponderées
Exam ()
{
noteExam=$( echo "scale=2; $Intra*25/100+$Final*35/100" | bc)
}

notesF $1