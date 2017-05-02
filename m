From: Yao Qi <qiyaoltc@gmail.com>
Date: Tue, 02 May 2017 15:38:22 +0100
Subject: [OpenRISC] [PATCH v6 5/5] Add gdb for or1k build
In-Reply-To: <88149ed8048a13b6b57f006f0fd3063b9a1ec085.1493038197.git.shorne@gmail.com>
 (Stafford Horne's message of "Mon, 24 Apr 2017 21:52:54 +0900")
References: <cover.1493038197.git.shorne@gmail.com>
 <cover.1493038197.git.shorne@gmail.com>
 <88149ed8048a13b6b57f006f0fd3063b9a1ec085.1493038197.git.shorne@gmail.com>
Message-ID: <86vapj728x.fsf@gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

Stafford Horne <shorne@gmail.com> writes:

> 2017-02-12  Stafford Horne  <shorne@gmail.com>
>
> 	* configure.ac: remove logic adding gdb to noconfigsdirs for or1k

s/remove/Remove/
ended with ".".

> 	* configure: regenerate

Likewise.

Patch should be sent to gcc-patches at gcc.gnu.org, where top-level
configure are maintained.  You can post your patch there after all the
rest of patches are approved here.

-- 
Yao (齐尧)
