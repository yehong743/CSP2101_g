#!/bin/bash
#Student name: Hong Ye Student id: 10470951

BASE_URL="https://www.ecu.edu.au/service-centres/MACSC/gallery/gallery.php?folder=152"

function downloadSpecificNum() {
	curl -L -s -o index.html https://www.ecu.edu.au/service-centres/MACSC/gallery/gallery.php?folder=152
	# retrieve image urls as array
	img_urls=`cat index.html | grep -E -o "*https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC.*.jpg*"`
	# because there are in total of 80 number of pictures, set the number to 80 and choose a random number from 1 to 80
	img_num=80
	for (( i = 0; i < $1; i++ )); do
		# get random image number
		rnd=$((RANDOM%80))
		n=0
		for img_url in $img_urls; do
			let n=n+1
			# loop until random number reaches
			if [[ $n -eq rnd ]]; then
				file_name=`echo $img_url | grep -E -o "DSC.*.jpg*"`
				# download image with file name specfied
				curl -o $file_name $img_url 
				# get file size by getting file attributes and cut the 5th attribute
				file_size=`ls -lh $file_name | awk '{print $5}'`
				echo "Downloading $file_name, with the file name $file_name.jpg, with a file size of ${file_size}...File Download Complete"
				echo ""
			fi
		done
	done
}

function downloadAll() {
	curl -L -s -o index.html https://www.ecu.edu.au/service-centres/MACSC/gallery/gallery.php?folder=152
	# retrieve image urls as array
	img_urls=`cat index.html | grep -E -o "*https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC.*.jpg*"`
	for img_url in $img_urls
	do
		file_name=`echo $img_url | grep -E -o "DSC.*.jpg*"`
		# download image with file name specfied
		curl -o $file_name $img_url 
		# get file size by getting file attributes and cut the 5th attribute
		file_size=`ls -lh $file_name | awk '{print $5}'`
		echo "Downloading $file_name, with the file name $file_name.jpg, with a file size of ${file_size}...File Download Complete"
		echo ""
	done

}

function downloadSpecificThumbnail() {
	curl -L -s -o index.html https://www.ecu.edu.au/service-centres/MACSC/gallery/gallery.php?folder=152
	# get file name
	file_name="$1"
	img_url="https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/$1.jpg"
	# download image with file name specfied
	curl -o $file_name $img_url 
	# get file size by getting file attributes and cut the 5th attribute
	file_size=`ls -lh $file_name | awk '{print $5}'`
	echo "Downloading $file_name, with the file name $file_name.jpg, with a file size of ${file_size}...File Download Complete"
	echo ""
}

function downloadInRange() {
	# retrieve image urls as array	
	img_urls=`cat index.html | grep -E -o "*https://secure.ecu.edu.au/service-centres/MACSC/gallery/152/DSC.*.jpg*"`
	for img_url in $img_urls; do
		# get file number
		file_num=`echo $img_url | cut -c 65-68`
		# compare file number and input range
		if [[ file_num -ge $1 ]] && [[ file_num -le $2 ]]; then
			file_name="DSC0$file_num"
			# download image with file name specfied
			curl -o $file_name $img_url
			# get file size by getting file attributes and cut the 5th attribute
			file_size=`ls -lh $file_name | awk '{print $5}'`
			echo "Downloading $file_name, with the file name $file_name.jpg, with a file size of ${file_size}...File Download Complete"
			echo ""
		fi
	done
}

function printHelp() {
	echo "Usage: Software.sh [option]"
 	echo " -a 				e.g. -a		Download ALL thumbnails"
 	echo " -s <thumbnail name> 		e.g. -s name	Download a specific thumbnail"
 	echo " -r <range start> <range end> 	e.g. -r x y	Download images in a range"	
 	echo " -n <number of images> 		e.g. -n number	Download a specified number of images"
}

# download all
if [[ $1 == "-a" ]];then 
	downloadAll
# download a specific thumbnail
elif [[ $1 == "-s" ]];then 
	downloadSpecificThumbnail $2
# download images in a range
elif [[ $1 == "-r" ]];then 
	downloadInRange $2 $3
# download a specified number of images
elif [[ $1 == "-n" ]];
then 
	downloadSpecificNum $2
else
	printHelp
fi
echo "PROGRAM FINISHED"