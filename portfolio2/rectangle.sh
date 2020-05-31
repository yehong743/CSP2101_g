#!/bin/bash
#Student Name: Hong Ye Student ID: 10470951
inFile="rectangle.txt" 
outFile="rectangle_f.txt"
touch $outFile  #create a file if the output file does not exist
truncate -s 0 $outFile #make sure the output file is initialed empty

fields=$(sed -n '1p' ${inFile}) #read the first line of the input file, which is the name of the data fields.
fields=${fields//\\n/} # replace all the "\n" with empty
fields_array=(${fields//,/ }) # replace all the "," with " "
field_num=${#fields_array[@]} # split the string into an array
data_num=$(sed -n "\$=" ${inFile}) #count the number of total line of the input file
for ((i=2;i<=${data_num};i++)) # read the data from input file line by line and write it to output file  
	do
		data=$(sed -n "${i}p" ${inFile})
		data_array=(${data//,/ })
		str=""
		for ((j=0;j<${field_num};j++)) #add all the fields of a record to the string ready to be written
		do
		    str=${str}${fields_array[${j}]}": "${data_array[${j}]}"\\t"
		done
		# if current record is the first record to be written, then use echo because "sed" can not handle empty file.
		if [ ${i} -eq 2 ] 
		then
		    echo -e ${str} >> ${outFile}
		else
		    sed -i "\$a ${str}" ${outFile} #write the record to output file by "sed"
		fi
	done

		
