From: Yao Qi <qiyaoltc@gmail.com>
Date: Tue, 04 Apr 2017 22:32:51 +0100
Subject: [OpenRISC] [PATCH v5 4/4] Add gdb for or1k build
In-Reply-To: <e14cb9c471bb14d29f789b2af4b3bef85317c3dc.1489728533.git.shorne@gmail.com>
 (Stafford Horne's message of "Fri, 17 Mar 2017 14:43:20 +0900")
References: <cover.1489728533.git.shorne@gmail.com>
 <cover.1489728533.git.shorne@gmail.com>
 <e14cb9c471bb14d29f789b2af4b3bef85317c3dc.1489728533.git.shorne@gmail.com>
Message-ID: <86efx76epo.fsf@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Stafford Horne <shorne@gmail.com> writes:

> * ChangeLog:
>
> 	* configure.ac: remove logic adding gdb to noconfigsdirs for or1k
> 	* configure: regenerate

Once all the rest of patch series are OK, send this patch to
gcc-patches at .  Top-level configure is maintained there, and binutils-gdb
sync from gdb repository manually.

-- 
Yao (齐尧)
