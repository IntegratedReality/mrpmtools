cd /usr/src
rm -rf linux
rm -rf firmware
git clone --depth 1 https://github.com/raspberrypi/linux.git -b rpi-4.4.y
git clone --depth 1 https://github.com/raspberrypi/firmware.git
cd linux
modprobe configs
zcat /proc/config.gz > .config
cp ../firmware/extra/Module7.symvers Module.symvers

make oldconfig
make -j 4 zImage modules dtbs
make modules_install
cp arch/arm/boot/dts/*.dtb /boot/
cp arch/arm/boot/dts/overlays/*.dtb /boot/overlays/
cp arch/arm/boot/dts/overlays/README /boot/overlays/
cp /boot/kernel7.img /boot/kernel7.img.old
scripts/mkklimg arch/arm/boot/zImage /boot/kernel7.img
reboot

