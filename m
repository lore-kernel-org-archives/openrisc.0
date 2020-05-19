From: Stafford Horne <shorne@gmail.com>
Date: Wed, 20 May 2020 05:42:57 +0900
Subject: [OpenRISC] [PATCH 0/8] OpenRISC BFD fixups for Glibc
In-Reply-To: <2c2a4907-bb08-a112-e716-bf6f2cef3642@redhat.com>
References: <20200514210018.2749462-1-shorne@gmail.com>
 <2c2a4907-bb08-a112-e716-bf6f2cef3642@redhat.com>
Message-ID: <20200519204257.GC2553@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, May 19, 2020 at 02:30:06PM +0100, Nick Clifton wrote:
> Hi Stafford,
> 
> > Stafford Horne (8):
> >   or1k: Fix static linking when with .rela.got relocations
> >   or1k: Fix dynamic TLS symbol flag
> >   or1k: Add TLS mask to handle multiple model access
> >   or1k: Fix issue with multiple PCREL relocations
> >   or1k: TLS offset to use tcb size and section alignment
> >   or1k: refactor: Rename p to sec_relocs
> >   or1k: refactor: Rename s to sgot and splt
> >   or1k: Add dynamic flag to tpoff
> 
> Patch series approved and applied.  (Sorry for the delay...)

Thank you,

That was not much delay at all.   However, I was about to just apply the set of
patches myself.  Would that have been a problem?

-Stafford
