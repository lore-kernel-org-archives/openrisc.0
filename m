From: Stafford Horne <shorne@gmail.com>
Date: Sat, 20 May 2017 15:42:25 +0900
Subject: [OpenRISC] [PATCH v6 1/5] tdesc: handle arbitrary strings in
 tdesc_register_in_reggroup_p
In-Reply-To: <86wp9qt9ty.fsf@gmail.com>
References: <cover.1493038197.git.shorne@gmail.com>
 <cover.1493038197.git.shorne@gmail.com>
 <dbd35ae7e8f9ca8db89dd14b81119d3eb50afb98.1493038197.git.shorne@gmail.com>
 <86r307725n.fsf@gmail.com>
 <20170502154115.GH2724@lianli.shorne-pla.net>
 <86wp9qt9ty.fsf@gmail.com>
Message-ID: <20170520064225.GA2940@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, May 09, 2017 at 02:54:01PM +0100, Yao Qi wrote:
> Stafford Horne <shorne@gmail.com> writes:
> 
> > This change is to also allow returning true in the case that the register
> > group was registered with gdb with reggroup_add().  This seems like
> > something that will be generally required so it was added to the
> > target-descriptions definition.  If you think not I can make it for
> > openrisc only, but I think it makes more sense in tdesc.
> 
> Thanks for the explanation.
> 
> >
> > This allows the command like, the below to return the registers for the
> > named reggroup.
> >
> >   info reg system
> 
> Some bits are missing,
> 
>  - A test case, in which we can define some reggroups "foo" and test
>    expected "foo" is shown in the output of "maintenance print
>    reggroups".  You can add reggroups in gdb.xml/extra-regs.xml.
> 
>  - A test case with live inferior, get a list of support reggroups from
>    the output of "maint print reggroups", pass each reggroup to "info
>    reg $group", and test there is no error.
> 
>  - Document "info registers".
>    https://sourceware.org/gdb/current/onlinedocs/gdb/Registers.html
>    doesn't document the usage "info reg GROUP".  We need to add it.
> 
>  - Add a news entry, because your patch adds a user visible change.

Right,

I am working on this, I have most of it done.  However, I am thinking to
submit this separately from the OpenRISC port.

There are more changes required to get this to work as you mention in the
(1st) test case above.  Currently tdesc supplied reggroups are not added by
default, they need to be manually supplied by calling reggroup_add().  I
have made a patch to make this automatic.

As mentioned I will split this out separate from the OpenRISC patch and do
all that is mentioned above.

-Stafford
