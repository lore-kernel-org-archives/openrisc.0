From: Borislav Petkov <bp@alien8.de>
Date: Fri, 13 Jan 2017 17:38:36 +0100
Subject: [OpenRISC] [PATCH v3 4/8] x86: stop exporting msr-index.h to
	userland
In-Reply-To: <dd826bc7-e1ef-be29-e0c3-692afb346036@6wind.com>
References: <1484304406-10820-5-git-send-email-nicolas.dichtel@6wind.com>
 <3131144.4Ej3KFWRbz@wuerfel>
 <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
 <25483.1484322229@warthog.procyon.org.uk>
 <dd826bc7-e1ef-be29-e0c3-692afb346036@6wind.com>
Message-ID: <20170113163836.jn3u6xyfcrbtynut@pd.tnic>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On Fri, Jan 13, 2017 at 05:08:34PM +0100, Nicolas Dichtel wrote:
> Le 13/01/2017 à 16:43, David Howells a écrit :
> >> -header-y += msr-index.h
> > 
> > I see it on my desktop as /usr/include/asm/msr-index.h and it's been there at
> > least four years - and as such it's part of the UAPI.  I don't think you can
> > remove it unless you can guarantee there are no userspace users.
> I keep it in the v2 of the series, but the maintainer, Borislav Petkov, asks me
> to un-export it.
> 
> I will follow the maintainer decision.

I'm not the maintainer. I simply think that exporting that file was
wrong because it if we change something in it, we will break userspace.
And that should not happen - if userspace needs MSRs, it should do its
own defines.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
