#!/bin/bash
PBHOME=`pwd`

source $PBHOME/targets

for target in $TARGETS
do
	for arch in $BUILD_ARCH
	do
		NAME="$target-$arch"

		if [ ! -f $PBHOME/pbuilderrc-$NAME ]; then
			echo "need to create file pbuilderrc-$NAME"
			echo "DIST=\"$target\"" > $PBHOME/pbuilderrc-$NAME
			echo "ARCH=\"$arch\"" >> $PBHOME/pbuilderrc-$NAME
			echo "" >> $PBHOME/pbuilderrc-$NAME
			echo "source $PBHOME/pbuilderrc_palaso" >> $PBHOME/pbuilderrc-$NAME
		fi
		if [ ! -f $PBHOME/pbuilderrc-$NAME-lingnet ]; then
			echo "need to create file pbuilderrc-$NAME-lingnet"
			echo "DIST=\"$target\"" > $PBHOME/pbuilderrc-$NAME-lingnet
			echo "ARCH=\"$arch\"" >> $PBHOME/pbuilderrc-$NAME-lingnet
			echo "VARIANT=\"lingnet\"" >> $PBHOME/pbuilderrc-$NAME-lingnet
			echo "" >> $PBHOME/pbuilderrc-$NAME-lingnet
			echo "source $PBHOME/pbuilderrc_palaso" >> $PBHOME/pbuilderrc-$NAME-lingnet
		fi
		if [ ! -f $PBHOME/pbuilderrc-$NAME-new ]; then
			echo "need to create file pbuilderrc-$NAME-new"
			echo "DIST=\"$target\"" > $PBHOME/pbuilderrc-$NAME-new
			echo "ARCH=\"$arch\"" >> $PBHOME/pbuilderrc-$NAME-new
			echo "VARIANT=\"new\"" >> $PBHOME/pbuilderrc-$NAME-new
			echo "" >> $PBHOME/pbuilderrc-$NAME-new
			echo "source $PBHOME/pbuilderrc_palaso" >> $PBHOME/pbuilderrc-$NAME-new
		fi

		if [ ! -f $PBHOME/base-$NAME.tgz ]; then
			echo "need to create pbuilder base $NAME"
			sudo pbuilder --create --configfile $PBHOME/pbuilderrc-$NAME
		else
			echo "need to update $NAME"
			sudo pbuilder --update --configfile $PBHOME/pbuilderrc-$NAME
		fi
		if [ ! -f $PBHOME/base-$NAME-lingnet.tgz ]; then
			echo "need to create pbuilder base $NAME-lingnet"
			sudo pbuilder --create --configfile $PBHOME/pbuilderrc-$NAME-lingnet
		else
			echo "need to update $NAME-lingnet"
			sudo pbuilder --update --configfile $PBHOME/pbuilderrc-$NAME-lingnet
		fi
		if [ ! -f $PBHOME/base-$NAME-new.tgz ]; then
			echo "need to create pbuilder base $NAME-new"
			sudo pbuilder --create --configfile $PBHOME/pbuilderrc-$NAME-new
		else
			echo "need to update $NAME-new"
			sudo pbuilder --update --configfile $PBHOME/pbuilderrc-$NAME-new
		fi
	done
	if [ ! -d $PBHOME/results/$target ]; then
		echo "creating results dir $PBHOME/results/$target"
		mkdir -p $PBHOME/results/$target
	fi
done
