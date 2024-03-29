xroar supports multiple audio systems and has two user interfaces,
gtk2 (using gtkglext) and sdl2 (very bare-bones; no menus). By
default, both UIs are built, as is support for PulseAudio and plain
ALSA audio. For most users, these defaults are just fine. If you have
different needs, read on.

Optional Dependencies
=====================

jack - If you want to use JACK for audio output, install jack and set
  JACK=yes in the environment before building xroar. If JACK audio has
  x-runs, try 'setcap cap_ipc_lock,cap_sys_nice=ep /usr/games/xroar'.
  If you don't know what jack is, or why you might want to use it, then
  you don't want it.


Environment Variables
=====================

JACK - see above. Default: no.

GTKGLEXT - If you have gtkglext installed, but don't want to build
  xroar with it, export GTKGLEXT=no [1] [2]. Default: yes.

SDL2 - If you don't want to build xroar with SDL2, export SDL2=no [2].
  This will remove the "-ui sdl" option, which is probably
  of no consequence since the SDL user interface isn't very
  featureful. Default: yes.

OSS - use OSS for audio? Default is "no", export OSS="yes" to enable.
  Most users won't need this.

PULSE - use PulseAudio? Default is "yes", export PULSE="no" to disable.


Notes
=====

[1]: Yes, gtkglext is optional, despite being listed in REQUIRES in
     the .info file. I made it a hard dependency because the SDL user
     interface has no real GUI features, while the gtkglext UI acts
     like a proper GUI application. Users who just take the defaults
     will end up with the usable UI. If you're reading this, you're
     welcome to ignore the REQUIRES="gtkglext" and build with SDL2
     only, if you have a reason to want to.

[2]: At least one of SDL2 or gtkglext is required, so you can't build
     with SDL2=no GTKGLEXT=no. If you want to be super-pedantic, yes,
     it *is* possible to build xroar without either gtkglext or SDL2,
     but the result is that xroar won't display anything at all. This
     is useless and confusing, nobody wants it, and I'm not willing to
     support it.
