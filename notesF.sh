#! /bin/bash
chmod +x notesF.sh
#! notesF.sh script
notesF ()
 {
echo $1
while IFS="," read -r  prenom nom ID TP1 TP2 TP3 TP4 Intra Final
  do
    echo "i got : $prenom| $nom | $ID | $TP1 | $TP2 |$TP3 | $TP4| $Intra |$Final"
    pond=IetF 25 35
    noteIetF=$noteExam $Intra $Final
    if (($noteIerF > $pond));then
       noteTP=notesTp $TP1 $TP2 $TP3 $TP4
       ((total=$noteIetF+$noteTP))
       echo $prenom $nom $ID $TP1 $TP2 $TP3 $TP4 $notesIeT $total
    else
     noteTP=notesTp $TP1 $TP2 $TP3 $TP4
       ((total=$noteIetF+($noteTP/2)))
       echo $prenom $nom $ID $TP1 $TP2 $TP3 $TP4 $notesIeT $total
    
    fi
     
done < $1

 }


IetF()
{
     z=$1+$2
     y=($z)%2
     x=($z)/2
     t=$x+$y 
    pond=$((t))
   echo $pond
   return $pond
 
} 
notesTp ()
{
    tp1=$1
    tp2=$2
    tp3=$3
    tp4=$4
    pTp=10/100
    ((noteTp1=$tp1*$pTp))|bc
    ((noteTp2=$tp2*$pTp))|bc
    ((noteTp3=$tp3*$pTp))|bc
    ((noteTp4=$tp4*$pTp))|bc
    ((note=$noteTp1+$noteTp2+$noteTp3+$noteTp4))|bc
    #echo $note
   # echo "result"
    return $note
}

noteExam ()
{
 intra=$1
 final=$2
 ((intaPond=$intra*25/100))|bc
 ((finalPond=$final*30/100))|bc 
 ((total=$intaPond+finalPond))|bc
 retun $total

}
notesF listeNotes.csv
mathNotes 50 40 60 80