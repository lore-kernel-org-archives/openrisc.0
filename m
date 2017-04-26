From: Eli Zaretskii <eliz@gnu.org>
Date: Wed, 26 Apr 2017 08:59:29 +0300
Subject: [OpenRISC] [PATCH v6 2/5] gdb: Add OpenRISC or1k and or1knd
	target support
In-Reply-To: <ae4e2c7e3e9d364bf73adba1eedaeb3f4691d907.1493038197.git.shorne@gmail.com>
 (message from Stafford Horne on Mon, 24 Apr 2017 21:52:51 +0900)
References: <cover.1493038197.git.shorne@gmail.com>
 <cover.1493038197.git.shorne@gmail.com>
 <ae4e2c7e3e9d364bf73adba1eedaeb3f4691d907.1493038197.git.shorne@gmail.com>
Message-ID: <83d1bzpv3y.fsf@gnu.org>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

> From: Stafford Horne <shorne@gmail.com>
> Cc: Openrisc <openrisc@lists.librecores.org>,	Franck Jullien <franck.jullien@gmail.com>
> Date: Mon, 24 Apr 2017 21:52:51 +0900
> 
> +The OpenRISC 1000 provides a free and open RISC instruction set
> +architecture.

"Free" is a superset of "open", so I think you should leave only the
former in the text.  (It will also help us not to get in trouble with
RMS.)

OK for the documentation part, with the above fixed.

Thanks.
