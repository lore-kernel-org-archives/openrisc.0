From: Stafford Horne <shorne@gmail.com>
Date: Sun, 24 Dec 2017 23:47:34 +0900
Subject: [OpenRISC] [PATCH v3 1/4] reggroups: Add test and docs for
 `info reg $reggroup` feature
In-Reply-To: <00b5d74739aced5252fd0a035397b11f@polymtl.ca>
References: <20171219142257.13402-1-shorne@gmail.com>
 <20171219142257.13402-2-shorne@gmail.com>
 <00b5d74739aced5252fd0a035397b11f@polymtl.ca>
Message-ID: <20171224144734.GF32243@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Wed, Dec 20, 2017 at 09:58:45PM -0500, Simon Marchi wrote:
> On 2017-12-19 09:22, Stafford Horne wrote:
> > Until now this feature has existed but was not documented.  Adding docs
> > and tests.
> > 

...

> > +proc fetch_reggroups {test} {
> > +    global gdb_prompt
> > +    global expect_out
> > +
> > +    set reggroups {}
> > +    gdb_test_multiple "maint print reggroups" "get reggroups" {
> > +	-re "maint print reggroups\r\n" {
> > +	    exp_continue
> > +	}
> > +	-re "^ Group\[ \t\]+Type\[ \t\]+\r\n" {
> > +	    exp_continue
> > +	}
> > +	-re "^ (\[0-9a-zA-Z\-\]+)\[ \t\]+(user|internal)\[ \t\]+\r\n" {
> > +	    lappend reggroups $expect_out(1,string)
> > +	    exp_continue
> > +	}
> > +	-re ".*$gdb_prompt $" {
> 
> The .* should not be necessary here.

OK.

> > +	    if { [llength $reggroups] != 0 } {
> > +		pass $test
> > +	    } else {
> > +		fail "$test - didn't fetch any reggroups"
> > +	    }
> > +	}
> > +    }
> > +
> > +    return $reggroups
> > +}
> > +
> > +set reggroups [fetch_reggroups "fetch reggroups"]
> > +
> > +foreach reggroup $reggroups {
> > +    gdb_test "info reg $reggroup" ".*" "info reg $reggroup"
> > +}
> 
> This doesn't really test anything.  If you change the line to
> 
>   gdb_test "info reg hello$reggroup" ".*" "info reg $reggroup"
> 
> to fake that the command doesn't work, the test still passes.  So if
> something breaks the feature of "info registers" handling reg groups, the
> test won't catch it.  But I understand the problem, the output is not really
> predictable.  I thought about matching at least one $hex number, but it's
> not even guaranteed (some groups like mmx output nothing).
> 
> What we could do (I'm open to better suggestions) is at least validate that
> it doesn't output "Invalid register", which is the message given when
> passing a register that doesn't exist.  But then, if that message changes
> one day for some reason, the test will become moot again (because GDB will
> output something else than "Invalid register" if the functionality breaks,
> but the test won't catch it).  So in addition, we could also validate that
> "info registers a_non_existent_register" does output "Invalid register".
> This way, if some GDB developers of the future change the message, the test
> will fail, they will go look at your test file, read the comment that you
> will have left, and update the test accordingly.

Right, I will do this.   I will also try to match at least one $hex number
accross all reggroups.  Some will be blank, but if all are blank its probably an
issue.

-Stafford

