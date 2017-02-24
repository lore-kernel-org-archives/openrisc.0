From: Stafford Horne <shorne@gmail.com>
Date: Sat, 25 Feb 2017 04:33:48 +0900
Subject: [OpenRISC] [PATCH v4 18/24] scripts/checkstack.pl: Add openrisc
	support
In-Reply-To: <20170224144205.GB27998@distanz.ch>
References: <cover.1487910170.git.shorne@gmail.com>
 <fa5b73d3d8891452306376998a26886512934616.1487910170.git.shorne@gmail.com>
 <20170224144205.GB27998@distanz.ch>
Message-ID: <20170224193348.GP2449@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Fri, Feb 24, 2017 at 03:42:06PM +0100, Tobias Klauser wrote:
> On 2017-02-24 at 05:32:38 +0100, Stafford Horne <shorne@gmail.com> wrote:
> > Openrisc stack pointer is managed by decrementing r1. Add regexes to
> > recognize this.
> > 
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >  scripts/checkstack.pl | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
> > index dd83978..eea5b78 100755
> > --- a/scripts/checkstack.pl
> > +++ b/scripts/checkstack.pl
> > @@ -106,6 +106,9 @@ my (@stack, $re, $dre, $x, $xs, $funcre);
> >  	} elsif ($arch eq 'sparc' || $arch eq 'sparc64') {
> >  		# f0019d10:       9d e3 bf 90     save  %sp, -112, %sp
> >  		$re = qr/.*save.*%sp, -(([0-9]{2}|[3-9])[0-9]{2}), %sp/o;
> > +	} elsif ($arch eq 'openrisc') {
> > +		# c000043c:       9c 21 fe f0     l.addi r1,r1,-272
> > +		$re = qr/.*l\.addi.*r1,r1,-(([0-9]{2}|[3-9])[0-9]{2})/o;
> 
> The if/elsif clauses are currently ordered alphabetically (except for
> blackfin :-/), so this should rather be inserted above after nios2.

Right, I didnt notice the order.   Also, nios is new, this might cause a
bit of a conflict during merge. (just a note)

Thanks for the comment.

-Stafford
