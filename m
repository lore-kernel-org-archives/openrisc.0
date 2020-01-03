From: Julia Lawall <julia.lawall@inria.fr>
Date: Fri, 3 Jan 2020 13:47:49 +0100 (CET)
Subject: [OpenRISC] [PATCH 0/4] use mmgrab
In-Reply-To: <20200103123059.GI3911@kadam>
References: <1577634178-22530-1-git-send-email-Julia.Lawall@inria.fr>
 <20200103123059.GI3911@kadam>
Message-ID: <alpine.DEB.2.21.2001031344480.2982@hadrien>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org



On Fri, 3 Jan 2020, Dan Carpenter wrote:

> On Sun, Dec 29, 2019 at 04:42:54PM +0100, Julia Lawall wrote:
> > Mmgrab was introduced in commit f1f1007644ff ("mm: add new mmgrab()
> > helper") and most of the kernel was updated to use it. Update a few
> > remaining files.
>
> I wonder if there is an automatic way to generate these kind of
> Coccinelle scripts which use inlines instead of open coding.  Like maybe
> make a list of one line functions, and then auto generate a recipe.  Or
> the mmgrab() function could have multiple lines if the first few were
> just sanity checks for NULL or something...

I tried this at one point (10 years ago!):

https://pages.lip6.fr/Julia.Lawall/acp4is09-lawall.pdf

Perhaps it is worth reviving.

julia
