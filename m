From: Eli Zaretskii <eliz@gnu.org>
Date: Wed, 20 Dec 2017 17:53:52 +0200
Subject: [OpenRISC] [PATCH v3 4/4] tdesc: handle arbitrary strings in
 tdesc_register_in_reggroup_p
In-Reply-To: <20171219221300.GB32243@lianli.shorne-pla.net> (message from
 Stafford Horne on Wed, 20 Dec 2017 07:13:00 +0900)
References: <20171219142257.13402-1-shorne@gmail.com>
 <20171219142257.13402-5-shorne@gmail.com>
 <836092ptsa.fsf@gnu.org> <20171219221300.GB32243@lianli.shorne-pla.net>
Message-ID: <83r2rpo0of.fsf@gnu.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

> Date: Wed, 20 Dec 2017 07:13:00 +0900
> From: Stafford Horne <shorne@gmail.com>
> Cc: gdb-patches at sourceware.org, openrisc at lists.librecores.org
> 
> > >  @item group
> > > -The register group to which this register belongs.  It must
> > > -be either @code{general}, @code{float}, or @code{vector}.  If no
> > > - at var{group} is specified, @value{GDBN} will not display the register
> > > -in @code{info registers}.
> > > +The register group to which this register belongs.  It can be one of the
> > > +standard register groups @code{general}, @code{float}, @code{vector} or an
> > > +arbitrary string.  The string should be limited to alphanumeric characters
> > > +and internal hyphens.  If no @var{group} is specified, @value{GDBN} will
> > 
> > What do you mean by "internal hyphens"?
> 
> This means, hyphens withing the register group name, not starting or ending with
> hyphens.  (i.e. special-spr,  but not rg1- or -rg2)

Then I think this text needs to be rephrased, so that it first says
what are the characters allowed in a reggroup name, and then says that
ranges of groups, with 2 group names separated by hyphens, are also
accepted.

Thanks.
