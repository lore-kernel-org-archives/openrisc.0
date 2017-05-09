From: Yao Qi <qiyaoltc@gmail.com>
Date: Tue, 09 May 2017 14:54:01 +0100
Subject: [OpenRISC] [PATCH v6 1/5] tdesc: handle arbitrary strings in
	tdesc_register_in_reggroup_p
In-Reply-To: <20170502154115.GH2724@lianli.shorne-pla.net> (Stafford Horne's
 message of "Wed, 3 May 2017 00:41:15 +0900")
References: <cover.1493038197.git.shorne@gmail.com>
 <cover.1493038197.git.shorne@gmail.com>
 <dbd35ae7e8f9ca8db89dd14b81119d3eb50afb98.1493038197.git.shorne@gmail.com>
 <86r307725n.fsf@gmail.com>
 <20170502154115.GH2724@lianli.shorne-pla.net>
Message-ID: <86wp9qt9ty.fsf@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Stafford Horne <shorne@gmail.com> writes:

> This change is to also allow returning true in the case that the register
> group was registered with gdb with reggroup_add().  This seems like
> something that will be generally required so it was added to the
> target-descriptions definition.  If you think not I can make it for
> openrisc only, but I think it makes more sense in tdesc.

Thanks for the explanation.

>
> This allows the command like, the below to return the registers for the
> named reggroup.
>
>   info reg system

Some bits are missing,

 - A test case, in which we can define some reggroups "foo" and test
   expected "foo" is shown in the output of "maintenance print
   reggroups".  You can add reggroups in gdb.xml/extra-regs.xml.

 - A test case with live inferior, get a list of support reggroups from
   the output of "maint print reggroups", pass each reggroup to "info
   reg $group", and test there is no error.

 - Document "info registers".
   https://sourceware.org/gdb/current/onlinedocs/gdb/Registers.html
   doesn't document the usage "info reg GROUP".  We need to add it.

 - Add a news entry, because your patch adds a user visible change.

-- 
Yao (齐尧)
