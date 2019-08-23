From: Stafford Horne <shorne@gmail.com>
Date: Fri, 23 Aug 2019 22:28:26 +0900
Subject: [OpenRISC] [PATCH] or1k: Fix incorrect value in PLT GOT entries,
 causing infinite loop
In-Reply-To: <9117019e-3b9c-447e-749d-1200d5b61a12@redhat.com>
References: <20190822112757.32751-1-shorne@gmail.com>
 <9117019e-3b9c-447e-749d-1200d5b61a12@redhat.com>
Message-ID: <20190823132826.GA24874@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Aug 23, 2019 at 10:50:17AM +0100, Nick Clifton wrote:
> Hi Stafford,
> 
> > bfd/ChangeLog:
> > 
> > 	* elf32-or1k.c (or1k_elf_finish_dynamic_symbol): Use correct value for
> > 	PLT GOT entries.
> 
> Approved - please apply.

Done now.

Thanks,

-Stafford
