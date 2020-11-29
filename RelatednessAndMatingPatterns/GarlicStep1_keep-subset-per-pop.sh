#!/bin/bash
#SBATCH --mem=10GB

cd /datacommons/noor/klk37/CV/NewReseqData/Garlic-data

FILES=*.bed
for FILE in $FILES
do
	NAME="$(echo ${FILE} | awk -F'[.]' '{print $1}')"
	/opt/apps/rhel7/plink-1.90/plink --bfile $NAME --keep keep-fogo.txt --make-bed --out "$NAME"_fogo
	/opt/apps/rhel7/plink-1.90/plink --bfile $NAME --keep keep-santiago.txt --make-bed --out "$NAME"_santiago
	/opt/apps/rhel7/plink-1.90/plink --bfile $NAME --keep keep-NWcluster236.txt --make-bed --out "$NAME"_NWcluster
	/opt/apps/rhel7/plink-1.90/plink --bfile $NAME --keep keep-BoaVista.txt --make-bed --out "$NAME"_BoaVista
	/opt/apps/rhel7/plink-1.90/plink --bfile $NAME --keep keep-GWD.txt --make-bed --out "$NAME"_GWD
	/opt/apps/rhel7/plink-1.90/plink --bfile $NAME --keep keep-IBS.txt --make-bed --out "$NAME"_IBS
done

FILES=*Females.bed
for FILE in $FILES
do
	NAME="$(echo ${FILE} | awk -F'[.]' '{print $1}')"
	/opt/apps/rhel7/plink-1.90/plink --bfile $NAME --keep keep-fogo.txt --make-bed --out "$NAME"_fogo
	/opt/apps/rhel7/plink-1.90/plink --bfile $NAME --keep keep-santiago.txt --make-bed --out "$NAME"_santiago
	/opt/apps/rhel7/plink-1.90/plink --bfile $NAME --keep keep-NWcluster236.txt --make-bed --out "$NAME"_NWcluster
	/opt/apps/rhel7/plink-1.90/plink --bfile $NAME --keep keep-BoaVista.txt --make-bed --out "$NAME"_BoaVista
	/opt/apps/rhel7/plink-1.90/plink --bfile $NAME --keep keep-GWD.txt --make-bed --out "$NAME"_GWD
	/opt/apps/rhel7/plink-1.90/plink --bfile $NAME --keep keep-IBS.txt --make-bed --out "$NAME"_IBS
done

FILES=*7_Females.bed
for FILE in $FILES
do
	NAME="$(echo ${FILE} | awk -F'[.]' '{print $1}')"
	/opt/apps/rhel7/plink-1.90/plink --bfile $NAME --keep keep-fogo.txt --make-bed --out "$NAME"_fogo
	/opt/apps/rhel7/plink-1.90/plink --bfile $NAME --keep keep-santiago.txt --make-bed --out "$NAME"_santiago
	/opt/apps/rhel7/plink-1.90/plink --bfile $NAME --keep keep-NWcluster236.txt --make-bed --out "$NAME"_NWcluster
	/opt/apps/rhel7/plink-1.90/plink --bfile $NAME --keep keep-BoaVista.txt --make-bed --out "$NAME"_BoaVista
	/opt/apps/rhel7/plink-1.90/plink --bfile $NAME --keep keep-GWD.txt --make-bed --out "$NAME"_GWD
	/opt/apps/rhel7/plink-1.90/plink --bfile $NAME --keep keep-IBS.txt --make-bed --out "$NAME"_IBS
done
