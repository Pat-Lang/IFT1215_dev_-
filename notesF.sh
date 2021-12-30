#! /bin/bash
chmod +x notesF.sh
#! notesF.sh script


#main branch qui call tout les autres fontion 
# a comme but de prendre des donnees cvs et les compiles pour donner 
# la note final.
#prend 3 arguments {nom du fichier liseNotes.csv }{seuil de passage Ex:50} 
# {groupe ex:A16}
#les linges du fichier csv doivent ce finir par une vergule (,) si crée
# sur widows. mauviase traduction cause un bug pour le line change CHAR.
# renvoi un fichier notes{groupe}.csv

notesF ()
 {
    touch notes$3.csv 
    > notes$3.csv  
     i=0
while IFS="," read -ers  prenom nom ID TP1 TP2 TP3 TP4 Intra Final extra
  do
  
  if (( $(bc <<<"$i == 0") )); then 
    IetF 25 35 $2
    echo " $prenom, $nom, $ID, $TP1, $TP2, $TP3, $TP4, $Intra ,$Final ,IetF("$pond"%) ,Total" >> notes$3.csv 
    i=$((i+1))
    
    
  elif (( $(bc <<<"$i == !0") )); then 
      IetF 25 35 $2
      Exam "$Intra" "$Final"
      noteTp "$TP1" "$TP2" "$TP3" "$TP4"
      if (( $(bc <<<"$noteExam > $pond") )); then 
         total=$( echo "scale=2;$noteTp+$noteExam" | bc)
         echo " $prenom, $nom, $ID, $TP1, $TP2, $TP3, $TP4, $Intra, $Final, $noteExam, $total" >> notes$3.csv 
      else
         noteTp $TP1 $TP2 $TP3 $TP4
         total=$( echo "scale=2; $noteExam+($noteTp/2)" | bc)
         echo " $prenom, $nom, $ID, $TP1, $TP2, $TP3, $TP4, $Intra, $Final, $noteExam, $total" >> notes$3.csv 
    
      fi
   fi
     
done < "$1"
echo "end"

 }

# IetF {pond intra} {pond final} calacul la ponderation des deux
    # et retourne la note de passage requise
IetF()
{
     #echo $3
     z=$1+$2
     y=$( echo "scale=2; $3/100" | bc)
     pond=$( echo "scale=2; ($z)*$y" | bc)
     #echo $pond
     
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

notesF $1 $2 $3