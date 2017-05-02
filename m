From: Yao Qi <qiyaoltc@gmail.com>
Date: Tue, 02 May 2017 15:40:20 +0100
Subject: [OpenRISC] [PATCH v6 1/5] tdesc: handle arbitrary strings in
	tdesc_register_in_reggroup_p
In-Reply-To: <dbd35ae7e8f9ca8db89dd14b81119d3eb50afb98.1493038197.git.shorne@gmail.com>
 (Stafford Horne's message of "Mon, 24 Apr 2017 21:52:50 +0900")
References: <cover.1493038197.git.shorne@gmail.com>
 <cover.1493038197.git.shorne@gmail.com>
 <dbd35ae7e8f9ca8db89dd14b81119d3eb50afb98.1493038197.git.shorne@gmail.com>
Message-ID: <86r307725n.fsf@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Stafford Horne <shorne@gmail.com> writes:

> tdesc_register_in_reggroup_p in now able to handle arbitrary
> groups. This is useful when groups are created while the
> target descriptor file is received from the remote.
>
> This can be the case of a soft core target processor where
> registers/groups can change.
>
> gdb/ChangeLog:
>
> 2013-02-15  Franck Jullien  <franck.jullien@gmail.com>
>
> 	* target-descriptions.c (tdesc_register_in_reggroup_p): Support
> 	arbitrary strings.

I am not sure what do you want to change and why do you need this
change?  I didn't see it in the previous version.

If you want to control what registers are displayed, you can follow the
way nds32 used, see nds32-tdep.c:nds32_register_reggroup_p.

-- 
Yao (齐尧)
