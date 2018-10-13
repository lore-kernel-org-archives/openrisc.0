From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 13 Oct 2018 11:22:49 +0200
Subject: [OpenRISC] [PATCH v2 1/2] treewide: remove unused address
 argument from pte_alloc functions
In-Reply-To: <20181012194210.GA27630@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <03b524f3-5f3a-baa0-2254-9c588103d2d6@users.sourceforge.net>
 <20181012194210.GA27630@joelaf.mtv.corp.google.com>
Message-ID: <e1be1dda-90ab-052d-496b-3de01ffc80d1@users.sourceforge.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

>>> The changes were obtained by applying the following Coccinelle script.

How do you think about to adjust the order of provided information
in the commit description?
1. Update goals
2. Transformation implementation at the end


>> "^(?:pte_alloc(?:_one(?:_kernel)?)?|__pte_alloc(?:_kernel)?)$";
> 
> Sure it looks more clever, but why?

1. Usage of non-capturing parentheses
2. Clearer specification which parts can be treated as optional
   in the search pattern.


> Ugh that's harder to read and confusing.

* Do you care for coding style and execution speed of regular expressions?

* If you would prefer to list function names without placeholders,
  you can eventually specify them also within SmPL disjunctions directly.

* It can look simpler to use an identifier list as a constraint variant.
  http://coccinelle.lip6.fr/docs/main_grammar002.html


> Again this is confusing.

The view points can be different for such SmPL code.

 T3 fn(T1 E1
(
-           , T2 E2
|           , T2 E2
-           , T4 E4
)     );


> It makes one think that maybe the second argument can also be removed

You expressed this as the first transformation possibility, didn't you?

You would like to delete an argument from the end of a function
or macro parameter (or expression) list.
I suggest then again to avoid the SmPL specification of source code additions
(plus lines in the file difference format).


> and requires careful observation that the ");" follows.

Yes, of course.

Would you care more in the distinction which code parts should be kept unchanged?


> Right, I don't need it in this case.

Thanks for your understanding that the metavariable “position p”
can be deleted in the SmPL rule “pte_alloc_macro”.


> But the script works either way.

I imagine that you can become interested in a bit nicer run time characteristics.


> I like to take more of a problem solving approach that makes sense,

This is usual.


> than aiming for perfection,

If you will work more with scripts for the semantic patch language,
you might become used to additional coding variants.


> after all this is a useful script that we do not need to check
> in once we finish with it.

I am curious if there will evolve a need to add similar transformation approaches
to a known script collection.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/coccinelle?id=79fc170b1f5c36f486d886bfbd59eb4e62321128

Would you eventually like to run such scripts once more?

Regards,
Markus
