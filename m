From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 28 Feb 2018 09:37:09 +0100
Subject: [OpenRISC] Removing architectures without upstream gcc support
In-Reply-To: <20180228020631.GB3780@codeaurora.org>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222191758.GB5180@codeaurora.org>
 <CAK8P3a3r=3wDtqV5feLUT-hOkE+9yWOLjLVm+nejqdaN7MtMFw@mail.gmail.com>
 <20180228020631.GB3780@codeaurora.org>
Message-ID: <CAK8P3a13VDiH8+NG00p5oM2j5KMNU3JnCUurFn6EdJgztZsKHg@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Feb 28, 2018 at 3:06 AM, Richard Kuo <rkuo@codeaurora.org> wrote:
> On Thu, Feb 22, 2018 at 11:43:10PM +0100, Arnd Bergmann wrote:
>> - How do I build an llvm based toolchain for Hexagon? Do I need patches
>>   on top of the llvm-6 release branch? Where can I find the corresponding
>>   binutils-2.30 sources?
>
> Just to follow up on this, the closest thing right now to compile the kernel
> for Hexagon is the toolchain included with the Hexagon SDK.  However, the
> linker will fail because of something in the kernel build process that
> I think produces empty sections, which that linker can't handle.  A newer
> linker can handle it, but that's not scheduled to be released until much later
> this year.
>
> That's actually the closest option currently.  I tried the upstream source
> but it seems to lack some specific patches to support kernel compilation,
> so I will need to chase those down.

Thanks for trying it out. Can you point me to the sources? I tried downloading
a Hexagon SDK when I first looked at it, but only got a huge chunk of binary
java files and gave up before finding the llvm patches.

       Arnd
