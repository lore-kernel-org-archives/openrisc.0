From: Yao Qi <qiyaoltc@gmail.com>
Date: Tue, 04 Apr 2017 22:29:55 +0100
Subject: [OpenRISC] [PATCH v5 3/4] gdb: testsuite: Add or1k l.nop
	inscruction
In-Reply-To: <d3d7f61042f7fdd9aa8cea88524249acfd43841b.1489728533.git.shorne@gmail.com>
 (Stafford Horne's message of "Fri, 17 Mar 2017 14:43:19 +0900")
References: <cover.1489728533.git.shorne@gmail.com>
 <cover.1489728533.git.shorne@gmail.com>
 <d3d7f61042f7fdd9aa8cea88524249acfd43841b.1489728533.git.shorne@gmail.com>
Message-ID: <86inmj6euk.fsf@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Stafford Horne <shorne@gmail.com> writes:

> gdb/testsuite/ChangeLog:
>
> 2016-05-11  Stafford Horne  <shorne@gmail.com>
>
> 	* gdb.base/bp-permanent.c: Define nop of or1k.

The patch is good to me, but do you need to add or1k in
gdb.xml/tdesc-regs.exp?

-- 
Yao (齐尧)
