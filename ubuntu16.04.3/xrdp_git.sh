#!/bin/bash
################################################################
# Script_Name : start.sh
# Description : Perform an automated custom installation of xrdp
# on debian 9.1 xrdp-0.9.3.1 xorgxrdp-0.2.3 pulseaudio
# Date : August 2017
# written by : renbuar
# Web Site :http://renbuar.blogspot.ru/2017/08/pulse.html
# Version : 1.3
# Disclaimer : Script provided AS IS. Use it at your own risk....
##################################################################
##################################################################
#Step 1 - Install prereqs for compilation
##################################################################
echo "Installing prereqs for compiling xrdp..."
echo "----------------------------------------"
sudo apt install -y git autoconf libtool pkg-config gcc g++ make libssl-dev libpam0g-dev libjpeg-dev libx11-dev libxfixes-dev libxrandr-dev flex bison libxml2-dev intltool xsltproc xutils-dev python-libxml2 g++ xutils libfuse-dev libmp3lame-dev nasm libpixman-1-dev xserver-xorg-dev git
#sudo apt-get -y install libx11-dev libxfixes-dev libssl-dev libpam0g-dev libtool libjpeg-dev flex bison gettext autoconf libxml-parser-perl libfuse-dev xsltproc libxrandr-dev python-libxml2 nasm xserver-xorg-dev fuse git pkg-config
# fontutil.h fix
##################################################################
sudo cat > /usr/include/X11/fonts/fontutil.h  <<EOF
    #ifndef _FONTUTIL_H_
    #define _FONTUTIL_H_

    #include <X11/fonts/FSproto.h>

    extern int FontCouldBeTerminal(FontInfoPtr);
    extern int CheckFSFormat(fsBitmapFormat, fsBitmapFormatMask, int *, int *,
    			 int *, int *, int *);
    extern void FontComputeInfoAccelerators(FontInfoPtr);

    extern void GetGlyphs ( FontPtr font, unsigned long count,
    			unsigned char *chars, FontEncoding fontEncoding,
    			unsigned long *glyphcount, CharInfoPtr *glyphs );
    extern void QueryGlyphExtents ( FontPtr pFont, CharInfoPtr *charinfo,
    				unsigned long count, ExtentInfoRec *info );
    extern Bool QueryTextExtents ( FontPtr pFont, unsigned long count,
    			       unsigned char *chars, ExtentInfoRec *info );
    extern Bool ParseGlyphCachingMode ( char *str );
    extern void InitGlyphCaching ( void );
    extern void SetGlyphCachingMode ( int newmode );
    extern int add_range ( fsRange *newrange, int *nranges, fsRange **range,
    		       Bool charset_subset );

    #endif /* _FONTUTIL_H_ */
    EOF
##################################################################
#Step 2 - Obtain xrdp packages
##################################################################
## --Go to your Download folder
echo "Moving to the /tmp folders..."
echo "-----------------------------------"
cd /tmp
## -- Download the xrdp latest files
echo "Ready to start the download of xrdp package"
echo "-------------------------------------------"
git clone git://github.com/neutrinolabs/xrdp
cd /tmp/xrdp
./bootstrap
./configure --enable-fuse --enable-mp3lame --enable-pixman --enable-sound --disable-ipv6
make
sudo make install
sudo ln -s /usr/local/sbin/xrdp{,-sesman} /usr/sbin
##################################################################
#Step 3 - Download and compiling xorgxrdp packages
##################################################################
cd /tmp
git clone git://github.com/neutrinolabs/xorgxrdp
cd /tmp/xorgxrdp
./bootstrap
./configure
make
sudo make install
##################################################################
#Step 4 - Configure pulseaudio
##################################################################
cd /tmp
mkdir -p pulseaudio
sudo apt-get install -y dpkg-dev
sudo apt-get source pulseaudio
sudo apt-get build-dep pulseaudio
cd /tmp/pulseaudio-10.0
sudo ./configure
cd /tmp/xrdp/sesman/chansrv/pulse
make
sudo cp module-xrdp*.so /usr/lib/pulse-10.0/modules
##################################################################
#Step 5 - Configure of xrdp_keyboard.ini for russian keyboard
##################################################################
sudo cat > xrdp_keyboard.ini <<EOF
[default_rdp_layouts]
rdp_layout_us=0x00000409
rdp_layout_de=0x00000407
rdp_layout_fr=0x0000040C
rdp_layout_it=0x00000410
rdp_layout_jp=0x00000411
rdp_layout_jp2=0xe0010411
rdp_layout_jp3=0xe0200411
rdp_layout_jp4=0xe0210411
rdp_layout_ru=0x00000419
rdp_layout_se=0x0000041D
rdp_layout_pt=0x00000816
rdp_layout_br=0x00000416
rdp_layout_pl=0x00000415
[rdp_keyboard_ru]
keyboard_type=4
keyboard_type=7
keyboard_subtype=1
model=pc105
options=grp:alt_shift_toggle
rdp_layouts=default_rdp_layouts
layouts_map=layouts_map_ru
[layouts_map_ru]
rdp_layout_us=us,ru
rdp_layout_ru=us,ru
EOF
sudo cp xrdp_keyboard.ini /etc/xrdp
##################################################################
#Step 6 - Configure Polkit to avoid popup in Xrdp Session
##################################################################
sudo cat > 02-allow-colord.conf <<EOF
polkit.addRule(function(action, subject) {
if ((action.id == “org.freedesktop.color-manager.create-device” ||
action.id == “org.freedesktop.color-manager.create-profile” ||
action.id == “org.freedesktop.color-manager.delete-device” ||
action.id == “org.freedesktop.color-manager.delete-profile” ||
action.id == “org.freedesktop.color-manager.modify-device” ||
action.id == “org.freedesktop.color-manager.modify-profile”) &&
subject.isInGroup(“{group}”)) {
return polkit.Result.YES;
}
});
EOF
sudo cp 02-allow-colord.conf /etc/polkit-1/localauthority.conf.d
##################################################################
#Step 7 - Restart Computer
##################################################################
## -- Issue systemctl command to reflect change and enable the service
sudo dpkg-reconfigure xserver-xorg-legacy
sudo xrdp-keygen xrdp auto 2048
sudo systemctl daemon-reload
sudo systemctl enable xrdp.service
sudo systemctl enable xrdp-sesman.service
echo "Restart the Computer"
echo "----------------------------"
#sudo shutdown -r now
