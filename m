From: David Miller <davem@davemloft.net>
Date: Fri, 12 Oct 2018 11:02:20 -0700 (PDT)
Subject: [OpenRISC] [PATCH v2 2/2] mm: speed up mremap by 500x on large
	regions
In-Reply-To: <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
Message-ID: <20181012.110220.321284613911888246.davem@davemloft.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Fri, 12 Oct 2018 14:30:56 +0300

> I looked into the code more and noticed move_pte() helper called from
> move_ptes(). It changes PTE entry to suite new address.
> 
> It is only defined in non-trivial way on Sparc. I don't know much about
> Sparc and it's hard for me to say if the optimization will break anything
> there.
> 
> I think it worth to disable the optimization if __HAVE_ARCH_MOVE_PTE is
> defined. Or make architectures state explicitely that the optimization is
> safe.

What sparc is doing in move_pte() is flushing the data-cache
(synchronously) if the virtual address color of the mapping changes.

Hope this helps.
