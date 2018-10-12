From: Joel Fernandes <joel@joelfernandes.org>
Date: Fri, 12 Oct 2018 12:42:10 -0700
Subject: [OpenRISC] [PATCH v2 1/2] treewide: remove unused address
 argument from pte_alloc functions
In-Reply-To: <03b524f3-5f3a-baa0-2254-9c588103d2d6@users.sourceforge.net>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <03b524f3-5f3a-baa0-2254-9c588103d2d6@users.sourceforge.net>
Message-ID: <20181012194210.GA27630@joelaf.mtv.corp.google.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On Fri, Oct 12, 2018 at 08:51:45PM +0200, SF Markus Elfring wrote:
> > The changes were obtained by applying the following Coccinelle script.
> 
> A bit of clarification happened for its implementation details.
> https://systeme.lip6.fr/pipermail/cocci/2018-October/005374.html
> 
> I have taken also another look at the following SmPL code.
> 
> 
> > identifier fn =~
> > "^(__pte_alloc|pte_alloc_one|pte_alloc|__pte_alloc_kernel|pte_alloc_one_kernel)$";
> 
> I suggest to adjust the regular expression for this constraint
> and in subsequent SmPL rules.
> "^(?:pte_alloc(?:_one(?:_kernel)?)?|__pte_alloc(?:_kernel)?)$";

Sure it looks more clever, but why? Ugh that's harder to read and confusing.

> > (
> > - T3 fn(T1 E1, T2 E2);
> > + T3 fn(T1 E1);
> > |
> > - T3 fn(T1 E1, T2 E2, T4 E4);
> > + T3 fn(T1 E1, T2 E2);
> > )
> 
> I propose to take an other SmPL disjunction into account here.
> 
>  T3 fn(T1 E1,
> (
> -      T2 E2
> |      T2 E2,
> -      T4 E4
> )      );

Again this is confusing. It makes one think that maybe the second argument
can also be removed and requires careful observation that the ");" follows.

> > (
> > - #define fn(a, b, c)@p e
> > + #define fn(a, b) e
> > |
> > - #define fn(a, b)@p e
> > + #define fn(a) e
> > )
> 
> How do you think about to omit the metavariable “position p” here?

Right, I don't need it in this case. But the script works either way.

I like to take more of a problem solving approach that makes sense, than
aiming for perfection, after all this is a useful script that we do not
need to check in once we finish with it.

 - Joel

