From: Eli Zaretskii <eliz@gnu.org>
Date: Thu, 21 Dec 2017 05:40:41 +0200
Subject: [OpenRISC] [PATCH v3 1/4] reggroups: Add test and docs for
 `info reg $reggroup` feature
In-Reply-To: <596161e11663add8b95ca70dd1f8f12b@polymtl.ca> (message from Simon
 Marchi on Wed, 20 Dec 2017 21:40:10 -0500)
References: <20171219142257.13402-1-shorne@gmail.com>
 <20171219142257.13402-2-shorne@gmail.com> <837etiptz2.fsf@gnu.org>
 <596161e11663add8b95ca70dd1f8f12b@polymtl.ca>
Message-ID: <837etgoiiu.fsf@gnu.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

> Date: Wed, 20 Dec 2017 21:40:10 -0500
> From: Simon Marchi <simon.marchi@polymtl.ca>
> Cc: Stafford Horne <shorne@gmail.com>, gdb-patches at sourceware.org,
>         openrisc at lists.librecores.org
> 
> >> + at code{maint print reggroups}.
> > 
> > Please add here a cross-reference to the node where "maint print
> > reggroups" is described.
> 
> Is it ok for a non-maint command to refer to a maint command?

Yes.

> AFAIK, we don't expect an average user to have to use maintenance
> commands when using GDB.  So maybe "maint print reggroups" should be
> promoted to a non-maint command (e.g. info register-groups)?

Registers are not for the average user anyway, so I don't see a
problem here.
