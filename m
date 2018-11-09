From: Adam Borowski <kilobyte@angband.pl>
Date: Fri, 9 Nov 2018 19:59:53 +0100
Subject: [OpenRISC] [PATCH 0/17] Kernel compression: add ZSTD,
	remove LZMA1 and BZIP2
Message-ID: <20181109185953.xwyelyqnygbskkxk@angband.pl>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Hi!
As new compressors get invented, they tend to find their way into the
kernel, yet we never prune superseded ones.  It's time to do so.

In particular, BZIP2 is drastically slower than other compressors we
have, even when they achieve smaller sizes.  It takes more memory, too.
And, BZIP2 is not used anywhere else in the kernel -- just for booting
the kernel itself and the initrd.  Thus, we can drop it from the tree
completely, making Linus happier by around 900 lines.

LZMA1 is redundant with XZ (LZMA2), and unlike the latter, it uses its own
copy of code that's not shared with anything else (some drivers use XZ).
Let's drop it as well.  Some bootloaders can use it thus let's keep the
Kconfig option, but I left no piece of code inside the kernel itself.

On the other hand, Nick Terrell has a couple of patches adding ZSTD support
(using code already in use in multiple pieces around the kernel).  ZSTD is
strong and fast, obsoleting all mid-range compressors.  As the removal of
BZIP2 and LZMA1 would be hopelessly entangled with this addition, I'm
resending Nick's patches here.  I've been booting using them since Oct'17
on amd64 (kernel+initrd), armhf and arm64 (initrd) without issues, other
folks tested various other architectures as well.

Thus, I'd recommend people to use:
* XZ for most machines
* ZSTD where speed is important
* maaaaybe LZ4 is some special cases
(grub and u-boot are ridiculously slow at reading, making fast but weak
decompressors a net loss.  On the other hand, XZ decompresses pretty fast
but is very slow at compress time, making ZSTD preferred for rapid devel
cycles.)

* we can't get rid of GZIP in foreseable future
* LZO is obsolete but is used elsewhere in the kernel

Total:
 69 files changed, 518 insertions(+), 1785 deletions(-)

Not sure whose tree this patchset should go through.  I'm also not sure
how finely split into commits you want the arch bits be; I included
defconfig bits all together, yet separated code changes per-arch.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢠⠒⠀⣿⡁ A dumb species has no way to open a tuna can.
⢿⡄⠘⠷⠚⠋⠀ A smart species invents a can opener.
⠈⠳⣄⠀⠀⠀⠀ A master species delegates.
