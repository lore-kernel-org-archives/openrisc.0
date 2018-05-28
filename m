From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Mon, 28 May 2018 20:27:19 +0200
Subject: [OpenRISC] [PATCH] kbuild: add endianness flag to CHEKCFLAGS
In-Reply-To: <7ce087bc-dd52-bae8-96f2-fad91f5a345e@infradead.org>
References: <20180528170048.16595-1-luc.vanoostenryck@gmail.com>
 <7ce087bc-dd52-bae8-96f2-fad91f5a345e@infradead.org>
Message-ID: <20180528182718.7mdr66wp4xmg55lo@ltop.local>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Mon, May 28, 2018 at 10:31:58AM -0700, Randy Dunlap wrote:
> On 05/28/2018 10:00 AM, Luc Van Oostenryck wrote:
> > +# insure the checker run with the right endianness
> > +CHECKFLAGS += $(if $(CONFIG_CPU_BIG_ENDIAN),-mbig,-mlittle)
> 
> Does this need to be                           -mbig-endian,-mlittle-endian)

Of course it does. *sigh*
Thanks for noticing that. Correct patch is on the fly.

-- Luc 
