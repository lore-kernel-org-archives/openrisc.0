From: Jiri Slaby <jslaby@suse.cz>
Date: Wed, 17 May 2017 10:01:29 +0200
Subject: [OpenRISC] [PATCH 1/1] futex: remove duplicated code
In-Reply-To: <20170515131644.GA3605@arm.com>
References: <20170515130742.18357-1-jslaby@suse.cz>
 <20170515131644.GA3605@arm.com>
Message-ID: <14580dfc-9721-38ab-a1e0-6b4aba13b406@suse.cz>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 05/15/2017, 03:16 PM, Will Deacon wrote:
> Whilst I think this is a good idea, the code in question actually results
> in undefined behaviour per the C spec and is reported by UBSAN.

Hi, yes, I know -- this patch was the 1st from the series of 3 which I
sent a long time ago to fix that up too. But I remember your patch, so I
sent only this one this time.

> See my
> patch fixing arm64 here (which I'd forgotten about):
> 
> https://www.spinics.net/lists/linux-arch/msg38564.html
> 
> But, as stated in the thread above, I think we should go a step further
> and remove FUTEX_OP_{OR,ANDN,XOR,OPARG_SHIFT} altogether. They don't
> appear to be used by userspace, and this whole thing is a total mess.
> 
> Any thoughts?

Ok, I am all for that. I think the only question is who is going to do
the work and submit it :)? Do I understand correctly to eliminate all
these functions and the path into the kernel? But won't this break API
-- are there really no users of this interface?

thanks,
-- 
js
suse labs
