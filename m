From: Borislav Petkov <bp@alien8.de>
Date: Fri, 6 Jan 2017 13:14:46 +0100
Subject: [OpenRISC] [PATCH v2 4/7] x86: put msr-index.h in uapi
In-Reply-To: <1483695839-18660-5-git-send-email-nicolas.dichtel@6wind.com>
References: <bf83da6b-01ef-bf44-b3e1-ca6fc5636818@6wind.com>
 <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com>
 <1483695839-18660-5-git-send-email-nicolas.dichtel@6wind.com>
Message-ID: <20170106121446.aizmoxons5gpecnc@pd.tnic>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Jan 06, 2017 at 10:43:56AM +0100, Nicolas Dichtel wrote:
> This header file is exported, thus move it to uapi.

It should rather not be exported - please remove it from
arch/x86/include/uapi/asm/Kbuild instead.

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
