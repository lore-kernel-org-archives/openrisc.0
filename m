From: Ingo Molnar <mingo@kernel.org>
Date: Mon, 2 Apr 2018 07:59:33 +0200
Subject: [OpenRISC] [PATCH] Extract initrd free logic from arch-specific
	code.
In-Reply-To: <87bmf3rmq6.fsf@xps13.shealevy.com>
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
 <20180330111517.rrx6gs2skkgk336j@gmail.com>
 <87bmf3rmq6.fsf@xps13.shealevy.com>
Message-ID: <20180402055933.zbpyorktot2owzzu@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org


* Shea Levy <shea@shealevy.com> wrote:

> > Please also put it into Documentation/features/.
> 
> I switched this patch series (the latest revision v6 was just posted) to
> using weak symbols instead of Kconfig. Does it still warrant documentation?

Probably not.

Thanks,

	Ingo
