From: Stafford Horne <shorne@gmail.com>
Date: Wed, 3 May 2017 00:41:15 +0900
Subject: [OpenRISC] [PATCH v6 1/5] tdesc: handle arbitrary strings in
 tdesc_register_in_reggroup_p
In-Reply-To: <86r307725n.fsf@gmail.com>
References: <cover.1493038197.git.shorne@gmail.com>
 <cover.1493038197.git.shorne@gmail.com>
 <dbd35ae7e8f9ca8db89dd14b81119d3eb50afb98.1493038197.git.shorne@gmail.com>
 <86r307725n.fsf@gmail.com>
Message-ID: <20170502154115.GH2724@lianli.shorne-pla.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Tue, May 02, 2017 at 03:40:20PM +0100, Yao Qi wrote:
> Stafford Horne <shorne@gmail.com> writes:
> 
> > tdesc_register_in_reggroup_p in now able to handle arbitrary
> > groups. This is useful when groups are created while the
> > target descriptor file is received from the remote.
> >
> > This can be the case of a soft core target processor where
> > registers/groups can change.
> >
> > gdb/ChangeLog:
> >
> > 2013-02-15  Franck Jullien  <franck.jullien@gmail.com>
> >
> > 	* target-descriptions.c (tdesc_register_in_reggroup_p): Support
> > 	arbitrary strings.
> 
> I am not sure what do you want to change and why do you need this
> change?  I didn't see it in the previous version.
> 
> If you want to control what registers are displayed, you can follow the
> way nds32 used, see nds32-tdep.c:nds32_register_reggroup_p.

Hi Yao,

Thanks for reviewing.  Sorry, this was in previous versions but dropped on
accident then added back, I forgot to mention.

Currenly tdesc_register_in_reggroup_p() only returns true if the register
group number is one of the hard coded reggroups: float, vector, general,
save or restor.

This change is to also allow returning true in the case that the register
group was registered with gdb with reggroup_add().  This seems like
something that will be generally required so it was added to the
target-descriptions definition.  If you think not I can make it for
openrisc only, but I think it makes more sense in tdesc.

This allows the command like, the below to return the registers for the
named reggroup.

  info reg system

-Stafford
