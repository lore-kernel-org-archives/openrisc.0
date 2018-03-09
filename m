From: Xuetao Guan <gxt@mprc.pku.edu.cn>
Date: Fri, 9 Mar 2018 22:00:42 +0800 (CST)
Subject: [OpenRISC] Removing architectures without upstream gcc support
In-Reply-To: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
Message-ID: <50191.222.29.22.133.1520604042.squirrel@mprc.pku.edu.cn>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org


> * unicore32 was a research project at Peking University with a SoC
>   based on the Intel PXA design. No gcc source code has ever been
>   published, the only toolchain available is a set of binaries that
> include
>   a gcc-4.4 compiler. The project page at
>   http://mprc.pku.edu.cn/~guanxuetao/linux/ has a TODO list that has
>   not been modified since 2011. The maintainer still Acks patches
>   and has last sent a pull request in 2014 and last sent a patch of
>   his own in 2012 when the project appears to have stalled.
>   I would suggest removing this one.
>
Hi, Arnd.
I am really sorry to reply so late, since I seldom use this email account
in recent years. I will add my new email account to related bits.

Let me clarify the status of UniCore. It's a real cpu-core product,
integrated into PKUnity SoC, and sold in a large amount of embedded boxes,
such as cloud terminals and set top boxes. Surely, we still use the port
internally and keep doing developments in other projects. So, I really
appreciate having unicore32 port in the tree.

As to gnu toolchain of UniCore, I have already discussed it in my group,
and I'll do my best to propel it forward.

Thanks,
Guan Xuetao
