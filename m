From: Stafford Horne <shorne@gmail.com>
Date: Mon, 20 Mar 2017 07:32:10 +0900
Subject: [OpenRISC] Linux kernel upstreaming status
Message-ID: <20170319223210.GR2418@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi All,

This weekend Linus merged a few minor compiler warning fixes I was working
on for OpenRISC. This should help spot more serious issues going forward.

That should be it for version 4.11, which should be released in a few
weeks, and saw the following features merged from OpenRISC backlogs.

 * Optimized memset and memcpy routines from Olof and Me (~20% boot time
   reduction)
 * Support for CPU idling from Sebastian Macke (improved power usage,
   unmeasured)
 * Also, various native atomic primatives support in prep for SMP

## Moving On

Going forward to 4.12 and beyond we have 3 types of patches pending:

 * SMP support - SMP support from Stefan
 * Drivers - char-scet, usb-ohs900, gpio-jbtrivial, ps2-oc, spi-oc-simple,
             dma-wbstreamer
 * Configs (device tree and kernel configs for board support)

### SMP

For SMP there is a bit of work to get these patches ready for upstream.

 * Documentation of smp (IPI) in the openrisc spec
 * Consider fixing the timer hacks noted in code by Stefan
 * Convert spinlocks/rwlocks to qspinlocks and rwlocks suggested by Peter Z
 * Getting Stefan's example SMP boards into FuseSoc

### Drivers

If there are any drivers you would like to see pushed upstream let me know.
Or even better I can help you get them upstream.  At the moment, I can only
test the GPIO and SPI drivers.  I will need to buy a new board or wire
things to my board get the others working.  Some points:

 * I think USB is important for many users, if someone want to volunteer to
   working upstreaming that and has hardware it will be great.  If not I
   will get to it later.
 * What is the scet driver?

### Configs

There has been some discussion on IRC before about where the dts configs
should live.  Should they be in the kernel source or in FuseSOC?

I think we should have some basic configs in the kernel for the major
boards and configurations (i.e. de0 nano, sockit and atlys boards).  But
definitely not for every board config out there.  Having them in the kernel
enables them to stay up-to-date and allows other users to know what we
support.

## Branches

I have split all the remaining changes into branches on my github repo, you
can find them below, they are all based on v4.11-rc2:

  https://github.com/stffrdhrn/linux

  openrisc-4.12-smp
  openrisc-4.12-config
  (drivers)
    openrisc-4.12-char-scet
    openrisc-4.12-dma-wbstreamer
    openrisc-4.12-gpio-jbtrivial
    openrisc-4.12-ps2-oc
    openrisc-4.12-spi-oc-simple
    openrisc-4.12-usb-ohs900

-Stafford
