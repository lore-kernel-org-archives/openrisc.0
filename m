From: Richard Henderson <rth@twiddle.net>
Date: Thu, 4 Oct 2018 07:55:43 -0500
Subject: [OpenRISC] [PATCH v2 0/5] OpenRISC binutils updates and new
	relocs
In-Reply-To: <20181004025846.GD32353@lianli.shorne-pla.net>
References: <20181001071001.20446-1-shorne@gmail.com>
 <70baf6b8-d26c-f518-78e5-48a6ad47ce54@redhat.com>
 <20181004025846.GD32353@lianli.shorne-pla.net>
Message-ID: <90148d16-f751-2935-4a3e-f5de2de62513@twiddle.net>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On 10/3/18 9:58 PM, Stafford Horne wrote:
> This issue was with the new overflow added which was thinking that OpenRISC was
> a 64-bit system.  I replaced it with the generic stuff which uses the bit width
> of the target system not host system (i.e. bfd_vma) for overflow calculations.

That looks like the right change.
I don't know what I maight have been thinking otherwise.


r~
