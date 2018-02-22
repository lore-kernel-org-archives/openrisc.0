From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 22 Feb 2018 23:43:10 +0100
Subject: [OpenRISC] Removing architectures without upstream gcc support
In-Reply-To: <20180222191758.GB5180@codeaurora.org>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222191758.GB5180@codeaurora.org>
Message-ID: <CAK8P3a3r=3wDtqV5feLUT-hOkE+9yWOLjLVm+nejqdaN7MtMFw@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Thu, Feb 22, 2018 at 8:17 PM, Richard Kuo <rkuo@codeaurora.org> wrote:
> On Thu, Feb 22, 2018 at 04:45:06PM +0100, Arnd Bergmann wrote:
>> * Hexagon is Qualcomm's DSP architecture. It is being actively used
>>   in all Snapdragon ARM SoCs, but the kernel code appears to be
>>   the result of a failed research project to make a standalone Hexagon
>>   SoC without an ARM core. There is some information about the
>>   project at https://wiki.codeaurora.org/xwiki/bin/Hexagon/ and
>>   https://unix.stackexchange.com/questions/246243/what-is-was-the-qualcomm-hexagon-comet-board
>>   There is a port to gcc-4.5 on the project page, which is evidently
>>   abandoned, but there is an active upstream LLVM port that is
>>   apparently used to build non-Linux programs.
>>   I would consider this one a candidate for removal as well, given that
>>   there were never any machines outside of Qualcomm that used this,
>>   and they are no longer interested themselves.
>
> It's difficult for me to speak to the decisions as I can understand
> your point of view, but maybe I can speak to some of the status.
>
> We still use the port internally for kicking the tools around and other
> research projects.  As you noticed we're not doing gcc anymore; we're
> using LLVM for both kernel and userspace.  Yes there have been some
> caveats but it does work within confines.
>
> Time is unfortunately just limited for me to upstream some of my kernel
> fixes and cleanups, and there are some things that just haven't shown
> up externally yet.
>
> However, as James Hogan mentioned, having it in the tree really has been
> useful because it gets included in the various upstream changes and
> fixes, which we appreciate.
>
> So hopefully this will help inform the decision a little better.
>
> If you have any other questions please let me know.

Thanks for the clarification! Since you are the maintainer and you
still consider the port useful, I don't see how anyone else would be
in a position to demand it to be removed, so we should keep it
around until you want it gone.

I still have a few questions:

- Any idea how we would find out of the status ever changes? E.g. if
  you decide at some point that you don't find the latest Linux useful
  any more for your internal work, would you send a patch for removal?

- How do I build an llvm based toolchain for Hexagon? Do I need patches
  on top of the llvm-6 release branch? Where can I find the corresponding
  binutils-2.30 sources?

       Arnd
