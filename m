From: Julia Lawall <julia.lawall@lip6.fr>
Date: Fri, 12 Oct 2018 18:38:57 +0200 (CEST)
Subject: [OpenRISC] [PATCH v2 1/2] treewide: remove unused address
 argument from pte_alloc functions
In-Reply-To: <20181012163433.GA223066@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <594fc952-5e87-3162-b2f9-963479d16eb3@kot-begemot.co.uk>
 <20181012163433.GA223066@joelaf.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1810121838180.4366@hadrien>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

> I wrote something like this as below but it failed to compile, Julia any
> suggestions on how to express this?
>
> @pte_alloc_func_proto depends on patch exists@
> type T1, T2, T3, T4;
> identifier fn =~
> "^(__pte_alloc|pte_alloc_one|pte_alloc|__pte_alloc_kernel|pte_alloc_one_kernel)$";
> @@
>
> (
> - T3 fn(T1, T2);
> + T3 fn(T1);
> |
> - T3 fn(T1, T2, T4);
> + T3 fn(T1, T2);
> )

What goes wrong?  It seems fine to me.

julia
