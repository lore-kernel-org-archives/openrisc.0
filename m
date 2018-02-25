From: Richard Henderson <rth@twiddle.net>
Date: Sun, 25 Feb 2018 11:39:36 -0800
Subject: [OpenRISC] Removing architectures without upstream gcc support
In-Reply-To: <20180223181943.GF30522@ZenIV.linux.org.uk>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222234833.GA3047@roeck-us.net>
 <CAK8P3a3Y2b-DivYz1ZqhFGUqQaiF=5SDB6RFLtCknwY2--09OQ@mail.gmail.com>
 <20180223154316.35b26857@alans-desktop> <20180223171019.GA1125@roeck-us.net>
 <20180223181943.GF30522@ZenIV.linux.org.uk>
Message-ID: <e49978cd-3a68-85f3-0f2c-36b10076f9b9@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 02/23/2018 10:19 AM, Al Viro wrote:
> For m68k,
> IIRC, qemu is mostly for coldfire and friends with aranym
> working for m68k/MMU testing.

Laurent Vivier is in the process of fixing that upstream, it won't all make
qemu 2.12.  He has a branch with full support for a Mac Quadra 800:

  https://github.com/vivier/qemu-m68k/tree/q800-dev


r~
