#!/bin/bash
PBHOME=`pwd`
: ${ARCH:="$(dpkg --print-architecture)"}

source $PBHOME/targets

for target in $TARGETS
do
	NAME="$target"

	if [ -n "${ARCH}" ]; then
		NAME="$NAME-$ARCH"
	fi

	if [ ! -f $PBHOME/pbuilderrc-$NAME ]; then
		echo "need to create file pbuilderrc-$NAME"
		echo "DIST=\"$target\"" > $PBHOME/pbuilderrc-$NAME
		echo "" >> $PBHOME/pbuilderrc-$NAME
		echo "source $PBHOME/pbuilderrc_palaso" >> $PBHOME/pbuilderrc-$NAME
	fi
#    if [ ! -f $PBHOME/pbuilderrc-$target-lingnet ]; then
#        echo "need to create file pbuilderrc-$NAME-lingnet"
#        echo "DIST=\"$target\"" > $PBHOME/pbuilderrc-$NAME-lingnet
#        echo "VARIANT=\"new\"" >> $PBHOME/pbuilderrc-$NAME-lingnet
#        echo "" >> $PBHOME/pbuilderrc-$target-new
#        echo "source $PBHOME/pbuilderrc_palaso" >> $PBHOME/pbuilderrc-$NAME-lingnet
#    fi
	if [ ! -f $PBHOME/pbuilderrc-$target-new ]; then
		echo "need to create file pbuilderrc-$NAME-new"
		echo "DIST=\"$target\"" > $PBHOME/pbuilderrc-$NAME-new
		echo "VARIANT=\"new\"" >> $PBHOME/pbuilderrc-$NAME-new
		echo "" >> $PBHOME/pbuilderrc-$NAME-new
		echo "source $PBHOME/pbuilderrc_palaso" >> $PBHOME/pbuilderrc-$NAME-new
	fi

	if [ ! -f $PBHOME/base-$NAME.tgz ]; then
		echo "need to create pbuilder base $NAME"
		sudo pbuilder --create --configfile $PBHOME/pbuilderrc-$NAME
	else
		echo "need to update $NAME"
		sudo pbuilder --update --override-config --configfile $PBHOME/pbuilderrc-$NAME
	fi
 #   if [ ! -f $PBHOME/base-$NAME-lingnet.tgz ]; then
 #       echo "need to create pbuilder base $NAME-lingnet"
 #   else
 #       echo "need to update $NAME-lingnet"
 #       pbuilder --update --configfile $PBHOME/pbuilderrc-$NAME-lingnet
 #   fi
	if [ ! -f $PBHOME/base-$NAME-new.tgz ]; then
		echo "need to create pbuilder base $NAME-new"
		cp $PBHOME/base-$NAME.tgz $PBHOME/base-$NAME-new.tgz
		sudo pbuilder --update --override-config --configfile $PBHOME/pbuilderrc-$NAME-new
	else
		echo "need to update $NAME-new"
		sudo pbuilder --update --override-config --configfile $PBHOME/pbuilderrc-$NAME-new
	fi
done
