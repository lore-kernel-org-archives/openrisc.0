From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 23 Feb 2018 06:32:57 -0800
Subject: [OpenRISC] Removing architectures without upstream gcc support
In-Reply-To: <CAK8P3a3Y2b-DivYz1ZqhFGUqQaiF=5SDB6RFLtCknwY2--09OQ@mail.gmail.com>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222234833.GA3047@roeck-us.net>
 <CAK8P3a3Y2b-DivYz1ZqhFGUqQaiF=5SDB6RFLtCknwY2--09OQ@mail.gmail.com>
Message-ID: <c86ec381-963c-7460-9e02-4ebeeac1c8fb@roeck-us.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 02/23/2018 02:32 AM, Arnd Bergmann wrote:
> On Fri, Feb 23, 2018 at 12:48 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On Thu, Feb 22, 2018 at 04:45:06PM +0100, Arnd Bergmann wrote:
>>> While building the cross-toolchains, I noticed that overall, we can build almost
>>> all linux target architectures with upstream binutils and gcc these days,
>>> however there are still some exceptions, and I'd like to find out if anyone
>>> has objections to removing the ones that do not have upstream support.
>>> This are the four architectures I found:
>>>
>>> * score (s+core, sunplus core) was a proprietary RISC architecture
>>>    made by sunplus. It is unclear if they still ship any products based on
>>>    this architecture, all they list is either ARM Cortex-A9 or an unspecified
>>>    RISC core that could be any of arm, mips, nds32, arc, xtensa or
>>>    something completely different. The two maintainers have both left the
>>>    company many years ago and have not contributed any patches in
>>>    at least five years. There was an upstream gcc port, which was marked
>>>    'obsolete' in 2013 and got removed in gcc-5.0.
>>>    I conclude that this is dead in Linux and can be removed
>>>
>>> * unicore32 was a research project at Peking University with a SoC
>>>    based on the Intel PXA design. No gcc source code has ever been
>>>    published, the only toolchain available is a set of binaries that include
>>>    a gcc-4.4 compiler. The project page at
>>>    http://mprc.pku.edu.cn/~guanxuetao/linux/ has a TODO list that has
>>>    not been modified since 2011. The maintainer still Acks patches
>>>    and has last sent a pull request in 2014 and last sent a patch of
>>>    his own in 2012 when the project appears to have stalled.
>>>    I would suggest removing this one.
>>>
>>
>> The above two would be primary removal targets for me; they are all
>> but impossible to support given the toolchain limitations. Meta
>> would have been another one, but James is already taking care of it.
> 
> Ok. Have you had any success building arch/hexagon with clang?
> 

I have not tried. It is a pain having to use different toolchains for different
kernel versions, and I only do it if I absolutely have to. I use "hexagon-linux-gcc
(Sourcery CodeBench Lite 2012.03-66) 4.6.1".

Guenter
