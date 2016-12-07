#!/bin/bash
# Copyright (C) 2016 Nitrogen Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Nitrogen OS MR2 build script

ver_script=1.6

elixium_dir=elixium
elixium_build_dir=$elixium_dir-build

if ! [ -d ~/$elixium_build_dir ]; then
	echo -e "${bldred}No elixium-build directory, creating...${txtrst}"
	mkdir ~/$elixium_build_dir
fi

cpucores=$(cat /proc/cpuinfo | grep 'model name' | sed -e 's/.*: //' | wc -l)

configb=null
build_img=null
othermsg=""

# Colorize and add text parameters
red=$(tput setaf 1)			 #  red
grn=$(tput setaf 2)			 #  green
cya=$(tput setaf 6)			 #  cyan
txtbld=$(tput bold)			 # Bold
bldred=${txtbld}$(tput setaf 1) #  red
bldgrn=${txtbld}$(tput setaf 2) #  green
bldblu=${txtbld}$(tput setaf 4) #  blue
bldcya=${txtbld}$(tput setaf 6) #  cyan
txtrst=$(tput sgr0)			 # Reset

function build_elixium {
	if [ $configb = "null" ]; then
		echo "Device is not set!"
		break
	fi
	if [ -f builder_start.sh ]; then
		echo -e "Running start user script..."
		. builder_start.sh
		echo -e "Done!"
	fi
	echo -e "${bldblu}Setting up environment ${txtrst}"
	. build/envsetup.sh
	clear
	echo -e "${bldblu}Starting compilation ${txtrst}"
	res1=$(date +%s.%N)
	lunch elixium_dir_$configb-userdebug
	clear
	make otapackage -j$cpucores 2<&1 | tee builder.log
	res2=$(date +%s.%N)
	cd out/target/product/$configb
	FILE=Elixium-OS-$configb-`date +"%Y%m%d"`.zip
	FILE2=elixium_dir_$configb-Changelog.txt
	if [ -f ./$FILE ]; then
		echo -e "${bldgrn}Copyng zip file...${txtrst}"
		if [ -f ~/$elixium_dir_build_dir/$FILE ]; then
			rm ~/$elixium_dir_build_dir/$FILE
			cp $FILE ~/$elixium_dir_build_dir/$FILE
		else
			cp $FILE ~/$elixium_dir_build_dir/$FILE
		fi
	else
		echo -e "${bldred}Error copyng zip!${txtrst}"
	fi
	if [ -f ./$FILE2 ]; then
		echo -e "${bldgrn}Copyng changelog...${txtrst}"
		if [ -f ~/$elixium_dir_build_dir/$FILE2 ]; then
			rm ~/$elixium_dir_build_dir/$FILE2
			cp $FILE2 ~/$elixium_dir_build_dir/$FILE2
		else
			cp $FILE2 ~/$elixium_dir_build_dir/$FILE2
		fi
	else
		echo -e "${bldred}Error copyng changelog!${txtrst}"
	fi
	cd ~/$elixium_dir
	if [ -f builder_end.sh ]; then
		echo -e "Running end user script..."
		. builder_end.sh
		echo -e "Done!"
	fi
	echo "${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res2 - $res1) / 60"|bc ) minutes ($(echo "$res2 - $res1"|bc ) seconds) ${txtrst}"
}

function build_images {
	if [ $configb = "null" ]; then
		echo "Device is not set!"
		break
	fi
	. build/envsetup.sh
	if [ $build_img = "null" ]; then
		echo "Img file is not set!"
		break
	fi
	if [ $build_img = "boot" ]; then
		echo "Build boot.img/kernel..."
		res1=$(date +%s.%N)
		lunch elixium_dir_$configb-userdebug
		make bootimage -j$cpucores 2<&1 | tee builder.log
		res2=$(date +%s.%N)
		echo "${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res2 - $res1) / 60"|bc ) minutes ($(echo "$res2 - $res1"|bc ) seconds) ${txtrst}"
		break
	fi
	if [ $build_img = "recovery" ]; then
		echo "Build recovery.img..."
		res1=$(date +%s.%N)
		lunch elixium_dir_$configb-userdebug
		make recoveryimage -j$cpucores 2<&1 | tee builder.log
		res2=$(date +%s.%N)
		echo "${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res2 - $res1) / 60"|bc ) minutes ($(echo "$res2 - $res1"|bc ) seconds) ${txtrst}"
		break
	fi
	if [ $build_img = "system" ]; then
		echo "Build system.img..."
		res1=$(date +%s.%N)
		lunch elixium_dir_$configb-userdebug
		make systemimage -j$cpucores 2<&1 | tee builder.log
		res2=$(date +%s.%N)
		echo "${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res2 - $res1) / 60"|bc ) minutes ($(echo "$res2 - $res1"|bc ) seconds) ${txtrst}"
		break
	fi
	if [ $build_img = "all" ]; then
		echo "Build all images..."
		res1=$(date +%s.%N)
		lunch elixium_dir_$configb-userdebug
		make -j$cpucores 2<&1 | tee builder.log
		res2=$(date +%s.%N)
		echo "${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res2 - $res1) / 60"|bc ) minutes ($(echo "$res2 - $res1"|bc ) seconds) ${txtrst}"
		break
	fi
}

function setccache {
	while read -p "Use ccache for build (y/n)?
:> " cchoice
    do
    case "$cchoice" in
	y )
		export USE_CCACHE=1
		export CCACHE_DIR=~/.ccache/nitrogen
		prebuilts/misc/linux-x86/ccache/ccache -M 50G
		if ! [ -d ~/.ccache/$elixium_dir ]; then
			echo -e "${bldred}No ccache directory, creating...${txtrst}"
			mkdir ~/.ccache
			mkdir ~/.ccache/$elixium_dir
		fi
		ccachetrue="yes"
		break
		;;
	n )
		
		ccachetrue="no"
		break
		;;
	* )
		echo "Invalid! Try again!"
		clear
		;;
	esac
	done
}

function set_device {
while read -p "${grn}Please choose your device:${txtrst}
 1. geehrc (LG Optimus G intl E975)
 2. hammerhead (Google Nexus 5 D820, D821)
 3. mako (Google Nexus 4 E960)
 4. shamu (Google Nexus 6)
 5. Abort
:> " cchoice
do
case "$cchoice" in
	1 )
		configb=geehrc
		break
		;;
	2 )
		configb=hammerhead
		break
		;;
	3 )
		configb=mako
		break
		;;
	4 )
		configb=shamu
		break
		;;
	5 )
		break
		;;
	* )
		echo "Invalid, try again!"
		clear
		;;
esac
done
}

function mainmenu {
	setccache
	clear
	set_device
	clear
	if [ $configb = "null" ]; then
		device_text="Device is not set!"
	else
		device_text="Device: $configb"
	fi
	if [ $ccachetrue = "yes" ]; then
		ccachetext="Use cchache for build: yes"
	else
		ccachetext="Use cchache for build: no"
	fi
while read -p "${bldcya}Nitrogen OS 2.0 builder script v. $ver_script ${txtrst}
  $device_text
  $ccachetext
  Messages:
  $othermsg
  
${grn}Please choose your option:${txtrst}
  1. Clean build files
  2. Build rom to zip (ota package)
  3. Build boot.img
  4. Build recovery.img
  5. Build system.img
  6. Build all (all img files)
  7. Reset sources
  8. Install soft
  9. Change device
  10. Exit
${grn}:>${txtrst} " cchoice
do
case "$cchoice" in
	1 )
		make clean
		othermsg="All the compiled files have been deleted."
		clear
		;;
	2 )
		build_elixium
		break
		;;
	3 )
		build_img="boot"
		build_images
		break
		;;
	4 )
		build_img="recovery"
		build_images
		break
		;;
	5 )
		build_img="system"
		build_images
		break
		;;
	6 )
		build_img="all"
		build_images
		break
		;;
	7 )
		repo forall -c git reset --hard
		othermsg="Sources have been returned to its original state."
		clear
		;;
	8 )
		sudo add-apt-repository ppa:openjdk-r/ppa
		sudo apt-get update
		sudo apt-get install bison build-essential curl ccache flex lib32ncurses5-dev lib32z1-dev libesd0-dev libncurses5-dev libsdl1.2-dev libxml2 libxml2-utils lzop pngcrush schedtool squashfs-tools xsltproc zip zlib1g-dev git-core make phablet-tools gperf openjdk-8-jdk
		othermsg="Soft installed"
		clear
		;;
	9 )
		set_device
		device_text="Device: $configb"
		othermsg="The device is changed to $configb."
		clear
		;;
	10 )
		break
		;;
	* )
		echo "Invalid! Try again!"
		clear
		;;
esac
done
}

mainmenu
