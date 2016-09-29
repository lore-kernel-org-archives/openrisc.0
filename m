From: Olof Kindgren <olof.kindgren@gmail.com>
Date: Thu, 29 Sep 2016 16:21:02 +0200
Subject: [OpenRISC] Branch Predictor on OpenRISC de0-nano
In-Reply-To: <CAFoY_wyD=3cn9jDwwL1YRqE7DsptwsGYAUeqZfV=6f3FO9=a0w@mail.gmail.com>
References: <CAFoY_wyD=3cn9jDwwL1YRqE7DsptwsGYAUeqZfV=6f3FO9=a0w@mail.gmail.com>
Message-ID: <CAKaYPCNWFUfTKKvDtMy1AgLr66M6tTccybdFU=sQ0SRGs_iJ9Q@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Sep 29, 2016 at 11:50 AM, Manaar Alam <alam.manaar@gmail.com> wrote:
> Hello,
>
> I am currently working on openRISC Linux on de0-nano development board. What
> I want to know is, if there any branch predictor in it like dynamic 2-bit
> branch prediction or not. It will be very helpful for my research.
>
> Thank you.
>
> --
> Manaar Alam,
> Junior Research Fellow,
> Secured Embedded Architecture Laboratory (SEAL),
> Department of Computer Science and Engineering,
> Indian Institute of Technology, Kharagpur,
> West Bengal, India.
>
> _______________________________________________
> OpenRISC mailing list
> OpenRISC at lists.librecores.org
> https://lists.librecores.org/listinfo/openrisc
>

Hi Manaar,

mor1kx (the implementation of the OpenRISC CPU we mostly use) has
quite recently got a branch predictor. It's in the git master branch
of mor1kx, but there hasn't yet been a relase with the new predictor.

The version of mor1kx that is in the FuseSoC system for de0_nano uses
the latest released version, so you won't find the branc predictor
there by default. You can however override the version of mor1kx that
is used to build the SoC for de0_nano.

Here are some quick instructions for how to override the version of
mor1kx being used

The best way is to override the mor1kx core. The following steps
should work for this

1. Create a new directory (we will refer to this directory as $corelib
from now on)

2. Clone the mor1kx git repository here. (cd $corelib; git clone
https://github.com/openrisc/mor1kx)

3. Copy mor1kx.core to $corelib/mor1kx (mor1kx.core should be in
$HOME/.local/share/orpsoc-cores/cores/mor1kx if you used fusesoc init
to get orpsoc-cores)

4. Edit mor1kx.core and remove the section [provider] and everything
below (This will stop FuseSoC from downloading the core and use files
from the directory containing the .core file instead.

5. Edit fusesoc.conf in your workspace directory (or in
$HOME/.config/fusesoc/ if you want it for all workspaces that don't
have its own fusesoc.conf) and add the path to $corelib at the end of
the line that begin with "cores_root = ". (This will tell FuseSoC to
look for additional cores in $corelib and override cores that it has
already found. You can also use fusesoc --cores-root=/path/to/$corelib
... if you don't want to edit config files

6. Verify that the new core is found by running fusesoc core-info
mor1kx. You should see that "Core root: " is set to $corelib/mor1kx

Now you can hack the code in $corelib/mor1kx as much as you want and
just run fusesoc sim --force mor1kx-generic --lots-of-other-options

