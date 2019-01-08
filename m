From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 9 Jan 2019 00:32:28 +0900
Subject: [OpenRISC] [PATCH] arch: unexport asm/shmparam.h for all
	architectures
In-Reply-To: <20190108111032.GP3235@lianli.shorne-pla.net>
References: <1546904307-11124-1-git-send-email-yamada.masahiro@socionext.com>
 <20190108111032.GP3235@lianli.shorne-pla.net>
Message-ID: <CAK7LNAS+grgqHM-ht0CCTmZHp+JRvr=Q+sJOo0URqRgTAYRs0w@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

Hi Stafford,



On Tue, Jan 8, 2019 at 8:12 PM Stafford Horne <shorne@gmail.com> wrote:
>
> What is this patch based on?  I tried to apply it to 5.0-rc1 and am having an
> issue with applying the arch/openrisc/include/uapi/asm/Kbuild part.


Based on Linus' latest tree.
(commit 3bd6e94be)

v5.0-rc1 is NOT the latest.



> It seems shmparam.h is not there. It was removed with the others in your
> ("d6e4b3e326d8") arch: remove redundant UAPI generic-y defines, commit a few
> days ago.
>
> Note, I can't compile 5.0-rc1 without the first part of this patch.  So please
> get it merged asap :)


I notice the breakage of several arches after v5.0-rc1 release,
so I asked Linus to pick up 3d6e94be.

I had already noticed
having shmparam.h in uapi is werid,
but I decided to fix the build errors first.


-- 
Best Regards
Masahiro Yamada
